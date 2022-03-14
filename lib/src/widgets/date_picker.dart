import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/utils/date_ext.dart';

class DatePicker extends HookConsumerWidget {
  DatePicker({
    Key? key,
    required this.initialDate,
    this.onDateSelected,
  }) : super(key: key);

  final DateTime initialDate;
  final Function(DateTime)? onDateSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    var date = useState(initialDate);

    void onDateClicked() async {
      final pickedDate = await showDatePicker(
        context: context,
        initialDate: date.value,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
      );
      if (pickedDate != null) {
        date.value = pickedDate;
        onDateSelected?.call(pickedDate);
      }
    }

    return Material(
      borderRadius: BorderRadius.circular(9999),
      color: Theme.of(context).backgroundColor,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(999)),
              child: InkWell(
                onTap: () {
                  date.value = date.value.subtract(
                    const Duration(days: 1),
                  );
                },
                child: const Icon(Icons.chevron_left),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: onDateClicked,
                child: Text(
                  date.value.displayFormat(),
                  textAlign: TextAlign.center,
                  style: textTheme.bodyText1,
                ),
              ),
            ),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(999)),
              child: InkWell(
                onTap: () {
                  date.value = date.value.add(const Duration(days: 1));
                },
                child: const Icon(Icons.chevron_right),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
