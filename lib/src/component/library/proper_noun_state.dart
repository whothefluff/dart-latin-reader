import 'package:drift/drift.dart' show TypeConverter;

//infrastructure

/// Stores a [ProperNounState] as its [ProperNounState.code]
class ProperNounStateConverter extends TypeConverter<ProperNounState, int> {
  const ProperNounStateConverter();

  @override
  ProperNounState fromSql(int fromDb) => ProperNounState.fromCode(fromDb);

  @override
  int toSql(ProperNounState value) => value.code;
  //
}

//domain

enum ProperNounState {
  common(0),
  proper(1),
  either(2);

  const ProperNounState(this.code);

  /// Throws a [StateError] for a code the table's CHECK would reject
  factory ProperNounState.fromCode(int code) => values.firstWhere((state) => state.code == code);

  /// The value stored in WorkContents.properNounState
  final int code;
}
