import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/utils/constants.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: "Expense"),
              Tab(text: "Income"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            InputView(inputType: InputType.expense),
            InputView(inputType: InputType.income),
          ],
        ),
      ),
    );
  }
}

class InputView extends StatelessWidget {
  const InputView({
    Key? key,
    required this.inputType,
  }) : super(key: key);

  final InputType inputType;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                        onTap: () {},
                        child: Icon(Icons.chevron_left),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Feb 24, 2022 (Sat)",
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
                        onTap: () {},
                        child: Icon(Icons.chevron_right),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(inputType == InputType.expense ? "Expense" : "Income"),
            SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "0.00",
                prefixIcon: Icon(
                  Icons.attach_money,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text("Note"),
            SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Please input",
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.camera_alt_outlined,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text("Category"),
            SizedBox(height: 8),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              shrinkWrap: true,
              crossAxisCount: 4,
              children: [
                if(inputType == InputType.expense) ...expenseCategories.map((e) => CategoryItem(category: e)),
                if(inputType == InputType.income) ...incomeCategories.map((e) => CategoryItem(category: e)),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: () {}, child: Text("Submit")),
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.category,
    this.onItemTap,
  }) : super(key: key);

  final Category category;
  final Function(Category)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemTap?.call(category);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFD9D9D9)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (category.icon != null) SvgPicture.asset(category.icon!),
            if (category.icon != null) SizedBox(height: 2),
            Text(
              category.name,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
