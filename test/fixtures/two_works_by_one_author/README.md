# Two works by one author

The CSV files that `test/src/external/db_util_test.dart` populates a database from, written by `tool/generate_two_works_fixture.py`. Don't edit them by hand.

## From the producer, at `2a98611`

`author_abbreviations.csv`, `authors.csv`, `authors_and_works.csv`, `unambiguous_macronizations.csv`, `work_abbreviations.csv`, `work_content_subdivisions.csv`, `work_content_supplementary.csv`, `work_contents.csv`, `work_macronizations.csv`, `works.csv`: the aggregate of the producer's `tests/library/fixtures/two_works_by_one_author`, with `carmina_prima` aggregated first and `carmina_altera` added to it.

## From the reader's `assets/preprocessed_data`, at `fa9d777`

Rows copied as they are:

- `morphological_details.csv` (14 rows): the rows whose form is one of the works' words, case aside.
- `morphological_detail_inflections.csv` (40 rows): the inflections of those rows.
- `dictionaries.csv` (1 row): the whole file.
- `dictionary_entries.csv` (17 rows): the entries whose headword (the lemma without its number) is the headword of one of those rows' `dictionaryRef`.
- `dict_entry_senses.csv`, `dict_entry_sense_quotes.csv`: the header only (the quotes file has none).

## Generating it again

With the producer's requirements installed:

```sh
python3 tool/generate_two_works_fixture.py <producer checkout>
```
