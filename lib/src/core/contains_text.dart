/// Whether [text], trimmed, is part of any of [values], whatever the case and the macrons
bool containsText(Iterable<String> values, String text) {
  final plainText = _plain(text.trim());
  return values.any((value) => _plain(value).contains(plainText));
}

/// [value] in lowercase and without macrons
String _plain(String value) =>
    value.toLowerCase().replaceAllMapped(_macrons, (macron) => _unmacronized[macron[0]]!);

final _macrons = RegExp('[āēīōūȳ]');

const _unmacronized = {'ā': 'a', 'ē': 'e', 'ī': 'i', 'ō': 'o', 'ū': 'u', 'ȳ': 'y'};
