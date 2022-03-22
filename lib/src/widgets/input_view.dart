import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_note/objectbox.g.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/data/note.dart';
import 'package:money_note/src/providers/category_state.dart';
import 'package:money_note/src/providers/notes_state.dart';
import 'package:money_note/src/screens/category/edit_category/edit_category_screen.dart';
import 'package:money_note/src/widgets/category_grid.dart';
import 'package:money_note/src/widgets/date_picker.dart';
import 'package:money_note/src/widgets/image_grid.dart';
import 'package:path_provider/path_provider.dart';

class InputView extends HookConsumerWidget {
  InputView({
    Key? key,
    required this.inputType,
    this.noteRecord,
    this.onNoteUpdated,
  }) : super(key: key);

  final InputType inputType;
  final Note? noteRecord;
  final Function? onNoteUpdated;

  var date = DateTime.now();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    var amount = useState(noteRecord?.amount ?? 0.0);
    final amountController = useTextEditingController(
        text: amount.value == 0 ? "" : amount.value.toString());

    var note = useState(noteRecord?.note ?? "");
    final noteController = useTextEditingController(text: note.value);

    var category = useState<Category?>(noteRecord?.category.target);
    var images = useState<List<String>>(List.from(noteRecord?.images ?? []));

    final isValid = amount.value > 0 && category.value != null;

    void resetForm() {
      amount.value = 0;
      note.value = "";
      category.value = null;
      images.value = [];

      amountController.text = "";
      noteController.text = "";
      FocusScope.of(context).unfocus();
    }

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
        Directory appDocumentsDirectory =
            await getApplicationDocumentsDirectory();
        String appDocumentsPath = appDocumentsDirectory.path;
        String fileName = image.path.split("/").last;
        String savedPath = "${appDocumentsPath}/$fileName";
        image.saveTo(savedPath);

        images.value.add(savedPath);
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
        images: images.value,
        category: ToOne<Category>(target: category.value),
      )..id = noteRecord?.id ?? 0;
      ref.read(notesStateProvider(null).notifier).insertOrUpdate(newNote);
      if (noteRecord != null) {
        onNoteUpdated?.call();
      }
      resetForm();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Success!"),
          backgroundColor: Colors.greenAccent[400],
        ),
      );
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
                onDateChanged: (selectedDate) {
                  date = selectedDate;
                },
              ),
            const SizedBox(height: 12),
            Text(inputType == InputType.expense ? "Expense" : "Income"),
            const SizedBox(height: 8),
            TextFormField(
              controller: amountController,
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
              controller: noteController,
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
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: images.value.isNotEmpty
                  ? ImageGrid(imagesPath: images.value, onRemove: onRemoveImage)
                  : Container(),
            ),
            // if (images.value.isNotEmpty)
            //   ImageGrid(imagesPath: images.value, onRemove: onRemoveImage),
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
              onPressed: isValid == true ? onSubmit : null,
              child: Text(noteRecord == null ? "Submit" : "Update"),
            ),
          ],
        ),
      ),
    );
  }
}
