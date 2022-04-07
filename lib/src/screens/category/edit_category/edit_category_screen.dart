import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/providers/category_state.dart';
import 'package:money_note/src/screens/category/add_category/add_category.dart';
import 'package:money_note/src/screens/home/report/category_report/category_report_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:money_note/src/utils/size_ext.dart';
import 'package:responsive_framework/responsive_framework.dart';

class EditCategoryScreen extends HookConsumerWidget {
  const EditCategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var category = useState<Category?>(null);

    void onAddMore(InputType type) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddCategory(
            inputType: type,
          ),
          fullscreenDialog: true,
        ),
      );
    }

    void onRemove() {
      final type = category.value!.type == InputType.income.name
          ? InputType.income
          : InputType.expense;

      ref
          .read(categoryByTypeProvider(type).notifier)
          .remove(category.value!.id);
    }

    final crossAxisCount = ResponsiveValue<int>(
      context,
      defaultValue: 4,
      valueWhen: const [
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${AppLocalizations.of(context)!.edit} ${AppLocalizations.of(context)!.category}"),
        actions: category.value == null
            ? null
            : [
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete),
                )
              ],
      ),
      body: SingleChildScrollView(
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
                selectedColor: Colors.red,
                selectedCategory: category.value,
                title: AppLocalizations.of(context)!.expense,
                items: [
                  ...ref.watch(categoryByTypeProvider(InputType.expense)),
                  Category(
                      name: AppLocalizations.of(context)!.addMore,
                      type: InputType.expense.name),
                ],
                onItemTap: (item) {
                  category.value = item;
                  if (item.icon == null) {
                    category.value = null;
                    onAddMore(InputType.expense);
                  }
                },
              ),
            ),
            ResponsiveRowColumnItem(
              rowFlex: 1,
              child: CategoryListTile(
                selectedCategory: category.value,
                crossAxisCount: crossAxisCount,
                selectedColor: Colors.red,
                title: AppLocalizations.of(context)!.income,
                items: [
                  ...ref.watch(categoryByTypeProvider(InputType.income)),
                  Category(
                      name: AppLocalizations.of(context)!.addMore,
                      type: InputType.income.name),
                ],
                onItemTap: (item) {
                  category.value = item;
                  if (item.icon == null) {
                    category.value = null;
                    onAddMore(InputType.income);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
