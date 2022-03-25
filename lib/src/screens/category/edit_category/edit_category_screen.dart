import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/providers/category_state.dart';
import 'package:money_note/src/screens/category/add_category/add_category.dart';
import 'package:money_note/src/widgets/category_grid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        primary: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(AppLocalizations.of(context)!.expense),
            const SizedBox(height: 8),
            CategoryGrid(
              physics: const NeverScrollableScrollPhysics(),
              items: [
                ...ref.watch(
                  categoryByTypeProvider(InputType.expense),
                ),
                Category(
                    name: AppLocalizations.of(context)!.addMore,
                    type: InputType.expense.name),
              ],
              selectedColor: Colors.red,
              selectedCategory: category.value,
              onItemTap: (item) {
                category.value = item;
                if (item.icon == null) {
                  category.value = null;
                  onAddMore(InputType.expense);
                }
              },
            ),
            const SizedBox(height: 28),
            Text(AppLocalizations.of(context)!.income),
            const SizedBox(height: 8),
            CategoryGrid(
              padding: const EdgeInsets.symmetric(vertical: 8),
              physics: const NeverScrollableScrollPhysics(),
              items: [
                ...ref.watch(
                  categoryByTypeProvider(InputType.income),
                ),
                Category(
                    name: AppLocalizations.of(context)!.addMore,
                    type: InputType.income.name),
              ],
              selectedColor: Colors.red,
              selectedCategory: category.value,
              onItemTap: (item) {
                category.value = item;
                if (item.icon == null) {
                  category.value = null;
                  onAddMore(InputType.income);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
