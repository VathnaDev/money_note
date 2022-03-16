import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String> moveToLocal(String path) async {
  File file = File(path);

  Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
  String appDocumentsPath = appDocumentsDirectory.path;
  await file.rename(appDocumentsPath + "/${DateTime.now()}.png");

  return file.path;
}
