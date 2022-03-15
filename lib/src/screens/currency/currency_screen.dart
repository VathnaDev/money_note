import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/currency.dart';
import 'package:money_note/src/utils/theme.dart';

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
      body: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: currencies.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(
                indent: 30,
                endIndent: 20,
                thickness: 1,
                height: 1,
              ),
          itemBuilder: (BuildContext context, int index) {
            final e = currencies[index];
            return RadioListTile<Currency>(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
              title: Row(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: boxDecoration,
                    child: Center(child: Text(e.symbol)),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: Text("${e.symbol} 100.000")),
                  Text(e.abbreviate)
                ],
              ),
              onChanged: (value) {
                currency.value = value!;
              },
              groupValue: currency.value,
              value: e,
            );
          }),
    );
  }
}