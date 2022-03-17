import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/note.dart';
import 'package:money_note/src/providers/providers.dart';

class NoteCategoryReport extends StateNotifier<List<Note>> {
  Ref ref;

  NoteCategoryReport(this.ref) : super([]);

  void fetchNotes(DateTime dateTime, int categoryId) {
    ref.watch(storeProvider).box<Note>().query().watch().listen((event) {
      state = ref
          .watch(noteRepositoryProvider)
          .getNotesByMonthAndCategory(dateTime, categoryId);
    });

    state = ref
        .watch(noteRepositoryProvider)
        .getNotesByMonthAndCategory(dateTime, categoryId);
  }
}

final noteCategoryStateProvider =
    StateNotifierProvider.autoDispose<NoteCategoryReport, List<Note>>(
  (ref) => NoteCategoryReport(ref),
);
