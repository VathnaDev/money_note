import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:money_note/src/utils/theme.dart';

class CalculatorView extends HookConsumerWidget {
  const CalculatorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var input = useState('0');
    var result = useState<String?>(null);

    void onButtonTap(String key) {
      if (input.value == "0" && key == "0" || input.value == "0") {
        input.value = "";
      }
      switch (key) {
        case '.':
          if (input.value.isEmpty) {
            input.value = "0";
          }
          input.value += key;
          break;
        case '+':
        case '-':
        case 'X':
        case '/':
          if (input.value.isEmpty) {
            input.value = "0";
            return;
          }
          if (input.value.endsWith('+') ||
              input.value.endsWith('-') ||
              input.value.endsWith('x') ||
              input.value.endsWith('/')) {
            input.value = input.value.substring(0, input.value.length - 1) +
                key.toLowerCase();
          } else {
            input.value += key.toLowerCase();
          }
          break;
        case '=':
          RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
          final i = input.value.toString().replaceAll("x", "*");
          final p = Parser();
          final exp = p.parse(i);
          String output = exp
              .evaluate(EvaluationType.REAL, ContextModel())
              .toString()
              .replaceAll(regex, '');

          result.value = input.value;
          input.value = output;
          print(output);
          break;
        case 'AC':
          input.value = '0';
          result.value = null;
          break;
        case 'Del':
          if (input.value.length == 1 || input.value.isEmpty) {
            input.value = '0';
          } else {
            input.value = input.value.substring(
              0,
              input.value.length - 1,
            );
          }
          break;
        default:
          {
            input.value += key;
          }
      }
    }

    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (result.value != null)
                    Text(
                      result.value!,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: colorGrey,
                          ),
                      textAlign: TextAlign.end,
                    ),
                  Text(
                    input.value,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontSize: 56,
                        ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CalculatorButton(text: "7", onTap: onButtonTap),
                      CalculatorButton(text: "8", onTap: onButtonTap),
                      CalculatorButton(text: "9", onTap: onButtonTap),
                      CalculatorButton(
                          text: "+", textColor: colorBlue, onTap: onButtonTap),
                      CalculatorButton(
                          text: "AC", textColor: colorRed, onTap: onButtonTap),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CalculatorButton(text: "4", onTap: onButtonTap),
                      CalculatorButton(text: "5", onTap: onButtonTap),
                      CalculatorButton(text: "6", onTap: onButtonTap),
                      CalculatorButton(
                          text: "-", textColor: colorBlue, onTap: onButtonTap),
                      CalculatorButton(
                          text: "Del", textColor: colorRed, onTap: onButtonTap),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CalculatorButton(text: "1", onTap: onButtonTap),
                              CalculatorButton(
                                  text: "%",
                                  textColor: colorBlue,
                                  onTap: onButtonTap),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CalculatorButton(text: "2", onTap: onButtonTap),
                              CalculatorButton(text: "0", onTap: onButtonTap),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CalculatorButton(text: "3", onTap: onButtonTap),
                              CalculatorButton(text: ".", onTap: onButtonTap),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CalculatorButton(
                                  text: "X",
                                  textColor: colorBlue,
                                  onTap: onButtonTap),
                              CalculatorButton(
                                  text: "/",
                                  textColor: colorBlue,
                                  onTap: onButtonTap),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CalculatorButton(text: "=", onTap: onButtonTap),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  CalculatorButton({
    Key? key,
    required this.text,
    this.textColor,
    this.onTap,
  }) : super(key: key);

  final String text;
  final Color? textColor;
  final Function(String)? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: boxDecoration.copyWith(
            color: Theme.of(context).backgroundColor,
            border: Border(),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                onTap?.call(text);
              },
              child: Center(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: textColor,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
