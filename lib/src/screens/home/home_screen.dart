import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/screens/home/calculator/calculator_screen.dart';
import 'package:money_note/src/screens/home/input/input_screen.dart';
import 'package:money_note/src/screens/home/report/report_screen.dart';
import 'package:money_note/src/screens/home/settings/settings_screen.dart';

class HomeScreen extends HookConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  final screens = [
    const InputScreen(),
    const CalculatorScreen(),
    ReportScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = useState(0);

    final activeColor = Theme.of(context).primaryColorDark;
    final unActiveColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: IndexedStack(
        children: screens,
        index: selectedTab.value,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: unActiveColor,
        selectedItemColor: activeColor,
        currentIndex: selectedTab.value,
        onTap: (value) {
          FocusScope.of(context).unfocus();
          selectedTab.value = value;
        },
        items: [
          BottomNavigationBarItem(
            label: "Input",
            icon: SvgPicture.asset(
              "assets/icons/Input-1.svg",
              color: unActiveColor,
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Input.svg",
              color: activeColor,
            ),
          ),
          BottomNavigationBarItem(
            label: "Calculator",
            icon: SvgPicture.asset(
              "assets/icons/Calculator-1.svg",
              color: unActiveColor,
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Calculator.svg",
              color: activeColor,
            ),
          ),
          BottomNavigationBarItem(
            label: "Report",
            icon: SvgPicture.asset(
              "assets/icons/Report-1.svg",
              color: unActiveColor,
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Report.svg",
              color: activeColor,
            ),
          ),
          BottomNavigationBarItem(
            label: "Settings",
            icon: SvgPicture.asset(
              "assets/icons/Settings-1.svg",
              color: unActiveColor,
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Settings.svg",
              color: activeColor,
            ),
          ),
        ],
      ),
    );
  }
}
