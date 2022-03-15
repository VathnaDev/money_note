import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/objectbox.g.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/note.dart';
import 'package:money_note/src/riverpod/providers.dart';
import 'package:objectbox/internal.dart';

class NoteFilter {
  DateTime? date;
  String? type;
  Category? category;

  NoteFilter({this.date, this.type, this.category});
}

class NotesState extends StateNotifier<List<Note>> {
  NotesState(this.read, this.filter) : super([]) {
    state = [..._queryNotes()];
  }

  Reader read;
  NoteFilter? filter;

  void add(Note note) {
    read(storeProvider).box<Note>().put(note);
    state = [..._queryNotes()];
  }

  void remove(int id) {
    read(storeProvider).box<Note>().remove(id);
    state = [..._queryNotes()];
  }

  List<Note> _queryNotes() {
    Condition<Note>? condition;
    if(filter != null && filter?.type != null) {
      condition = Note_.type.equals(filter!.type!);
    }

    return read(storeProvider)
        .box<Note>()
        .query(condition)
        .build()
        .find();
  }
}

final notesStateProvider =
    StateNotifierProvider.family<NotesState, List<Note>, NoteFilter?>(
        (ref, filter) => NotesState(ref.read, filter));
