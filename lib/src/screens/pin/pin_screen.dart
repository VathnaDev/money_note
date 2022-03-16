import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/providers/settings_state.dart';
import 'package:money_note/src/screens/pin/pin_mode.dart';

class PinScreen extends HookConsumerWidget {
  PinScreen({
    Key? key,
    this.pinMode = PinMode.verify,
  }) : super(key: key);

  final PinMode pinMode;
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userPin = ref.watch(
      settingsStateProvider.select((value) => value.pinPassword),
    );

    var pins = useState(['', '', '', '']);
    final pinNodes = useState(
      pins.value.map((e) => FocusNode()).toList(),
    );

    void onSubmit() {
      switch (pinMode) {
        case PinMode.verify:
          final isValid = _formKey.currentState?.validate();
          if (isValid == true) {
            Navigator.of(context).pop(true);
          }
          break;

        case PinMode.set:
          ref.read(settingsStateProvider.notifier).setPin(pins.value.join());
          break;

        case PinMode.update:
          final isValid = _formKey.currentState?.validate();
          if (isValid == true) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => PinScreen(pinMode: PinMode.updatePin),
            ));
          }
          break;
        case PinMode.updatePin:
          ref.read(settingsStateProvider.notifier).setPin(pins.value.join());
          Navigator.of(context).pop(true);
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("PIN Password"),
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
                    return SizedBox(
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
                        decoration: const InputDecoration(
                          filled: true,
                          errorStyle: TextStyle(height: 0),
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
                    );
                  }),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: pins.value.contains("") ? null : onSubmit,
                child: Text(
                  pinMode == PinMode.set || pinMode ==PinMode.updatePin ? "Set PIN Password" : "Verify",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
