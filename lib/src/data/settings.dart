import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';

@freezed
class Settings with _$Settings {
  factory Settings({
    @Default("USD") String currency,
    @Default("en") String language,
    @Default(false) bool isDarkMode,
    @Default(true) bool isFirstOpen,
    String? pinPassword,
    DateTime? reminder,
  }) = _Settings;
}
