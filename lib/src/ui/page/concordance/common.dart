import 'package:collection/collection.dart';

import '../../../component/concordance/concordance_query.dart';
import '../../../component/library/catalog_api.dart';
import '../../../component/word_frequency/library_selection_api.dart';

String sortLabel(ConcordanceSort sort) => switch (sort) {
  ConcordanceSort.textOrder => 'Text order',
  ConcordanceSort.followingWord => 'Following word',
  ConcordanceSort.precedingWord => 'Preceding word',
};

String titlesLabel(ConcordanceTitles titles) => switch (titles) {
  ConcordanceTitles.included => 'Included',
  ConcordanceTitles.excluded => 'Left out',
  ConcordanceTitles.only => 'Only titles',
};

String featureLabel(GrammarFeature feature) => switch (feature) {
  GrammarFeature.partOfSpeech => 'Part of speech',
  GrammarFeature.gramCase => 'Case',
  GrammarFeature.number => 'Number',
  GrammarFeature.gender => 'Gender',
  GrammarFeature.person => 'Person',
  GrammarFeature.verbForm => 'Verb form',
  GrammarFeature.tense => 'Tense',
  GrammarFeature.voice => 'Voice',
};

/// A value as stored (ablative, future perfect), capitalized
String grammarValueLabel(String value) =>
    value.isEmpty ? value : '${value[0].toUpperCase()}${value.substring(1)}';

/// [values] in the order grammars list them (nominative before genitive),
/// anything else alphabetically after them
List<String> grammarOrder(Iterable<String> values) {
  int rank(String value) {
    final index = _grammarOrder.indexOf(value);
    return index < 0 ? _grammarOrder.length : index;
  }

  return values.sorted((a, b) => rank(a) == rank(b) ? a.compareTo(b) : rank(a) - rank(b));
}

const List<String> _grammarOrder = [
  'nominative', 'genitive', 'dative', 'accusative', 'ablative', 'vocative', 'locative', //
  'singular', 'plural',
  'masculine', 'feminine', 'neuter',
  '1st', '2nd', '3rd',
  'indicative', 'subjunctive', 'imperative', 'infinitive', 'participle', 'gerund', 'gerundive',
  'supine',
  'present', 'imperfect', 'future', 'perfect', 'pluperfect', 'future perfect',
  'active', 'passive',
];

/// A lemma with its homograph number raised, as dictionaries print it: sum1
/// is sum¹
String lemmaText(String label) => label.replaceAllMapped(
  RegExp(r'\d+$'),
  (match) => match[0]!.split('').map((digit) => _superscripts[int.parse(digit)]).join(),
);

const List<String> _superscripts = ['⁰', '¹', '²', '³', '⁴', '⁵', '⁶', '⁷', '⁸', '⁹'];

/// What the dictionary says of [lemma], to tell homographs apart
String lemmaDetails(LemmaChoice lemma) {
  final details = [lemma.partOfSpeech, lemma.inflection].nonNulls.join(' · ');
  return details.isEmpty ? 'Not in Lewis & Short' : details;
}

/// "All authors & works", or "2 sources, 7 works"
String selectionSummary(LibrarySelection selection) {
  final works = selection.allWorkIds.length;
  final sources = selection.sourceCount;
  return selection.isEmpty
      ? 'All authors & works'
      : '$sources source${sources == 1 ? '' : 's'}, $works work${works == 1 ? '' : 's'}';
}

/// "Author · Work" (or just the work, without an author) by work ID
Map<String, String> workLabels(LibraryCatalog catalog) {
  final authorsByWork = groupBy(
    catalog.authors.expand((author) => author.works.map((work) => (work: work, author: author))),
    (entry) => entry.work,
  );
  return {
    ...Map.fromEntries(
      authorsByWork.entries.map(
        (entry) => MapEntry(
          entry.key.id,
          '${entry.value.map((e) => e.author.name).join(' & ')} · ${entry.key.name}',
        ),
      ),
    ),
    ...Map.fromEntries(catalog.anonymousWorks.map((work) => MapEntry(work.id, work.name))),
  };
}

/// The words of [query], e.g. “lupus” + sum¹ (lemma, within 3 words)
String describePhrase(ConcordanceQuery query) => query.slots
    .mapIndexed((i, slot) {
      final distance = i == 0 ? null : _distanceText(query.distanceBefore(i));
      return switch (slot) {
        FormCriterion(:final text, :final exactCase) =>
          '“${text.trim()}”${_notes([if (exactCase) 'exact case', ?distance])}',
        LemmaCriterion(:final lemma) => '${lemmaText(lemma.label)}${_notes(['lemma', ?distance])}',
        GrammarCriterion(:final grammar, :final lemma) =>
          '${_grammarText(grammar)}'
              '${lemma == null ? '' : ' of ${lemmaText(lemma.label)}'}'
              '${_notes(['grammar', ?distance])}',
      };
    })
    .join(' + ');

/// Where and how [query] searches, e.g. All authors & works · macrons · following word
String describeScope(ConcordanceQuery query) => [
  query.part?.label ?? selectionSummary(query.selection),
  if (query.matchMacrons) 'macrons',
  ?_titlesNote(query.titles),
  if (query.sort != ConcordanceSort.textOrder) 'by ${sortLabel(query.sort).toLowerCase()}',
].join(' · ');

/// e.g. verb, subjunctive, 1st: the part of speech, then the rest as grammars
/// order them
String _grammarText(GrammarFilter grammar) {
  final partOfSpeech = grammar.values[GrammarFeature.partOfSpeech];
  final others = grammar.values.entries
      .where((entry) => entry.key != GrammarFeature.partOfSpeech)
      .map((entry) => entry.value);
  final text = [?partOfSpeech, ...grammarOrder(others)].join(', ');
  return text.isEmpty ? 'any form' : text;
}

String? _titlesNote(ConcordanceTitles titles) => switch (titles) {
  ConcordanceTitles.included => null,
  ConcordanceTitles.excluded => 'no titles',
  ConcordanceTitles.only => 'titles only',
};

String? _distanceText(int? distance) => switch (distance) {
  1 => null,
  null => 'same sentence',
  final words => 'within $words words',
};

String _notes(List<String> notes) => notes.isEmpty ? '' : ' (${notes.join(', ')})';
