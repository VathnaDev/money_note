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
    const ReportScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = useState(0);

    return Scaffold(
      body: IndexedStack(
        children: screens,
        index: selectedTab.value,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Color(0xFF404040),
        selectedItemColor: Color(0xFF404040),
        currentIndex: selectedTab.value,
        onTap: (value) {
          selectedTab.value = value;
        },
        items: [
          BottomNavigationBarItem(
            label: "Input",
            icon: SvgPicture.asset("assets/icons/Input-1.svg"),
            activeIcon: SvgPicture.asset("assets/icons/Input.svg"),
          ),
          BottomNavigationBarItem(
            label: "Calculator",
            icon: SvgPicture.asset("assets/icons/Calculator-1.svg"),
            activeIcon: SvgPicture.asset("assets/icons/Calculator.svg"),
          ),
          BottomNavigationBarItem(
            label: "Report",
            icon: SvgPicture.asset("assets/icons/Report-1.svg"),
            activeIcon: SvgPicture.asset("assets/icons/Report.svg"),
          ),
          BottomNavigationBarItem(
            label: "Settings",
            icon: SvgPicture.asset("assets/icons/Settings-1.svg"),
            activeIcon: SvgPicture.asset("assets/icons/Settings.svg"),
          ),
        ],
      ),
    );
  }
}
