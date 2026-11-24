/// Sentence-ending punctuation, + the colon, which can open a quote.
const sentenceBreakPunctSigns = ['.', '!', '?', ':'];

/// Punctuation that ends a sentence or clause, or closes a parenthesis or bracket.
const List<String> closingPunctSigns = [...sentenceBreakPunctSigns, ',', ';', ')', ']'];

const openingQuotationMarks = ['“', '‘', '«'];
const closingQuotationMarks = ['”', '’', '»'];
const apostrophe = "'";
const List<String> signsWithoutSpaceBefore = [
  ...closingPunctSigns,
  ...closingQuotationMarks,
  apostrophe,
];

/// Returns `true` when [sign] and the words around it correspond to something like `locutu's`.
bool isContractionApostrophe(
  String sign, {
  required bool wordBeforeHasExpansion,
  required bool wordAfterHasExpansion,
}) => wordBeforeHasExpansion && sign == apostrophe && wordAfterHasExpansion;
