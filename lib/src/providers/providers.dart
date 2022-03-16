import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/repo/note_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../objectbox.g.dart';

final sharedPrefProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

final dbProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

final storeProvider = Provider<Store>((ref) => throw UnimplementedError());

final noteRepositoryProvider = Provider<NoteRepository>(
  (ref) => NoteRepository(ref.read),
);
