import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_note/src/data/note.dart';

part 'monthly_report.freezed.dart';

@freezed
class MonthlyReport with _$MonthlyReport {
  factory MonthlyReport({
   @Default(0) double currentBalance,
   @Default(0) double income,
   @Default(0) double expense,
   @Default(0) double expenseIncome,
   @Default(0) double previousBalance,
   @Default([]) List<Note> notes,
   @Default([]) List<Note> expenseNotes,
   @Default([]) List<Note> incomeNotes,
  }) = _MonthlyReport;
}