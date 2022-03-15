import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/note.dart';
import 'package:money_note/src/utils/date_ext.dart';
import 'package:money_note/src/utils/theme.dart';
import 'package:money_note/src/widgets/input_view.dart';
import 'package:money_note/src/widgets/note_list.dart';

class NoteDetailScreen extends HookConsumerWidget {
  NoteDetailScreen({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(note.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateTime.fromMicrosecondsSinceEpoch(note.date).displayFormat(),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Delete",
              style: TextStyle(color: colorRed),
            ),
          )
        ],
      ),
      body: InputView(
        inputType: note.type,
        noteRecord: note,
      ),
    );
  }
}