import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/providers/settings_state.dart';
import 'package:money_note/src/screens/category/edit_category/edit_category_screen.dart';
import 'package:money_note/src/screens/currency/currency_screen.dart';
import 'package:money_note/src/screens/pin/pin_mode.dart';
import 'package:money_note/src/screens/pin/pin_screen.dart';
import 'package:money_note/src/screens/reminder/reminder_screen.dart';
import 'package:money_note/src/utils/theme.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pin = ref.watch(
      settingsStateProvider.select((value) => value.pinPassword),
    );

    final iconColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            decoration: boxDecoration,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditCategoryScreen(),
                  ),
                );
              },
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 4, right: 12),
                    child: SvgPicture.asset(
                      'assets/icons/SquaresFour.svg',
                      color: iconColor,
                    ),
                  ),
                  Text("Category"),
                ],
              ),
              trailing: SvgPicture.asset('assets/icons/CaretCircleRight.svg'),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: boxDecoration,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CurrencyScreen(),
                  ),
                );
              },
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 4, right: 12),
                    child: SvgPicture.asset(
                      'assets/icons/CurrencyCircleDollar.svg',
                      color: iconColor,
                    ),
                  ),
                  Text("Currency"),
                ],
              ),
              trailing: SvgPicture.asset('assets/icons/CaretCircleRight.svg'),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: boxDecoration,
            child: ListTile(
              onTap: () {
                if (pin == null || pin.isEmpty) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PinScreen(pinMode: PinMode.set),
                    ),
                  );
                }else{
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PinScreen(pinMode: PinMode.update),
                    ),
                  );
                }
              },
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 4, right: 12),
                    child: SvgPicture.asset(
                      'assets/icons/LockKey.svg',
                      color: iconColor,
                    ),
                  ),
                  Text("PIN Password"),
                ],
              ),
              trailing: SvgPicture.asset('assets/icons/CaretCircleRight.svg'),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: boxDecoration,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReminderScreen(),
                  ),
                );
              },
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 4, right: 12),
                    child: SvgPicture.asset(
                      'assets/icons/BellSimpleRinging.svg',
                      color: iconColor,
                    ),
                  ),
                  Text("Reminder"),
                ],
              ),
              trailing: SvgPicture.asset('assets/icons/CaretCircleRight.svg'),
            ),
          ),
          const SizedBox(height: 28),
          Container(
            decoration: boxDecoration,
            child: SwitchListTile(
              activeColor: Theme.of(context).colorScheme.secondary,
              onChanged: (value) {
                ref.read(settingsStateProvider.notifier).setIsDarkMode(value);
              },
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 4, right: 12),
                    child: SvgPicture.asset(
                      'assets/icons/Mode.svg',
                      color: iconColor,
                    ),
                  ),
                  Text("Dark Mode"),
                ],
              ),
              value: ref.watch(
                settingsStateProvider.select((value) => value.isDarkMode),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: boxDecoration,
            child: ListTile(
              onTap: () {},
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 4, right: 12),
                    child: SvgPicture.asset('assets/icons/Trash.svg'),
                  ),
                  Text(
                    "Delete All Data",
                    style: TextStyle(color: colorRed),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
