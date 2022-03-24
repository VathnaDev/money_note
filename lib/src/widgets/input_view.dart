import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_note/objectbox.g.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/data/note.dart';
import 'package:money_note/src/data/settings.dart';
import 'package:money_note/src/providers/category_state.dart';
import 'package:money_note/src/providers/notes_state.dart';
import 'package:money_note/src/screens/category/edit_category/edit_category_screen.dart';
import 'package:money_note/src/screens/home/settings/settings_screen.dart';
import 'package:money_note/src/screens/success/success_screen.dart';
import 'package:money_note/src/utils/circle_reveal_clipper.dart';
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

    //Animation
    final cameraIconAnimation = useAnimationController(
      duration: const Duration(milliseconds: 350),
    );

    final amountFocusNode = useFocusNode();
    final dollarScaleAnimation = useAnimationController(
      duration: Duration(seconds: 1),
      initialValue: 1,
      upperBound: 1,
      lowerBound: 0.4,
    );

    final noteFocusNode = useFocusNode();
    final noteExpended = useState(false);
    final isSubmitting = useState(false);

    useEffect(() {
      amountFocusNode.addListener(() {
        if (amountFocusNode.hasFocus) {
          dollarScaleAnimation.repeat(reverse: true);
        } else {
          dollarScaleAnimation.reset();
          dollarScaleAnimation.value = dollarScaleAnimation.upperBound;
        }
      });

      noteFocusNode.addListener(() {
        noteExpended.value = noteFocusNode.hasFocus;
      });
    }, [amountFocusNode, noteFocusNode]);

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
      cameraIconAnimation.reset();
      cameraIconAnimation.forward();

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

    void onSubmit() async {
      FocusManager.instance.primaryFocus?.unfocus();
      isSubmitting.value = true;
      Future.delayed(Duration(milliseconds: 400), () async {
        final newNote = Note(
          date: date,
          amount: amount.value,
          note: note.value,
          type: inputType.name,
          images: images.value,
          category: ToOne<Category>(target: category.value),
        )..id = noteRecord?.id ?? 0;
        ref.read(notesStateProvider(null).notifier).insertOrUpdate(newNote);

        await Navigator.push(context, _createRoute());
        Future.delayed(Duration(milliseconds: 500), () {
          isSubmitting.value = false;
          if (noteRecord != null) {
            onNoteUpdated?.call();
          }
          resetForm();
        });
      });
    }

    return SingleChildScrollView(
      primary: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              focusNode: amountFocusNode,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.isEmpty) {
                  amount.value = 0;
                } else {
                  amount.value = double.parse(value);
                }
              },
              decoration: InputDecoration(
                hintText: "0.00",
                prefixIcon: ScaleTransition(
                  scale: dollarScaleAnimation,
                  child: Icon(
                    Icons.attach_money,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text("Note"),
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.linearToEaseOut,
              height: noteExpended.value ? 50 * 2.5 : 50,
              child: TextFormField(
                focusNode: noteFocusNode,
                controller: noteController,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.top,
                expands: true,
                maxLines: null,
                onChanged: (value) {
                  note.value = value;
                },
                decoration: InputDecoration(
                  hintText: "Please input",
                  suffixIcon: RotationTransition(
                    turns: cameraIconAnimation,
                    child: IconButton(
                      onPressed: pickImage,
                      icon: const Icon(Icons.camera),
                    ),
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
            Align(
              alignment: Alignment.center,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 48,
                width:
                    isSubmitting.value ? 48 : MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: isValid == true ? onSubmit : null,
                  child: isSubmitting.value
                      ? CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        )
                      : Text(noteRecord == null ? "Submit" : "Update"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 300),
      reverseTransitionDuration: Duration(milliseconds: 500),
      opaque: false,
      barrierDismissible: false,
      pageBuilder: (context, animation, secondaryAnimation) => SuccessScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var screenSize = MediaQuery.of(context).size;
        Offset center =
            Offset(screenSize.width / 2 - 40, screenSize.height - 100);
        double beginRadius = 0.0;
        double endRadius = screenSize.height * 1.2;

        var tween = Tween(begin: beginRadius, end: endRadius);
        var radiusTweenAnimation = animation.drive(tween);

        return ClipPath(
          clipper: CircleRevealClipper(
              radius: radiusTweenAnimation.value, center: center),
          child: child,
        );
      },
    );
  }
}
