import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/fake/fake_note.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/providers/notes_state.dart';
import 'package:money_note/src/screens/note_detail/note_detail_screen.dart';
import 'package:money_note/src/utils/constants.dart';
import 'package:money_note/src/utils/theme.dart';
import 'package:money_note/src/widgets/note_list.dart';

class CategoryReportScreen extends HookConsumerWidget {
  CategoryReportScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    var date = useState(0);

    final iconColor = category.type == InputType.income.name ? colorIncome : colorExpense;

    void onNoteTap(note) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NoteDetailScreen(
            note: note,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: SingleChildScrollView(
        primary: true,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: ToggleButtons(
                borderWidth: 2,
                borderRadius: BorderRadius.circular(120),
                onPressed: (value) {
                  date.value = value;
                },
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text("Month"),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text("Week"),
                  ),
                ],
                isSelected: List.generate(2, (index) => index == date.value),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              padding: const EdgeInsets.all(50),
              decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(40)),
              child: AspectRatio(
                aspectRatio: 1,
                child: SvgPicture.asset(
                  category.icon!,
                  color: iconColor.withOpacity(0.8),
                ),
              ),
            ),
            Text("This Month", style: textTheme.caption),
            Text(
              "\$00,00",
              style: textTheme.headline1?.copyWith(color: iconColor),
            ),
            NoteList(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              onNoteTap: onNoteTap,
              notes: ref.watch(
                notesStateProvider(NoteFilter(category: category)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
