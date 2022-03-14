import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/fake/fake_note.dart';
import 'package:money_note/src/utils/constants.dart';
import 'package:money_note/src/utils/theme.dart';
import 'package:money_note/src/widgets/note_list.dart';

class CategoryReportScreen extends HookConsumerWidget {
  const CategoryReportScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var date = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Category Report"),
        centerTitle: true,
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
                  color: colorExpense.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(40)),
              child: AspectRatio(
                aspectRatio: 1,
                child: SvgPicture.asset(
                  expenseCategories.first.icon!,
                  color: Colors.red.withOpacity(0.8),
                ),
              ),
            ),
            Text("This Month", style: textTheme.caption),
            Text(
              "\$880,32",
              style: textTheme.headline1?.copyWith(color: colorExpense),
            ),
            NoteList(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              notes: fakeNotes,
            ),
          ],
        ),
      ),
    );
  }
}
