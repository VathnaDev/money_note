import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/providers/providers.dart';

class NotificationDemo extends HookConsumerWidget {
  const NotificationDemo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Notification"),
          onPressed: () async {
            ref.read(notificationServiceProvider).scheduleReminderUser(
                  DateTime.now().add(Duration(seconds: 10)),
                );
          },
        ),
      ),
    );
  }
}
