/// A lemma with its homograph number raised, as dictionaries print it:
/// sum1 is sum¹
String lemmaText(String lemma) => lemma.replaceAllMapped(
  RegExp(r'\d+$'),
  (match) => match[0]!.split('').map((digit) => _superscripts[int.parse(digit)]).join(),
);

const List<String> _superscripts = ['⁰', '¹', '²', '³', '⁴', '⁵', '⁶', '⁷', '⁸', '⁹'];
