import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/utils/theme.dart';

class ReminderScreen extends HookConsumerWidget {
  const ReminderScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var reminder = useState<TimeOfDay>(TimeOfDay.now());

    final textStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 48,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reminder"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: boxDecoration.copyWith(
                  color: Theme.of(context).backgroundColor),
              child: InkWell(
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: reminder.value,
                  );
                  if (time != null) {
                    reminder.value = time;
                  }
                },
                child: Text(
                  reminder.value.format(context),
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Mono will reminder to note transaction on this time everyday",
              style: Theme.of(context).textTheme.caption,
              textAlign: TextAlign.start,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Set Reminder"),
            )
          ],
        ),
      ),
    );
  }
}
