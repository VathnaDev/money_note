import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/currency.dart';

class CurrencyScreen extends HookConsumerWidget {
  CurrencyScreen({
    Key? key,
  }) : super(key: key);

  final currencies = [
    Currency("៛", "KHR"),
    Currency("\$", "USD"),
    Currency("¥", "JPY"),
    Currency("£", "GBP"),
    Currency("€", "ALL"),
    Currency("лв", "BGN"),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currency = useState(currencies.first);

    return Scaffold(
      appBar: AppBar(
        title: Text("Currency"),
      ),
      body: ListView(
        children: [
          ...currencies.map(
            (e) => RadioListTile<Currency>(
              title: Row(
                children: [
                  Expanded(child: Text("${e.symbol} 100.000")),
                  Text(e.abbreviate)
                ],
              ),
              onChanged: (value) {
                currency.value = value!;
              },
              groupValue: currency.value,
              value: e,
            ),
          )
        ],
      ),
    );
  }
}
