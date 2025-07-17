import 'package:drift/drift.dart';

Value<String> stringValue(String string) => string.isEmpty ? const Value.absent() : Value(string);
