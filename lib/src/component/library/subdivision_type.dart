import 'package:drift/drift.dart' show TypeConverter;

//infrastructure

/// Stores a [SubdivisionType] as its [SubdivisionType.code]
class SubdivisionTypeConverter extends TypeConverter<SubdivisionType, String> {
  const SubdivisionTypeConverter();

  @override
  SubdivisionType fromSql(String fromDb) => SubdivisionType.fromCode(fromDb);

  @override
  String toSql(SubdivisionType value) => value.code;
  //
}

//domain

/// What a row of `WorkContentSubdivisions` represents
enum SubdivisionType {
  book('BOOK'),
  prologue('PROL'),
  poem('POEM'),
  epilogue('EPIL'),
  title('TITL'),
  verse('VERS'),
  paragraph('PARA');

  const SubdivisionType(this.code);

  /// Throws a [StateError] for a code the table's CHECK would reject
  factory SubdivisionType.fromCode(String code) => values.firstWhere((type) => type.code == code);

  /// The value stored in WorkContentSubdivisions.typ
  final String code;
}
