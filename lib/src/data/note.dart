import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_note/src/data/category.dart' ;
import 'package:money_note/src/data/input_type.dart';

part 'note.freezed.dart';

@freezed
class Note with _$Note {
  factory Note({
    required String id,
    required int date,
    required double amount,
    required Category category,
    required InputType type,
    String? note,
    List<String>? images,
  }) = _Note;
}
