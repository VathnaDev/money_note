import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/screens/home/report/category_report/category_report_screen.dart';
import 'package:money_note/src/utils/constants.dart';
import 'package:money_note/src/widgets/category_grid.dart';

class CategoryReportView extends HookConsumerWidget {
  const CategoryReportView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return SingleChildScrollView(
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
            physics: const NeverScrollableScrollPhysics(),
            items: [...expenseCategories],
            selectedColor: Colors.red,
            onItemTap: (item) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CategoryReportScreen())
              );
            },
          ),
          const SizedBox(height: 28),
          const Text("Income"),
          const SizedBox(height: 8),
          CategoryGrid(
            physics: const NeverScrollableScrollPhysics(),
            items: [...incomeCategories],
            selectedColor: Colors.red,
            onItemTap: (item) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoryReportScreen())
              );
            },
          ),
        ],
      ),
    );
  }
}
