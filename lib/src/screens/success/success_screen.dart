import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/utils/color.dart';

class SuccessScreen extends StatefulHookConsumerWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends ConsumerState<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Color(0xFF1E1F2E),
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
                    position: Tween(
                      begin: Offset(0, 2),
                      end: Offset(0.0, 0),
                    ).animate(
                      useAnimationController(
                          duration: Duration(milliseconds: 500))
                        ..forward(),
                    ),
                    child: ScaleTransition(
                      scale: Tween(begin: 0.5, end: 1.0).animate(
                        useAnimationController(
                          duration: Duration(milliseconds: 500),
                        )..forward(),
                      ),
                      child: FadeTransition(
                        opacity: Tween(begin: 0.0, end: 1.0).animate(
                          useAnimationController(duration: Duration(seconds: 1))
                            ..forward(),
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/icons/check.png",
                            width: 200,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  SlideTransition(
                    position: Tween(
                      begin: Offset(0, 4),
                      end: Offset(0.0, 0),
                    ).animate(
                      useAnimationController(
                        duration: Duration(milliseconds: 500),
                      )..forward(),
                    ),
                    child: FadeTransition(
                      opacity: Tween(begin: 0.0, end: 1.0).animate(
                        useAnimationController(
                          duration: Duration(seconds: 1),
                        )..forward(),
                      ),
                      child: Text(
                        "Transaction Save\nSuccessfully",
                        textAlign: TextAlign.center,
                        style: textTheme.headline5,
                      ),
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
                duration: const Duration(milliseconds: 500),
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
