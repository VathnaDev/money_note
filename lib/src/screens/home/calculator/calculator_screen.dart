import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/utils/theme.dart';
import 'package:money_note/src/widgets/calculator_view.dart';

class CalculatorScreen extends HookConsumerWidget {
  const CalculatorScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: CalculatorView(),
    );
  }
}
