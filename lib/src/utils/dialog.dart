import 'package:flutter/material.dart';

Future<bool> showConfirmDialog(
{ required BuildContext context,
  required String title,
  required String content,
}
) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("No")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text("Yes")),
      ],
    ),
  );
}
