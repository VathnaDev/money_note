import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_note/src/data/category.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({
    Key? key,
    required this.category,
    required this.isSelected,
    this.onItemTap,
    this.selectedColor,
    this.displayLabel,
  }) : super(key: key);

  final bool? displayLabel;
  final Color? selectedColor;
  final bool isSelected;
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
          border: Border.all(
            color: isSelected
                ? (selectedColor ?? Theme.of(context).primaryColor)
                : const Color(0xFFD9D9D9),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (category.icon != null)
              SvgPicture.asset(
                category.icon!,
                color: isSelected
                    ? (selectedColor ?? Theme.of(context).primaryColor)
                    : null,
              ),
            if (category.icon != null) const SizedBox(height: 2),
            if (displayLabel ?? true)
              Text(
                category.name,
                style: Theme.of(context).textTheme.caption?.copyWith(
                    color: isSelected
                        ? (selectedColor ?? Theme.of(context).primaryColor)
                        : Colors.black),
              ),
          ],
        ),
      ),
    );
  }
}
