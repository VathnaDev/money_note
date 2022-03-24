import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImageGrid extends HookConsumerWidget {
  const ImageGrid({Key? key, required this.imagesPath, this.onRemove})
      : super(key: key);

  final List<String> imagesPath;
  final Function(String)? onRemove;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      shrinkWrap: true,
      crossAxisCount: 4,
      children: [
        ...imagesPath.map(
          (e) => ImageGridItem(
            key: Key(e),
            filePath: e,
            onRemove: onRemove,
          ),
        ),
      ],
    );
  }
}

class ImageGridItem extends HookConsumerWidget {
  const ImageGridItem({
    Key? key,
    required this.filePath,
    required this.onRemove,
  }) : super(key: key);

  final String filePath;
  final Function(String)? onRemove;

  final fadeDuration = const Duration(milliseconds: 350);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isVisible = useState(true);

    return AnimatedOpacity(
      duration: fadeDuration,
      opacity: isVisible.value ? 1 : 0,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(filePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () {
                isVisible.value = false;
                Future.delayed(fadeDuration, () {
                  onRemove?.call(filePath);
                });
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  color: Colors.red,
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
