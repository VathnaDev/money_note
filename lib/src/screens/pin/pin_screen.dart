import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/providers/pin_state.dart';
import 'package:money_note/src/providers/settings_state.dart';
import 'package:money_note/src/screens/pin/pin_mode.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PinScreen extends HookConsumerWidget {
  PinScreen({
    Key? key,
    this.pinMode = PinMode.verify,
  }) : super(key: key);

  final PinMode pinMode;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isSuccess = useState(false);
    var userPin = ref.watch(
      settingsStateProvider.select((value) => value.pinPassword),
    );

    var pins = useState(['', '', '', '']);
    final pinNodes = useState(
      pins.value.map((e) => FocusNode()).toList(),
    );

    final errorAnimation = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );
    final errorTransition = TweenSequence(
      [
        TweenSequenceItem(
          tween: Tween(
            begin: const Offset(0, 0.0),
            end: const Offset(-0.3, 0.0),
          ),
          weight: 25,
        ),
        TweenSequenceItem(
          tween: Tween(
            begin: const Offset(-0.3, 0.0),
            end: const Offset(0, 0.0),
          ),
          weight: 25,
        ),
        TweenSequenceItem(
          tween: Tween(
            begin: const Offset(0, 0.0),
            end: const Offset(0.3, 0.0),
          ),
          weight: 25,
        ),
        TweenSequenceItem(
          tween: Tween(
            begin: const Offset(0.3, 0.0),
            end: const Offset(0, 0.0),
          ),
          weight: 25,
        ),
      ],
    ).animate(errorAnimation);

    void onSubmit() {
      switch (pinMode) {
        case PinMode.verify:
          final isValid = _formKey.currentState?.validate();
          if (isValid == true) {
            isSuccess.value = true;
            Future.delayed(const Duration(milliseconds: 500), () {
              ref.watch(pinAuthState.state).state = true;
            });
          } else {
            errorAnimation.reset();
            errorAnimation.forward();
          }
          break;

        case PinMode.set:
          ref.read(settingsStateProvider.notifier).setPin(pins.value.join());
          break;

        case PinMode.update:
          final isValid = _formKey.currentState?.validate();
          if (isValid == true) {
            isSuccess.value = true;
            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => PinScreen(pinMode: PinMode.updatePin),
              ));
            });
          } else {
            errorAnimation.reset();
            errorAnimation.forward();
          }
          break;
        case PinMode.updatePin:
          ref.read(settingsStateProvider.notifier).setPin(pins.value.join());
          Navigator.of(context).pop(true);
          break;
      }
    }

    useEffect(() {
      pinCompleteListener() {
        if (!pins.value.contains("")) {
          FocusManager.instance.primaryFocus?.unfocus();
          onSubmit();
        }
      }

      pins.addListener(pinCompleteListener);

      return () {
        pins.removeListener(pinCompleteListener);
      };
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.pinPassword),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...List.generate(pins.value.length, (index) {
                    return SlideTransition(
                      position: errorTransition,
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: TextFormField(
                          validator: (value) {
                            if (pins.value.join() == userPin) {
                              return null;
                            } else {
                              return '';
                            }
                          },
                          focusNode: pinNodes.value[index],
                          decoration: InputDecoration(
                            filled: true,
                            errorStyle: const TextStyle(height: 0),
                            enabledBorder: isSuccess.value == true
                                ? const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.green,
                                    ),
                                  )
                                : null,
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                          ],
                          onChanged: (value) {
                            if (index < pinNodes.value.length - 1 &&
                                value.isNotEmpty) {
                              pinNodes.value[index + 1].requestFocus();

                              pins.value[index] = value;
                              pins.value = List.from(pins.value);
                            } else {
                              if (value.isNotEmpty) {
                                pins.value[index] = value;
                                pins.value = List.from(pins.value);
                              } else {
                                pins.value[index] = '';
                                pins.value = List.from(pins.value);
                                if (index > 0) {
                                  pinNodes.value[index - 1].requestFocus();
                                }
                              }
                            }
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          expands: true,
                          maxLines: null,
                          minLines: null,
                        ),
                      ),
                    );
                  }),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: pins.value.contains("") ? null : onSubmit,
                child: Text(
                  pinMode == PinMode.set || pinMode == PinMode.updatePin
                      ? AppLocalizations.of(context)!.setPinPassword
                      : AppLocalizations.of(context)!.verify,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SineCurve extends Curve {
  const SineCurve({this.count = 3});

  final double count;

  // t = x
  @override
  double transformInternal(double t) {
    var val = sin(count * 2 * pi * t) * 0.5 + 0.5;
    // var val = sin(2 * pi * t);
    return val; //f(x)
  }
}
