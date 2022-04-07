import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/providers/note_category_report_state.dart';
import 'package:money_note/src/screens/note_detail/note_detail_screen.dart';
import 'package:money_note/src/utils/date_ext.dart';
import 'package:money_note/src/utils/size_ext.dart';
import 'package:money_note/src/utils/theme.dart';
import 'package:money_note/src/widgets/currency_text.dart';
import 'package:money_note/src/widgets/date_picker.dart';
import 'package:money_note/src/widgets/note_list.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CategoryReportScreen extends StatefulHookConsumerWidget {
  final Category category;

  const CategoryReportScreen({required this.category, Key? key})
      : super(key: key);

  @override
  CategoryReportScreenState createState() => CategoryReportScreenState();
}

class CategoryReportScreenState extends ConsumerState<CategoryReportScreen> {
  @override
  void initState() {
    super.initState();
    ref
        .read(noteCategoryStateProvider.notifier)
        .fetchNotes(DateTime.now(), widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var date = useState(DateTime.now());

    final notes = ref.watch(noteCategoryStateProvider);

    final total = notes.map((e) => e.amount).sum;

    final iconColor = widget.category.type == InputType.income.name
        ? colorIncome
        : colorExpense;

    date.addListener(() {
      ref.read(noteCategoryStateProvider.notifier).fetchNotes(
            date.value,
            widget.category.id,
          );
    });

    Widget _buildNoteInfo() {
      return Column(
        children: [
          DatePicker(
            initialDate: date.value,
            displayFormat: MMMMyyyy,
            incrementBy: const Duration(days: 31),
            onDateChanged: (newDate) {
              date.value = newDate;
            },
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
                widget.category.icon!,
                color: iconColor.withOpacity(0.8),
              ),
            ),
          ),
          Text(date.value.MMMyyyyFormat(), style: textTheme.subtitle1),
          CurrencyText(
            value: total,
            colorizeText: false,
            textStyle: textTheme.headline1?.copyWith(color: iconColor),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Material(
          type: MaterialType.transparency,
          child: Text(
            widget.category.name,
            style: textTheme.headline6,
          ),
        ),
      ),
      body: SingleChildScrollView(
        primary: true,
        child: ResponsiveRowColumn(
            columnCrossAxisAlignment: CrossAxisAlignment.start,
            rowCrossAxisAlignment: CrossAxisAlignment.start,
            rowMainAxisAlignment: MainAxisAlignment.center,
            rowPadding: EdgeInsets.all(context.defaultSpacing()),
            columnPadding: EdgeInsets.all(context.defaultSpacing()),
            rowSpacing: context.defaultSpacing(),
            layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            children: [
              ResponsiveRowColumnItem(child: _buildNoteInfo(), rowFlex: 1),
              ResponsiveRowColumnItem(
                rowFlex: 2,
                child: NoteList(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  onNoteTap: (note) => NoteDetailScreen(note: note),
                  notes: notes,
                ),
              ),
            ]),
      ),
    );
  }
}
