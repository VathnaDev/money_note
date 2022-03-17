import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/monthly_report.dart';
import 'package:money_note/src/data/note.dart';
import 'package:money_note/src/providers/providers.dart';

class MonthlyReportState extends StateNotifier<MonthlyReport> {
  Ref ref;

  MonthlyReportState(this.ref) : super(MonthlyReport()) ;

  void fetchReport(DateTime date){
    ref.watch(storeProvider).box<Note>().query().watch().listen((event) {
      final repo = ref.watch(noteRepositoryProvider);
      state = repo.getMonthlyReport(date);
    });

    final repo = ref.watch(noteRepositoryProvider);
    state = repo.getMonthlyReport(date);
  }

}

final monthlyReportStateProvider =
    StateNotifierProvider.autoDispose<MonthlyReportState, MonthlyReport>(
  (ref) => MonthlyReportState(ref),
);
