import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Note {
  int id = 0;
  @Property(type: PropertyType.date)
  DateTime date;
  double amount;
  String type;
  ToOne<Category> category;
  String? note;
  List<String>? images;

  Note({
    required this.date,
    required this.amount,
    required this.category,
    required this.type,
    this.note,
    this.images,
  });


}
