/// Returns the abbreviations in [column]: a comma-separated list, or none if [column] is `null`
List<String> abbreviationsOf(String? column) => List.unmodifiable(
  (column ?? '').split(',').where((abbreviation) => abbreviation.isNotEmpty),
);
