import 'dart:io';

import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({Key? key, required this.imagesPath, this.onRemove})
      : super(key: key);

  final List<String> imagesPath;
  final Function(String)? onRemove;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      shrinkWrap: true,
      crossAxisCount: 4,
      children: [
        ...imagesPath.map(
          (e) => Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(e),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    onRemove?.call(e);
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
        ),
      ],
    );
  }
}
