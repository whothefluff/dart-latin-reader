// ignore_for_file: avoid_print since it's not part of the app

import 'dart:convert';
import 'dart:io';

/// Run this script from your terminal:
/// *dart run tool/generate_fonts.dart*
void main() async {
  print('Fetching Google Fonts metadata...');
  final client = HttpClient();
  try {
    final url = Uri.parse('https://fonts.google.com/metadata/fonts');
    final request = await client.getUrl(url);
    final response = await request.close();
    if (response.statusCode == 200) {
      final rawData = await response.transform(utf8.decoder).join();
      // Google prefixes their JSON APIs with this string to prevent CSRF.
      final cleanData = rawData.replaceFirst(RegExp(r"^\)\]\}'\n"), '');
      final json = jsonDecode(cleanData) as Map<String, dynamic>;
      final families = (json['familyMetadataList'] as List).cast<Map<String, dynamic>>();
      print('Found ${families.length} fonts.');
      final latinExtFonts = families
          .where((f) => ((f['subsets'] as List?)?.cast<String>() ?? []).contains('latin-ext'))
          .map((f) => f['family'] as String)
          .toList();
      print('Found ${latinExtFonts.length} fonts supporting Latin Extended (macrons).');
      final fileContent =
          '''
// GENERATED FILE - DO NOT EDIT BY HAND
// Run `dart run tool/generate_fonts.dart` to update this list.

const Set<String> latinExtFonts = {
${latinExtFonts.map((f) => "  '$f',").join('\n')}
};
''';
      final file = File('lib/src/core/latin_ext_fonts.dart');
      await file.writeAsString(fileContent);
      print('Successfully wrote to ${file.path}');
    } else {
      throw Exception('HTTP ${response.statusCode} error');
    }
  } finally {
    client.close();
  }
}
