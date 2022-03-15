import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/riverpod/app_providers.dart';
import 'package:money_note/src/riverpod/category_provider.dart';
import 'package:money_note/src/utils/constants.dart';
import 'package:money_note/src/widgets/category_grid.dart';

class AddCategory extends HookConsumerWidget {
  const AddCategory({
    Key? key,
    required this.inputType,
  }) : super(key: key);

  final InputType inputType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var nameTextController = useTextEditingController();
    var name = useState("");
    var category = useState<Category?>(null);

    final isValid = name.value.isNotEmpty && category.value != null;

    void addNewCategory() {
      final newCategory = Category(
        name: nameTextController.text,
        type: inputType.name,
        icon: category.value!.icon,
      );
      ref.read(categoryByTypeProvider(inputType).notifier).add(newCategory);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Category added successfully.",
      )));
      nameTextController.text = "";
      category.value = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Category"),
        actions: [
          IconButton(
            onPressed: !isValid ? null : addNewCategory,
            icon: const Icon(Icons.save_outlined),
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
              children: [
                const Text(
                  "Category Name",
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: nameTextController,
                  onChanged: (value) {
                    name.value = value;
                  },
                  decoration: const InputDecoration(
                    hintText: "Please input",
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
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
