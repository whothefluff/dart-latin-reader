# Two works by one author

The test `test/src/external/db_util_test.dart` loads these CSV files into a database. The script `tool/generate_two_works_fixture.py` writes them. Don't edit them by hand: the test checks the app's import code against what the producer really writes.

## Where the files come from

These files come from the producer (python-latin-sources-processor), at commit `bcb14f1269dc853148a24af524c77613c6f3e4b6`: `author_abbreviations.csv`, `authors.csv`, `authors_and_works.csv`, `unambiguous_macronizations.csv`, `work_abbreviations.csv`, `work_content_subdivisions.csv`, `work_content_supplementary.csv`, `work_contents.csv`, `work_macronizations.csv`, `works.csv`.

The producer has two small invented works in `tests/library/fixtures/two_works_by_one_author`. The script runs the producer's own code for combining works over them, one at a time: first `carmina_prima`, then `carmina_altera` added to it.

The other files come from this repository's `assets/preprocessed_data`. The script copies only the rows that the two works need, without changing them:

- `morphological_details.csv` (14 rows): the analyses of the works' words, whatever their capital letters.
- `morphological_detail_inflections.csv` (40 rows): the inflections of those analyses.
- `dictionaries.csv` (1 row): the whole file.
- `dictionary_entries.csv` (17 rows): the dictionary entries of those analyses' lemmas, and the other entries with the same headword.
- `dict_entry_senses.csv` and `dict_entry_sense_quotes.csv`: only the first line (the quotes file is empty).

## Updating these files

Run the script again when the producer changes:

- the columns of its CSV files (the test fails until you do),
- the way it combines several works into one set of files, or
- its two invented works.

You don't need to run it when only the data changes: for example when you add a work, generate a work again, or get new morphology or dictionary rows. That said, adding a work often comes with changes to the producer that can be one of the reasons above.

To run it:

1. Get the producer's code at the commit you want, and install its requirements (`pip install -r requirements.txt`).
2. From this repository, run:

   ```sh
   python3 tool/generate_two_works_fixture.py <path to the producer>
   ```

3. If the files changed, change the expected rows in `test/src/external/db_util_test.dart` to match.
4. Commit the files and the test together.
