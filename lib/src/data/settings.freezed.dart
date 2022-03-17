// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SettingsTearOff {
  const _$SettingsTearOff();

  _Settings call(
      {String currency = "USD",
      bool isDarkMode = false,
      bool isFirstOpen = true,
      String? pinPassword,
      DateTime? reminder}) {
    return _Settings(
      currency: currency,
      isDarkMode: isDarkMode,
      isFirstOpen: isFirstOpen,
      pinPassword: pinPassword,
      reminder: reminder,
    );
  }
}

/// @nodoc
const $Settings = _$SettingsTearOff();

/// @nodoc
mixin _$Settings {
  String get currency => throw _privateConstructorUsedError;
  bool get isDarkMode => throw _privateConstructorUsedError;
  bool get isFirstOpen => throw _privateConstructorUsedError;
  String? get pinPassword => throw _privateConstructorUsedError;
  DateTime? get reminder => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingsCopyWith<Settings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsCopyWith<$Res> {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) then) =
      _$SettingsCopyWithImpl<$Res>;
  $Res call(
      {String currency,
      bool isDarkMode,
      bool isFirstOpen,
      String? pinPassword,
      DateTime? reminder});
}

/// @nodoc
class _$SettingsCopyWithImpl<$Res> implements $SettingsCopyWith<$Res> {
  _$SettingsCopyWithImpl(this._value, this._then);

  final Settings _value;
  // ignore: unused_field
  final $Res Function(Settings) _then;

  @override
  $Res call({
    Object? currency = freezed,
    Object? isDarkMode = freezed,
    Object? isFirstOpen = freezed,
    Object? pinPassword = freezed,
    Object? reminder = freezed,
  }) {
    return _then(_value.copyWith(
      currency: currency == freezed
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      isDarkMode: isDarkMode == freezed
          ? _value.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isFirstOpen: isFirstOpen == freezed
          ? _value.isFirstOpen
          : isFirstOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      pinPassword: pinPassword == freezed
          ? _value.pinPassword
          : pinPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      reminder: reminder == freezed
          ? _value.reminder
          : reminder // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$SettingsCopyWith<$Res> implements $SettingsCopyWith<$Res> {
  factory _$SettingsCopyWith(_Settings value, $Res Function(_Settings) then) =
      __$SettingsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String currency,
      bool isDarkMode,
      bool isFirstOpen,
      String? pinPassword,
      DateTime? reminder});
}

/// @nodoc
class __$SettingsCopyWithImpl<$Res> extends _$SettingsCopyWithImpl<$Res>
    implements _$SettingsCopyWith<$Res> {
  __$SettingsCopyWithImpl(_Settings _value, $Res Function(_Settings) _then)
      : super(_value, (v) => _then(v as _Settings));

  @override
  _Settings get _value => super._value as _Settings;

  @override
  $Res call({
    Object? currency = freezed,
    Object? isDarkMode = freezed,
    Object? isFirstOpen = freezed,
    Object? pinPassword = freezed,
    Object? reminder = freezed,
  }) {
    return _then(_Settings(
      currency: currency == freezed
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      isDarkMode: isDarkMode == freezed
          ? _value.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isFirstOpen: isFirstOpen == freezed
          ? _value.isFirstOpen
          : isFirstOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      pinPassword: pinPassword == freezed
          ? _value.pinPassword
          : pinPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      reminder: reminder == freezed
          ? _value.reminder
          : reminder // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$_Settings implements _Settings {
  _$_Settings(
      {this.currency = "USD",
      this.isDarkMode = false,
      this.isFirstOpen = true,
      this.pinPassword,
      this.reminder});

  @JsonKey()
  @override
  final String currency;
  @JsonKey()
  @override
  final bool isDarkMode;
  @JsonKey()
  @override
  final bool isFirstOpen;
  @override
  final String? pinPassword;
  @override
  final DateTime? reminder;

  @override
  String toString() {
    return 'Settings(currency: $currency, isDarkMode: $isDarkMode, isFirstOpen: $isFirstOpen, pinPassword: $pinPassword, reminder: $reminder)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Settings &&
            const DeepCollectionEquality().equals(other.currency, currency) &&
            const DeepCollectionEquality()
                .equals(other.isDarkMode, isDarkMode) &&
            const DeepCollectionEquality()
                .equals(other.isFirstOpen, isFirstOpen) &&
            const DeepCollectionEquality()
                .equals(other.pinPassword, pinPassword) &&
            const DeepCollectionEquality().equals(other.reminder, reminder));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(currency),
      const DeepCollectionEquality().hash(isDarkMode),
      const DeepCollectionEquality().hash(isFirstOpen),
      const DeepCollectionEquality().hash(pinPassword),
      const DeepCollectionEquality().hash(reminder));

  @JsonKey(ignore: true)
  @override
  _$SettingsCopyWith<_Settings> get copyWith =>
      __$SettingsCopyWithImpl<_Settings>(this, _$identity);
}

abstract class _Settings implements Settings {
  factory _Settings(
      {String currency,
      bool isDarkMode,
      bool isFirstOpen,
      String? pinPassword,
      DateTime? reminder}) = _$_Settings;

  @override
  String get currency;
  @override
  bool get isDarkMode;
  @override
  bool get isFirstOpen;
  @override
  String? get pinPassword;
  @override
  DateTime? get reminder;
  @override
  @JsonKey(ignore: true)
  _$SettingsCopyWith<_Settings> get copyWith =>
      throw _privateConstructorUsedError;
}
