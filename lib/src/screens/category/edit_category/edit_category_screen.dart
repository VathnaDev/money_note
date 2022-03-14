import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/screens/category/add_category/add_category.dart';
import 'package:money_note/src/utils/constants.dart';
import 'package:money_note/src/widgets/category_grid.dart';

class EditCategoryScreen extends HookConsumerWidget {
  const EditCategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var category = useState<Category?>(null);

    void onAddMore() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AddCategory()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Category"),
        actions: category.value == null
            ? null
            : [
                IconButton(
                  onPressed: () {},
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
            const Text("Expenses"),
            const SizedBox(height: 8),
            CategoryGrid(
              items: [...expenseCategories, Category(name: "Add more")],
              selectedColor: Colors.red,
              selectedCategory: category.value,
              onItemTap: (item) {
                category.value = item;
                if (item.icon == null) {
                  category.value = null;
                  onAddMore();
                }
              },
            ),
            const SizedBox(height: 28),
            const Text("Income"),
            const SizedBox(height: 8),
            CategoryGrid(
              items: [...incomeCategories, Category(name: "Add more")],
              selectedColor: Colors.red,
              selectedCategory: category.value,
              onItemTap: (item) {
                category.value = item;
                if (item.icon == null) {
                  category.value = null;
                  onAddMore();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
