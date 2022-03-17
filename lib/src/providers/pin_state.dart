import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/providers/settings_state.dart';

final pinAuthState = StateProvider<bool>((ref) {
  final pin = ref.watch(
    settingsStateProvider.select((value) => value.pinPassword),
  );
  return pin == null || pin.isEmpty;
});
