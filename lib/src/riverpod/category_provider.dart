import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/riverpod/app_providers.dart';
import 'package:money_note/src/riverpod/category/category_state_notifier.dart';

final categoryProvider = Provider<List<Category>>((ref) {
  final categories = ref.watch(storeProvider);
  return categories.box<Category>().query().build().find();
});

final categoryByTypeProvider =
    StateNotifierProvider.family<CategoryState, List<Category>, InputType>(
  (ref, type) {
    return CategoryState(ref.read, type);
  },
);