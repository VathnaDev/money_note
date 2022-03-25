import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/providers/category_state.dart';
import 'package:money_note/src/utils/constants.dart';
import 'package:money_note/src/widgets/category_grid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      FocusScope.of(context).unfocus();

      final newCategory = Category(
        name: nameTextController.text,
        type: inputType.name,
        icon: category.value!.icon,
      );
      ref.read(categoryByTypeProvider(inputType).notifier).add(newCategory);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        AppLocalizations.of(context)!.categoryAddedSuccessMessage,
      )));
      nameTextController.text = "";
      category.value = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addCategory),
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
                Text(
                  AppLocalizations.of(context)!.categoryName,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: nameTextController,
                  onChanged: (value) {
                    name.value = value;
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.pleaseInput,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.icon,
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
              items: allCategories.map((e) {
                e.id = DateTime.now().microsecondsSinceEpoch;
                return e;
              }).toList(),
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
