import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/data/note.dart';
import 'package:money_note/src/utils/date_ext.dart';
import 'package:money_note/src/widgets/currency_text.dart';

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
  final Widget Function(Note)? onNoteTap;

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.noData),
      );
    }

    return GroupedListView(
      physics: physics,
      elements: notes,
      shrinkWrap: shrinkWrap ?? false,
      groupBy: (Note note) => note.date.ddMMMyyyyEEFormat(),
      groupHeaderBuilder: (Note note) => Container(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Text(
          note.date.MMMddyyyyFormat(
            locale: Localizations.localeOf(context).languageCode,
          ),
        ),
      ),
      itemBuilder: (context, Note note) {
        return OpenContainer(
          transitionType: ContainerTransitionType.fadeThrough,
          middleColor: Theme.of(context).backgroundColor,
          closedColor: Theme.of(context).backgroundColor,
          openColor: Theme.of(context).backgroundColor,
          closedBuilder: (context, action) => NoteListItem(
            note: note,
          ),
          openBuilder: (context, action) =>
              onNoteTap?.call(note) ?? Container(),
        );

        // return NoteListItem(
        //   onNoteTap: onNoteTap,
        //   note: note,
        // );
      },
    );
  }
}

class NoteListItem extends StatelessWidget {
  const NoteListItem({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    final category = note.category;
    final isExpense = note.type == InputType.expense.name;

    return Material(
      child: Container(
        key: UniqueKey(),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              note.category.target!.icon!,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                children: [
                  Text(category.target!.name),
                  if (note.note != null && note.note?.isNotEmpty == true)
                    Text(
                      " ( ${note.note} )",
                      style: Theme.of(context).textTheme.caption,
                    ),
                ],
              ),
            ),
            CurrencyText(
              value: isExpense ? note.amount * -1 : note.amount,
            ),
          ],
        ),
      ),
    );
  }
}
