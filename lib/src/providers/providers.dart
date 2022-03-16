import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../objectbox.g.dart';

final sharedPrefProvider = Provider<SharedPreferences>((ref) {
  return throw UnimplementedError();
});

final dbProvider = Provider<SharedPreferences>((ref) {
  return throw UnimplementedError();
});

final storeProvider = Provider<Store>((ref) => throw UnimplementedError());
