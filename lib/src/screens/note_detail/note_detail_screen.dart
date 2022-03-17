import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/data/note.dart';
import 'package:money_note/src/providers/monthly_report_state.dart';
import 'package:money_note/src/providers/notes_state.dart';
import 'package:money_note/src/utils/date_ext.dart';
import 'package:money_note/src/utils/theme.dart';
import 'package:money_note/src/widgets/input_view.dart';

class NoteDetailScreen extends HookConsumerWidget {
  NoteDetailScreen({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          note.date.ddMMMyyyyEEFormat(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(notesStateProvider(null).notifier).remove(note.id);
              Navigator.of(context).pop();
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: colorRed),
            ),
          )
        ],
      ),
      body: InputView(
        onNoteUpdated: () {
          Navigator.of(context).pop();
        },
        inputType: InputType.values.singleWhere(
              (element) => element.name == note.type,
        ),
        noteRecord: note,
      ),
    );
  }
}
