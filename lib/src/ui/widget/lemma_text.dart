/// Returns [entryRef] with its homograph number raised, as dictionaries print it: sum1 is sum¹.
String entryRefText(String entryRef) => entryRef.replaceAllMapped(
  RegExp(r'\d+$'),
  (match) => match[0]!.split('').map((digit) => _superscripts[int.parse(digit)]).join(),
);

/// Returns a lemma's label: a sublemma with its entry, or the entry alone for its own lemma.
String lemmaLabel(String entryRef, String sublemma) =>
    sublemma.isEmpty ? entryRefText(entryRef) : '$sublemma · under ${entryRefText(entryRef)}';

const List<String> _superscripts = ['⁰', '¹', '²', '³', '⁴', '⁵', '⁶', '⁷', '⁸', '⁹'];
