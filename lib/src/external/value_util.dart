import 'package:drift/drift.dart';

Value<String> stringValue(String string) => string.isEmpty ? const Value.absent() : Value(string);

Value<int?> intValue(String rawInt) =>
    rawInt.isEmpty ? const Value.absent() : Value(int.parse(rawInt));
