"""Writes test/fixtures/two_works_by_one_author: the producer's aggregate of its two-work fixture, and the rows of
assets/preprocessed_data that the works' words need, copied as they are.

Usage, with the producer's requirements installed:
    python3 tool/generate_two_works_fixture.py <producer checkout>
"""
import argparse
import csv
import importlib
import io
import logging
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path
from typing import Callable, Dict, Iterable, List, NamedTuple, cast

READER = Path(__file__).resolve().parents[1]
ASSETS = Path('assets') / 'preprocessed_data'
FIXTURE = Path('test') / 'fixtures' / 'two_works_by_one_author'
PRODUCER_FIXTURE = Path('tests') / 'library' / 'fixtures' / 'two_works_by_one_author'
#: Aggregated one at a time, in this order, which decides the id that their author keeps
WORKS = ('carmina_prima', 'carmina_altera')
#: Files that the database's population reads but that nothing for the works' words needs
HEADER_ONLY = ('dict_entry_senses.csv', 'dict_entry_sense_quotes.csv')


class Table(NamedTuple):
    header: List[str]
    rows: List[List[str]]

    def column(self, name: str) -> int:
        return self.header.index(name)


class ErrorLog(logging.Handler):
    """The errors logged while it's attached: the aggregate logs why it saves nothing, and returns"""

    def __init__(self) -> None:
        super().__init__(logging.ERROR)
        self.messages: List[str] = []

    def emit(self, record: logging.LogRecord) -> None:
        self.messages.append(record.getMessage())


def git(repo: Path, *args: str) -> str:
    return subprocess.run(['git', '-C', str(repo), *args], check=True, capture_output=True, text=True).stdout.strip()


def require_committed(repo: Path) -> None:
    changes = git(repo, 'status', '--porcelain')
    if changes:
        raise SystemExit(f'{repo} has uncommitted changes, so the fixture couldn\'t name its source:\n{changes}')


def csv_text(rows: Iterable[List[str]]) -> str:
    text = io.StringIO(newline='')
    csv.writer(text, lineterminator='\n').writerows(rows)
    return text.getvalue()


def read_table(path: Path) -> Table:
    """A CSV file's rows, checked to come back as the same text when written again"""
    text = path.read_text(encoding='utf-8')
    rows = list(csv.reader(io.StringIO(text, newline='')))
    if csv_text(rows) != text:
        raise SystemExit(f'{path} can\'t be copied row by row without changing its text')
    return Table(rows[0], rows[1:])


def write_table(path: Path, header: List[str], rows: List[List[str]]) -> None:
    path.write_text(csv_text([header, *rows]), encoding='utf-8', newline='')


def headword(lemma: str) -> str:
    """The lemma without the number that tells homographs apart"""
    return re.sub(r'\d+$', '', lemma)


def aggregate_works(producer: Path, output_dir: Path) -> None:
    sys.path.insert(0, str(producer))
    module = importlib.import_module('scripts.library.process_library_aggregate')
    aggregate = cast(Callable[[Path, Path], None], getattr(module, 'aggregate'))
    logging.getLogger().setLevel(logging.WARNING)
    errors = ErrorLog()
    logging.getLogger().addHandler(errors)
    try:
        for work in WORKS:
            aggregate(producer / PRODUCER_FIXTURE / work, output_dir)
    finally:
        logging.getLogger().removeHandler(errors)
    if errors.messages:
        raise SystemExit('The aggregate saved nothing:\n' + '\n'.join(errors.messages))


def readme(producer_commit: str, library_files: List[str], counts: Dict[str, int]) -> str:
    library_list = ', '.join(f'`{name}`' for name in library_files)
    lines = [
        '# Two works by one author',
        '',
        'The test `test/src/external/db_util_test.dart` loads these CSV files into a database. The script '
        '`tool/generate_two_works_fixture.py` writes them. Don\'t edit them by hand: the test checks the app\'s import '
        'code against what the producer really writes.',
        '',
        '## Where the files come from',
        '',
        f'These files come from the producer (python-latin-sources-processor), at commit `{producer_commit}`: '
        f'{library_list}.',
        '',
        f'The producer has two small invented works in `{PRODUCER_FIXTURE.as_posix()}`. The script runs the '
        f'producer\'s own code for combining works over them, one at a time: first `{WORKS[0]}`, then `{WORKS[1]}` '
        'added to it.',
        '',
        f'The other files come from this repository\'s `{ASSETS.as_posix()}`. The script copies only the rows that the '
        'two works need, without changing them:',
        '',
        f'- `morphological_details.csv` ({counts["morphological_details.csv"]} rows): the analyses of the works\' '
        'words, whatever their capital letters.',
        f'- `morphological_detail_inflections.csv` ({counts["morphological_detail_inflections.csv"]} rows): the '
        'inflections of those analyses.',
        f'- `dictionaries.csv` ({counts["dictionaries.csv"]} row): the whole file.',
        f'- `dictionary_entries.csv` ({counts["dictionary_entries.csv"]} rows): the dictionary entries of those '
        'analyses\' lemmas, and the other entries with the same headword.',
        f'- {" and ".join(f"`{name}`" for name in HEADER_ONLY)}: only the first line (the quotes file is empty).',
        '',
        '## Updating these files',
        '',
        'Run the script again when the producer changes:',
        '',
        '- the columns of its CSV files (the test fails until you do),',
        '- the way it combines several works into one set of files, or',
        '- its two invented works.',
        '',
        'You don\'t need to run it when only the data changes: for example when you add a work, generate a work '
        'again, or get new morphology or dictionary rows. But adding a work often comes with changes to the producer, '
        'and those can be one of the reasons above.',
        '',
        'To run it:',
        '',
        '1. Get the producer\'s code at the commit you want, and install its requirements '
        '(`pip install -r requirements.txt`).',
        '2. From this repository, run:',
        '',
        '   ```sh',
        '   python3 tool/generate_two_works_fixture.py <path to the producer>',
        '   ```',
        '',
        '3. If the files changed, change the expected rows in `test/src/external/db_util_test.dart` to match.',
        '4. Commit the files and the test together.',
    ]
    return '\n'.join(lines) + '\n'


def generate(producer: Path) -> None:
    require_committed(producer)
    producer_commit = git(producer, 'rev-parse', 'HEAD')
    assets = READER / ASSETS
    with tempfile.TemporaryDirectory() as temporary:
        fixture = Path(temporary)
        aggregate_works(producer, fixture)
        library_files = sorted(path.name for path in fixture.glob('*.csv'))

        tokens = read_table(fixture / 'work_contents.csv')
        words = {token[tokens.column('word')].lower() for token in tokens.rows}
        details = read_table(assets / 'morphological_details.csv')
        form, item, dictionary_ref = (details.column(name) for name in ('form', 'item', 'dictionaryRef'))
        analyses = [row for row in details.rows if row[form].lower() in words]
        analysis_keys = {(row[form], row[item]) for row in analyses}
        headwords = {headword(row[dictionary_ref]) for row in analyses if row[dictionary_ref]}

        inflections = read_table(assets / 'morphological_detail_inflections.csv')
        inflection_form, inflection_item = (inflections.column(name) for name in ('form', 'item'))
        word_inflections = [row for row in inflections.rows
                            if (row[inflection_form], row[inflection_item]) in analysis_keys]
        entries = read_table(assets / 'dictionary_entries.csv')
        lemma = entries.column('lemma')
        word_entries = [row for row in entries.rows if headword(row[lemma]) in headwords]
        dictionaries = read_table(assets / 'dictionaries.csv')

        write_table(fixture / 'morphological_details.csv', details.header, analyses)
        write_table(fixture / 'morphological_detail_inflections.csv', inflections.header, word_inflections)
        write_table(fixture / 'dictionary_entries.csv', entries.header, word_entries)
        write_table(fixture / 'dictionaries.csv', dictionaries.header, dictionaries.rows)
        for name in HEADER_ONLY:
            with open(assets / name, encoding='utf-8', newline='') as asset:
                (fixture / name).write_text(asset.readline(), encoding='utf-8', newline='')
        counts = {'morphological_details.csv': len(analyses),
                  'morphological_detail_inflections.csv': len(word_inflections),
                  'dictionary_entries.csv': len(word_entries),
                  'dictionaries.csv': len(dictionaries.rows)}
        (fixture / 'README.md').write_text(readme(producer_commit, library_files, counts),
                                           encoding='utf-8', newline='')

        target = READER / FIXTURE
        shutil.rmtree(target, ignore_errors=True)
        shutil.copytree(fixture, target)
    print(f'Wrote {FIXTURE.as_posix()} from the producer at {producer_commit}')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Writes the reader\'s two-work import fixture.')
    parser.add_argument('producer', type=Path, help='a checkout of python-latin-sources-processor')
    generate(parser.parse_args().producer.resolve())
