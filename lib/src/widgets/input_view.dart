import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_note/objectbox.g.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/data/note.dart';
import 'package:money_note/src/riverpod/category_state.dart';
import 'package:money_note/src/riverpod/notes_state.dart';
import 'package:money_note/src/screens/category/edit_category/edit_category_screen.dart';
import 'package:money_note/src/widgets/category_grid.dart';
import 'package:money_note/src/widgets/date_picker.dart';
import 'package:money_note/src/widgets/image_grid.dart';

class InputView extends HookConsumerWidget {
  InputView({
    Key? key,
    required this.inputType,
    this.noteRecord,
  }) : super(key: key);

  final InputType inputType;
  final Note? noteRecord;

  var date = DateTime.now();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    var amount = useState(noteRecord?.amount ?? 0.0);
    var note = useState(noteRecord?.note ?? "");
    var category = useState<Category?>(noteRecord?.category.target);
    var images = useState<List<String>>(noteRecord?.images ?? []);

    final isValid = amount.value > 0 && category.value != null;

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

    void onSubmit() {
      final newNote = Note(
        date: date,
        amount: amount.value,
        note: note.value,
        type: inputType.name,
        category: ToOne<Category>(target: category.value),
      );
      ref.read(notesStateProvider(null).notifier).add(newNote);
    }

    return SingleChildScrollView(
      primary: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (noteRecord == null)
              DatePicker(
                initialDate: date,
                onDateSelected: (selectedDate) {
                  date = selectedDate;
                },
              ),
            const SizedBox(height: 12),
            Text(inputType == InputType.expense ? "Expense" : "Income"),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: amount.value.toString(),
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
            TextFormField(
              initialValue: note.value,
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
              padding: const EdgeInsets.symmetric(vertical: 8),
              physics: const NeverScrollableScrollPhysics(),
              items: [
                ...ref.watch(
                  categoryByTypeProvider(inputType),
                ),
                Category(name: "Edit"),
              ],
              selectedCategory: category.value,
              onItemTap: onCategorySelected,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: isValid ? onSubmit : null,
              child: Text(noteRecord == null ? "Submit" : "Update"),
            ),
          ],
        ),
      ),
    );
  }
}
