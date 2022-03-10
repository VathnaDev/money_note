import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_note/src/screens/home/input/input_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Expense Note"),
        elevation: 0,
      ),
      body: InputScreen(),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Color(0xFF404040),
        selectedItemColor: Color(0xFF404040),
        currentIndex: 0,
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
