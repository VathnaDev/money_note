import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/data/note.dart';
import 'package:money_note/src/utils/theme.dart';

class NoteList extends StatelessWidget {
  NoteList({
    Key? key,
    required this.notes,
    this.physics,
    this.shrinkWrap,
    this.onNoteTap,
  }) : super(key: key);

  final ScrollPhysics? physics;
  final bool? shrinkWrap;
  final Function(Note)? onNoteTap;

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return GroupedListView(
      physics: physics,
      elements: notes,
      shrinkWrap: shrinkWrap ?? false,
      groupBy: (Note note) => note.date,
      groupHeaderBuilder: (Note note) => Container(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Text(note.date.toString()),
      ),
      itemBuilder: (context, Note note) {
        final category = note.category;
        final isExpense = note.type == InputType.expense;
        final amount = isExpense ? "-\$${note.amount}" : "+\$${note.amount}";

        return InkWell(
          onTap: () {
            onNoteTap?.call(note);
          },
          child: Container(
            key: UniqueKey(),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  note.category.icon!,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Row(
                    children: [
                      Text(category.name),
                      if (note.note != null && note.note?.isNotEmpty == true)
                        Text(
                          " (${note.note})",
                          style: Theme.of(context).textTheme.caption,
                        ),
                    ],
                  ),
                ),
                Text(
                  amount,
                  style: TextStyle(
                    color: isExpense ? colorExpense : colorIncome,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
