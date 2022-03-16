import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/note.dart';
import 'package:money_note/src/providers/providers.dart';

class NoteCategoryReportParam {
  DateTime dateTime;
  int categoryId;

  NoteCategoryReportParam(this.dateTime, this.categoryId);
}

class NoteCategoryReport extends StateNotifier<List<Note>> {
  Reader read;
  NoteCategoryReportParam param;

  NoteCategoryReport(this.read, this.param) : super([]) {
    state = read(noteRepositoryProvider).getNotesByMonthAndCategory(
      param.dateTime,
      param.categoryId,
    );
  }
}

final noteCategoryStateProvider = StateNotifierProvider.family<
    NoteCategoryReport, List<Note>, NoteCategoryReportParam>(
  (ref, param) => NoteCategoryReport(ref.read, param),
);
