import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';

const String windowsLineEnding = '\r\n';
const String unixLineEnding = '\n';
const String oldMacLineEnding = '\r';

extension type const CsvParser(CsvToListConverter c) implements CsvToListConverter {
  const CsvParser.withAutoDetectedSettings()
    : this(
        const CsvToListConverter(
          csvSettingsDetector: FirstOccurrenceSettingsDetector(
            eols: [
              windowsLineEnding,
              unixLineEnding,
              oldMacLineEnding,
            ],
          ),
        ),
      );
}
