import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/objectbox.g.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/data/monthly_report.dart';
import 'package:money_note/src/data/note.dart';
import 'package:money_note/src/providers/providers.dart';

class NoteRepository {
  final Reader read;

  NoteRepository(this.read);

  List<Note> getNotesByMonthAndCategory(DateTime date, int categoryId) {
    final db = read(storeProvider).box<Note>();
    final start = DateTime(date.year, date.month, 1);
    final end = DateTime(date.year, date.month, 31);

    final notes = db
        .query(
          Note_.date
              .between(
                start.millisecondsSinceEpoch,
                end.millisecondsSinceEpoch,
              )
              .and(
                Note_.category.equals(categoryId),
              ),
        )
        .build();
    return notes.find();
  }

  MonthlyReport getMonthlyReport(DateTime date) {
    final db = read(storeProvider).box<Note>();
    final start = DateTime(date.year, date.month, 1);
    final end = DateTime(date.year, date.month, 31);

    final condition = Note_.date
        .between(start.millisecondsSinceEpoch, end.millisecondsSinceEpoch);

    final balanceQuery = db.query().build();
    final balance = balanceQuery.property(Note_.amount).sum();

    final incomeQuery = db
        .query(condition.and(Note_.type.equals(InputType.income.name)))
        .build();
    final income = incomeQuery.property(Note_.amount).sum();
    final incomeNotes = incomeQuery.find();

    final expenseQuery = db
        .query(condition.and(Note_.type.equals(InputType.expense.name)))
        .build();
    final expense = expenseQuery.property(Note_.amount).sum();
    final expenseNotes = expenseQuery.find();

    final preStart = DateTime(date.year, date.month - 1, 1);
    final preEnd = DateTime(date.year, date.month - 1, 31);
    final preMonthBalance = db
        .query(Note_.date.between(
            preStart.millisecondsSinceEpoch, preEnd.millisecondsSinceEpoch))
        .build()
        .property(Note_.amount)
        .sum();

    return MonthlyReport(
      income: income,
      expense: expense,
      currentBalance: balance,
      incomeNotes: incomeNotes,
      expenseNotes: expenseNotes,
      expenseIncome: income - expense,
      previousBalance: preMonthBalance,
      notes: [...incomeNotes, ...expenseNotes],
    );
  }
}
