import 'package:flutter/material.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/widgets/category_item.dart';

class CategoryGrid extends StatelessWidget {
  CategoryGrid({
    Key? key,
    required this.items,
    this.selectedCategory,
    this.onItemTap,
    this.selectedColor,
    this.physics,
    this.padding,
    this.displayLabel,
  }) : super(key: key);

  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final bool? displayLabel;

  final Color? selectedColor;
  final Category? selectedCategory;
  final List<Category> items;
  final Function(Category)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: padding,
      physics: physics,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      shrinkWrap: true,
      crossAxisCount: 4,
      children: [
        ...items.map(
          (e) => CategoryItem(
            category: e,
            isSelected: selectedCategory?.id == e.id,
            onItemTap: onItemTap,
            selectedColor: selectedColor,
            displayLabel: displayLabel,
          ),
        ),
      ],
    );
  }
}
