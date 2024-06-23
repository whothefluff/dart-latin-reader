import 'package:collection/collection.dart';
import 'package:latin_reader/src/component/library/usecase/entity/work_note.dart';

abstract interface class WorkNotes {
  WorkNotes({
    required this.notes,
  });

  final UnmodifiableListView<WorkNote> notes;

  @override
  String toString() {
    return 'WorkNotes{${notes.join(',')}}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WorkNotes) return false;
    return _defaultListEquality().equals(notes, other.notes);
  }

  @override
  int get hashCode => _defaultListEquality().hash(notes);

  ListEquality<WorkNote> _defaultListEquality() {
    const listEquality = ListEquality<WorkNote>(DefaultEquality());
    return listEquality;
  }
//
}
