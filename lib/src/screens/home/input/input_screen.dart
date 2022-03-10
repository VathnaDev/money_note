import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/utils/constants.dart';
import 'package:money_note/src/utils/date_ext.dart';
import 'package:money_note/src/widgets/category_grid.dart';
import 'package:money_note/src/widgets/category_item.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 10,
          bottom: const TabBar(
            tabs: [
              Tab(text: "Expense"),
              Tab(text: "Income"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            InputView(inputType: InputType.expense),
            InputView(inputType: InputType.income),
          ],
        ),
      ),
    );
  }
}

class InputView extends HookConsumerWidget {
  const InputView({
    Key? key,
    required this.inputType,
  }) : super(key: key);

  final InputType inputType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    var amount = useState(0.0);
    var note = useState("");
    var category = useState<Category?>(null);
    var date = useState(DateTime.now());

    void onCategorySelected(Category selectedCategory) {
      category.value = selectedCategory;
      if (selectedCategory.icon == null) {
        category.value = null;
      }
    }

    final isValid = amount.value > 0 && category.value != null;

    return SingleChildScrollView(
      primary: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              borderRadius: BorderRadius.circular(9999),
              color: const Color(0xFFF5F5F5),
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(999)),
                      child: InkWell(
                        onTap: () {
                          date.value =
                              date.value.subtract(const Duration(days: 1));
                        },
                        child: const Icon(Icons.chevron_left),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        date.value.displayFormat(),
                        textAlign: TextAlign.center,
                        style: textTheme.bodyText1,
                      ),
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(999)),
                      child: InkWell(
                        onTap: () {
                          date.value = date.value.add(const Duration(days: 1));
                        },
                        child: const Icon(Icons.chevron_right),
                      ),
                    ),
                  ],
                ),
              ),
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
                  onPressed: () {},
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text("Category"),
            const SizedBox(height: 8),
            CategoryGrid(
              items: inputType == InputType.expense
                  ? expenseCategories
                  : incomeCategories,
              selectedCategory: category.value,
              onItemTap: (item) {
                category.value = item;
              },
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
