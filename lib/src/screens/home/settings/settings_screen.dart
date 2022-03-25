import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/providers/providers.dart';
import 'package:money_note/src/providers/settings_state.dart';
import 'package:money_note/src/screens/category/edit_category/edit_category_screen.dart';
import 'package:money_note/src/screens/currency/currency_screen.dart';
import 'package:money_note/src/screens/pin/pin_mode.dart';
import 'package:money_note/src/screens/pin/pin_screen.dart';
import 'package:money_note/src/screens/reminder/reminder_screen.dart';
import 'package:money_note/src/utils/constants.dart';
import 'package:money_note/src/utils/dialog.dart';
import 'package:money_note/src/utils/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
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
                  Text(AppLocalizations.of(context)!.category),
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
                  Text(AppLocalizations.of(context)!.currency),
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
                } else {
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
                  Text(AppLocalizations.of(context)!.pinPassword),
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
                  Text(AppLocalizations.of(context)!.reminder),
                ],
              ),
              trailing: SvgPicture.asset('assets/icons/CaretCircleRight.svg'),
            ),
          ),
          const SizedBox(height: 28),
          Container(
            decoration: boxDecoration,
            child: ListTile(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    title: Text(AppLocalizations.of(context)!.changeLanguage),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...languages.entries.map(
                          (e) => ListTile(
                            onTap: () {
                              ref
                                  .read(settingsStateProvider.notifier)
                                  .setLanugage(e.key);
                              Navigator.of(context).pop();
                            },
                            title: Text(getLanguage(e.key, context)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 4, right: 12),
                    child: SvgPicture.asset(
                      'assets/icons/Books.svg',
                      color: iconColor,
                    ),
                  ),
                  Text(AppLocalizations.of(context)!.language),
                ],
              ),
              trailing: Text(getLanguage(
                  ref.watch(
                    settingsStateProvider.select((value) => value.language),
                  ),
                  context)),
            ),
          ),
          const SizedBox(height: 8),
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
                  Text(AppLocalizations.of(context)!.darkMode),
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
              onTap: () async {
                final result = await showConfirmDialog(
                  context: context,
                  title: AppLocalizations.of(context)!.delete,
                  content:
                      AppLocalizations.of(context)!.deleteAllConfirmMessage,
                );
                if (result) {
                  ref.read(noteRepositoryProvider).clear();
                }
              },
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 4, right: 12),
                    child: SvgPicture.asset('assets/icons/Trash.svg'),
                  ),
                  Text(
                    AppLocalizations.of(context)!.deleteAllData,
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
