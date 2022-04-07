import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/providers/category_state.dart';
import 'package:money_note/src/screens/home/report/category_report/category_report_screen.dart';
import 'package:money_note/src/utils/size_ext.dart';
import 'package:money_note/src/widgets/category_grid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CategoryReportView extends HookConsumerWidget {
  const CategoryReportView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crossAxisCount = ResponsiveValue<int>(
      context,
      defaultValue: 4,
      valueWhen: [
        Condition.smallerThan(
          name: MOBILE,
          value: 4,
        ),
        Condition.largerThan(
          name: MOBILE,
          value: 6,
        ),
        Condition.largerThan(
          name: TABLET,
          value: 4,
        )
      ],
    ).value;

    return SingleChildScrollView(
      primary: true,
      child: ResponsiveRowColumn(
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        rowMainAxisAlignment: MainAxisAlignment.start,
        rowPadding: EdgeInsets.all(context.defaultSpacing()),
        columnPadding: EdgeInsets.all(context.defaultSpacing()),
        rowSpacing: context.defaultSpacing(),
        columnSpacing: context.defaultSpacing(),
        layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        children: [
          ResponsiveRowColumnItem(
            rowFlex: 1,
            child: CategoryListTile(
              crossAxisCount: crossAxisCount,
              title: AppLocalizations.of(context)!.expense,
              items: [
                ...ref.watch(categoryByTypeProvider(InputType.expense)),
              ],
              onItemTap: (item) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CategoryReportScreen(category: item),
                  ),
                );
              },
            ),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 1,
            child: CategoryListTile(
              crossAxisCount: crossAxisCount,
              title: AppLocalizations.of(context)!.income,
              items: [
                ...ref.watch(categoryByTypeProvider(InputType.income)),
              ],
              onItemTap: (item) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CategoryReportScreen(category: item),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryListTile extends StatelessWidget {
  const CategoryListTile({
    Key? key,
    required this.items,
    this.crossAxisCount,
    this.onItemTap,
    this.title,
    this.selectedCategory,
    this.selectedColor,
  }) : super(key: key);

  final String? title;
  final int? crossAxisCount;
  final List<Category> items;
  final Function(Category)? onItemTap;
  final Color? selectedColor;
  final Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title ?? ""),
        const SizedBox(height: 12),
        CategoryGrid(
          selectedCategory: selectedCategory,
          crossAxisCount: crossAxisCount,
          physics: const NeverScrollableScrollPhysics(),
          items: items,
          selectedColor: selectedColor,
          onItemTap: onItemTap,
        ),
      ],
    );
  }
}
