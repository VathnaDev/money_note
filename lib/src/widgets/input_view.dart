import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/screens/category/edit_category/edit_category_screen.dart';
import 'package:money_note/src/utils/constants.dart';
import 'package:money_note/src/widgets/date_picker.dart';
import 'package:money_note/src/widgets/category_grid.dart';
import 'package:money_note/src/widgets/image_grid.dart';

class InputView extends HookConsumerWidget {
  InputView({
    Key? key,
    required this.inputType,
  }) : super(key: key);

  final InputType inputType;

  var date = DateTime.now();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    var amount = useState(0.0);
    var note = useState("");
    var category = useState<Category?>(null);
    var images = useState<List<String>>([]);

    final isValid = amount.value > 0 && category.value != null;

    final List<Category> categories = [
      ...(inputType == InputType.expense
          ? expenseCategories
          : incomeCategories),
      Category(name: "Edit")
    ];

    void onCategorySelected(Category selectedCategory) {
      category.value = selectedCategory;
      if (selectedCategory.icon == null) {
        category.value = null;
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const EditCategoryScreen()),
        );
      }
    }

    void pickImage() async {
      final ImagePicker _picker = ImagePicker();
      final image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        images.value.add(image.path);
        images.value = List.from(images.value);
      }
    }

    void onRemoveImage(String path) {
      images.value.remove(path);
      images.value = List.from(images.value);
    }

    return SingleChildScrollView(
      primary: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DatePicker(
              initialDate: date,
              onDateSelected: (selectedDate) {
                date = selectedDate;
              },
            ),
            const SizedBox(height: 12),
            Text(inputType == InputType.expense ? "Expense" : "Income"),
            const SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.isEmpty) {
                  amount.value = 0;
                } else {
                  amount.value = double.parse(value);
                }
              },
              decoration: const InputDecoration(
                hintText: "0.00",
                prefixIcon: Icon(
                  Icons.attach_money,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text("Note"),
            const SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.text,
              onChanged: (value) {
                note.value = value;
              },
              decoration: InputDecoration(
                hintText: "Please input",
                suffixIcon: IconButton(
                  onPressed: pickImage,
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (images.value.isNotEmpty)
              ImageGrid(imagesPath: images.value, onRemove: onRemoveImage),
            const SizedBox(height: 12),
            const Text("Category"),
            const SizedBox(height: 8),
            CategoryGrid(
              physics: const NeverScrollableScrollPhysics(),
              items: categories,
              selectedCategory: category.value,
              onItemTap: onCategorySelected,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: isValid ? () {} : null,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
