import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/riverpod/category_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../objectbox.g.dart';

final sharedPrefProvider = Provider<SharedPreferences>((ref) {
  return throw UnimplementedError();
});

final dbProvider = Provider<SharedPreferences>((ref) {
  return throw UnimplementedError();
});

final storeProvider = Provider<Store>((ref) => throw UnimplementedError());
