import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/monthly_report.dart';
import 'package:money_note/src/providers/providers.dart';

class MonthlyReportState extends StateNotifier<MonthlyReport> {
  MonthlyReportState(this.read, this.date) : super(MonthlyReport()) {
    final repo = read(noteRepositoryProvider);
    state = repo.getMonthlyReport(date);
  }

  Reader read;
  DateTime date;
}

final monthlyReportStateProvider =
    StateNotifierProvider.family<MonthlyReportState, MonthlyReport, DateTime>(
  (ref, date) => MonthlyReportState(ref.read, date),
);
