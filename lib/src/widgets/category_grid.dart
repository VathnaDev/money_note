import 'package:flutter/material.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/widgets/category_item.dart';

class CategoryGrid extends StatelessWidget {
  CategoryGrid({
    Key? key,
    required this.items,
    this.selectedCategory,
    this.onItemTap, this.selectedColor,
  }) : super(key: key);

  final Color? selectedColor;
  final Category? selectedCategory;
  final List<Category> items;
  final Function(Category)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      shrinkWrap: true,
      crossAxisCount: 4,
      children: [
        ...items.map(
          (e) => CategoryItem(
            category: e,
            isSelected: selectedCategory == e,
            onItemTap: onItemTap,
            selectedColor: selectedColor
          ),
        ),
      ],
    );
  }
}
