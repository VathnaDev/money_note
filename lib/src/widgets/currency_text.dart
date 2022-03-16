import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money_note/src/providers/settings_state.dart';
import 'package:money_note/src/utils/theme.dart';

class CurrencyText extends HookConsumerWidget {
  const CurrencyText({
    Key? key,
    required this.value,
    this.colorizeText = true,
    this.textStyle,
  }) : super(key: key);

  final double value;
  final bool? colorizeText;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = TextStyle(
      color: value >= 0 ? colorIncome : colorExpense,
    );
    final currency = ref.watch(
      settingsStateProvider.select((value) => value.currency),
    );
    return Text(
      NumberFormat.simpleCurrency(locale: currency).format(value),
      textAlign: TextAlign.right,
      style: colorizeText == true ? style : textStyle,
    );
  }
}
