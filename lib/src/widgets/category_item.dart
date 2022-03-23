import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/category.dart';

class CategoryItem extends HookConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final rotateAnimation = useAnimationController(
      duration: Duration(milliseconds: 500),
      initialValue: 1,
      upperBound: 1,
      lowerBound: 0.5,
    );
    return InkWell(
      onTap: () {
        rotateAnimation.reset();
        rotateAnimation.forward();
        onItemTap?.call(category);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? (selectedColor ?? Theme.of(context).colorScheme.secondary)
                : Theme.of(context).primaryColorDark,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (category.icon != null)
              ScaleTransition(
                scale: rotateAnimation,
                child: SvgPicture.asset(
                  category.icon!,
                  color: isSelected
                      ? (selectedColor ??
                          Theme.of(context).colorScheme.secondary)
                      : Theme.of(context).primaryColorDark,
                ),
              ),
            if (category.icon != null) const SizedBox(height: 2),
            if (displayLabel ?? true)
              Text(
                category.name,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: isSelected
                          ? (selectedColor ??
                              Theme.of(context).colorScheme.secondary)
                          : Theme.of(context).primaryColorDark,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
