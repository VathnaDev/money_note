import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/utils/constants.dart';
import 'package:money_note/src/widgets/category_grid.dart';

class EditCategoryScreen extends HookConsumerWidget {
  const EditCategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Category"),
        actions: [
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
              onItemTap: (item) {},
            ),
            const SizedBox(height: 28),
            const Text("Income"),
            const SizedBox(height: 8),
            CategoryGrid(
              items: [...incomeCategories, Category(name: "Add more")],
              selectedColor: Colors.red,
              selectedCategory: incomeCategories.first,
              onItemTap: (item) {},
            ),
          ],
        ),
      ),
    );
  }
}
