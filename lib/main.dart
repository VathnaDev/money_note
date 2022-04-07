import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/category.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/data/object_box.dart';
import 'package:money_note/src/data/services/notification_service.dart';
import 'package:money_note/src/providers/pin_state.dart';
import 'package:money_note/src/providers/providers.dart';
import 'package:money_note/src/providers/settings_state.dart';
import 'package:money_note/src/screens/home/home_screen.dart';
import 'package:money_note/src/screens/notification_demo.dart';
import 'package:money_note/src/screens/onboard/onboard_screen.dart';
import 'package:money_note/src/screens/pin/pin_mode.dart';
import 'package:money_note/src/screens/pin/pin_screen.dart';
import 'package:money_note/src/utils/constants.dart';
import 'package:money_note/src/utils/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final objectbox = await ObjectBox.create();

  final categories = objectbox.store.box<Category>();
  if (categories.isEmpty()) {
    final expense =
        expenseCategories.map((e) => e..type = InputType.expense.name);
    final income = incomeCategories.map((e) => e..type = InputType.income.name);
    categories.putMany([...expense, ...income]);
  }

  final notificationService = NotificationService();
  await notificationService.init();

  runApp(
    ProviderScope(
      overrides: [
        sharedPrefProvider.overrideWithValue(sharedPreferences),
        storeProvider.overrideWithValue(objectbox.store),
        notificationServiceProvider.overrideWithValue(notificationService),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(
      settingsStateProvider.select((value) => value.isDarkMode),
    );
    final isFirstOpen = ref.watch(
      settingsStateProvider.select((value) => value.isFirstOpen),
    );
    final language = ref.watch(
      settingsStateProvider.select((value) => value.language),
    );
    final pinVerified = ref.watch(pinAuthState);

    AppTheme.baseTextTheme = language == 'en'
        ? GoogleFonts.poppinsTextTheme()
        : GoogleFonts.notoSerifKhmerTextTheme();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: Locale(language, ''),
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('km', ''),
      ],
      builder: (context, widget) {
        return ResponsiveWrapper.builder(
          widget,
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
        );
      },
      home: _Unfocus(
        child: isFirstOpen
            ? OnBoardScreen()
            : (pinVerified ? HomeScreen() : PinScreen(pinMode: PinMode.verify)),
      ),
    );
  }
}

/// A widget that unfocus everything when tapped.
///
/// This implements the "Unfocus when tapping in empty space" behavior for the
/// entire application.
class _Unfocus extends HookConsumerWidget {
  const _Unfocus({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}
