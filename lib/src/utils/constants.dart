import 'package:flutter/material.dart';
import 'package:money_note/src/data/category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final expenseCategories = [
  Category(name: "Bank", icon: "assets/icons/Bank.svg"),
  Category(name: "Food", icon: "assets/icons/Food.svg"),
  Category(name: "Medicine", icon: "assets/icons/Medican.svg"),
  Category(name: "Gym", icon: "assets/icons/Gym.svg"),
  Category(name: "Coffee", icon: "assets/icons/Coffee.svg"),
  Category(name: "Shopping", icon: "assets/icons/Market.svg"),
  Category(name: "Pets", icon: "assets/icons/Cat.svg"),
  Category(name: "Party", icon: "assets/icons/Party.svg"),
  Category(name: "Gift", icon: "assets/icons/Gift.svg"),
  Category(name: "Gas", icon: "assets/icons/Gas.svg"),
];

final incomeCategories = [
  Category(name: "Freelance", icon: "assets/icons/Challenge.svg"),
  Category(name: "Salary", icon: "assets/icons/Money.svg"),
  Category(name: "Bonus", icon: "assets/icons/Coin.svg"),
  Category(name: "Loan", icon: "assets/icons/User.svg"),
];

final allCategories = [
  Category(name: "Baby", icon: "assets/icons/Baby.svg"),
  Category(name: "Bag", icon: "assets/icons/Bag.svg"),
  Category(name: "Bank", icon: "assets/icons/Bank.svg"),
  Category(name: "Bird", icon: "assets/icons/Bird.svg"),
  Category(name: "Birthday", icon: "assets/icons/Birthday.svg"),
  Category(name: "Boat", icon: "assets/icons/Boat.svg"),
  Category(name: "Books", icon: "assets/icons/Books.svg"),
  Category(name: "Brain", icon: "assets/icons/Brain.svg"),
  Category(name: "Building", icon: "assets/icons/Building.svg"),
  Category(name: "Calculator-1", icon: "assets/icons/Calculator-1.svg"),
  Category(name: "Camera", icon: "assets/icons/Camera.svg"),
  Category(name: "Car", icon: "assets/icons/Car.svg"),
  Category(name: "Cat", icon: "assets/icons/Cat.svg"),
  Category(name: "Chair", icon: "assets/icons/Chair.svg"),
  Category(name: "Challenge", icon: "assets/icons/Challenge.svg"),
  Category(name: "Clothes", icon: "assets/icons/Clothes.svg"),
  Category(name: "Coffee", icon: "assets/icons/Coffee.svg"),
  Category(name: "Coin", icon: "assets/icons/Coin.svg"),
  Category(name: "Coin-1", icon: "assets/icons/Coin-1.svg"),
  Category(name: "Cook", icon: "assets/icons/Cook.svg"),
  Category(name: "Cup", icon: "assets/icons/Cup.svg"),
  Category(name: "Cycles", icon: "assets/icons/Cycles.svg"),
  Category(name: "Dinner", icon: "assets/icons/Dinner.svg"),
  Category(name: "Dog", icon: "assets/icons/Dog.svg"),
  Category(name: "Facemask", icon: "assets/icons/Facemask.svg"),
  Category(name: "Fix", icon: "assets/icons/Fix.svg"),
  Category(name: "Flower", icon: "assets/icons/Flower.svg"),
  Category(name: "Food", icon: "assets/icons/Food.svg"),
  Category(name: "Football", icon: "assets/icons/Football.svg"),
  Category(name: "Fun", icon: "assets/icons/Fun.svg"),
  Category(name: "Gas", icon: "assets/icons/Gas.svg"),
  Category(name: "Gift", icon: "assets/icons/Gift.svg"),
  Category(name: "Glass", icon: "assets/icons/Glass.svg"),
  Category(name: "Gym", icon: "assets/icons/Gym.svg"),
  Category(name: "House", icon: "assets/icons/House.svg"),
  Category(name: "Input-1", icon: "assets/icons/Input-1.svg"),
  Category(name: "Lawer", icon: "assets/icons/Lawer.svg"),
  Category(name: "Map", icon: "assets/icons/Map.svg"),
  Category(name: "Market", icon: "assets/icons/Market.svg"),
  Category(name: "Medican", icon: "assets/icons/Medican.svg"),
  Category(name: "Money", icon: "assets/icons/Money.svg"),
  Category(name: "Music", icon: "assets/icons/Music.svg"),
  Category(name: "Package", icon: "assets/icons/Package.svg"),
  Category(name: "Party", icon: "assets/icons/Party.svg"),
  Category(name: "Pie", icon: "assets/icons/Pie.svg"),
  Category(name: "Pill", icon: "assets/icons/Pill.svg"),
  Category(name: "Plane", icon: "assets/icons/Plane.svg"),
  Category(name: "Receipt", icon: "assets/icons/Receipt.svg"),
  Category(name: "Report-1", icon: "assets/icons/Report-1.svg"),
  Category(name: "Run", icon: "assets/icons/Run.svg"),
  Category(name: "Sea", icon: "assets/icons/Sea.svg"),
  Category(name: "Settings-1", icon: "assets/icons/Settings-1.svg"),
  Category(name: "Shower", icon: "assets/icons/Shower.svg"),
  Category(name: "Store", icon: "assets/icons/Store.svg"),
  Category(name: "Study", icon: "assets/icons/Study.svg"),
  Category(name: "Study_1", icon: "assets/icons/Study_1.svg"),
  Category(name: "TennisBall", icon: "assets/icons/TennisBall.svg"),
  Category(name: "Train", icon: "assets/icons/Train.svg"),
  Category(name: "User", icon: "assets/icons/User.svg"),
  Category(name: "Wallet", icon: "assets/icons/Wallet.svg"),
  Category(name: "WC", icon: "assets/icons/WC.svg"),
];

final languages = {
  "km": "Khmer",
  "en": "English",
};

String getLanguage(String code, BuildContext context) {
  switch (code) {
    case "km":
      return AppLocalizations.of(context)!.khmer;
    case "en":
      return AppLocalizations.of(context)!.english;
    default:
      return "";
  }
}
