/// Sentence-ending punctuation, + the colon, which can open a quote.
const sentenceBreakPunctSigns = ['.', '!', '?', ':'];

/// Punctuation that ends a sentence or clause, or closes a parenthesis or bracket.
const List<String> closingPunctSigns = [...sentenceBreakPunctSigns, ',', ';', ')', ']'];
