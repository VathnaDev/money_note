import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Category {
  int id = 0;
  String name;
  String? icon;
  String? type;

  Category({
    required this.name,
    this.type,
    this.icon,
  });
}
