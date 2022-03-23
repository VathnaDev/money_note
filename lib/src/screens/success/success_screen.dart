import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SuccessScreen extends StatefulHookConsumerWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends ConsumerState<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final position = Tween(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 0.0),
    );
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SlideTransition(
                    position: position.animate(
                      useAnimationController(
                          duration: Duration(milliseconds: 300))
                        ..forward(),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/icons/check.png",
                        width: 200,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  SlideTransition(
                    position: position.animate(
                      useAnimationController(
                          duration: Duration(milliseconds: 300))
                        ..forward(),
                    ),
                    child: Text(
                      "Transaction Save\nSuccessfully",
                      textAlign: TextAlign.center,
                      style: textTheme.headline5,
                    ),
                  ),
                  SizedBox(height: 30),
                  Divider(),
                  SizedBox(height: 30),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TweenAnimationBuilder(
                tween: Tween<double>(
                  begin: 48,
                  end: MediaQuery.of(context).size.width,
                ),
                duration: const Duration(milliseconds: 300),
                builder: (_, double width, __) {
                  return SizedBox(
                    width: width,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("BACK HOME"),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
