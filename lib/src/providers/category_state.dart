import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/objectbox.g.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/providers/providers.dart';

class CategoryState extends StateNotifier<List<Category>> {
  final Reader read;
  final InputType type;

  CategoryState(this.read, this.type) : super([]) {
    state = [...getCategory(type)];
  }

  void add(Category category) {
    read(storeProvider).box<Category>().put(category);
    state = [...getCategory(type)];
  }

  void remove(int id) {
    read(storeProvider).box<Category>().remove(id);
    state = [...getCategory(type)];
  }

  List<Category> getCategory(InputType type) {
    return read(storeProvider)
        .box<Category>()
        .query(Category_.type.equals(type.name))
        .build()
        .find();
  }
}

final categoryByTypeProvider =
    StateNotifierProvider.family<CategoryState, List<Category>, InputType>(
  (ref, type) => CategoryState(ref.read, type),
);
