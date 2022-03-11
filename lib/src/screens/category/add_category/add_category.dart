import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/utils/constants.dart';
import 'package:money_note/src/widgets/category_grid.dart';

class AddCategory extends HookConsumerWidget {
  const AddCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var category = useState<Category?>(null);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text(
                  "Category Name",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Please input",
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Icon",
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Expanded(
            child: CategoryGrid(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 20,
              ),
              items: allCategories,
              selectedCategory: category.value,
              displayLabel: false,
              onItemTap: (value) {
                category.value = value;
              },
            ),
          )
        ],
      ),
    );
  }
}
