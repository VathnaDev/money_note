import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/widgets/calculator_view.dart';

class CalculatorScreen extends HookConsumerWidget {
  const CalculatorScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.calculator)),
      body: const CalculatorView(),
    );
  }
}
