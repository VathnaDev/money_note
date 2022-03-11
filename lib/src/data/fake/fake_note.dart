import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/data/note.dart';
import 'package:money_note/src/utils/constants.dart';

final fakeNotes = [
  Note(
    id: "1",
    date: 1,
    amount: 10.2,
    note: "Buy New Phone",
    category: expenseCategories.first,
    type: InputType.expense,
  ),
  Note(
    id: "1",
    date:2,
    amount: 10.2,
    category: expenseCategories[1],
    type: InputType.income,
  ),
  Note(
    id: "1",
    date: 3,
    amount: 10.2,
    category: expenseCategories[2],
    type: InputType.expense,
  ),
  ...List.generate(
    20,
    (index) => Note(
      id: "1",
      date: 1 * index,
      amount: 10.2,
      category: allCategories[index],
      type: index % 2 == 0 ? InputType.expense : InputType.income,
    ),
  ),
];
