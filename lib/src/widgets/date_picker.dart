import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:intl/locale.dart';
import 'package:money_note/src/utils/constants.dart';
import 'package:money_note/src/utils/date_ext.dart';
import 'package:intl/intl.dart';

class DatePicker extends HookConsumerWidget {
  DatePicker(
      {Key? key,
      required this.initialDate,
      this.onDateChanged,
      this.incrementBy = const Duration(days: 1),
      this.displayFormat = ddMMMyyyyEE})
      : super(key: key);

  final DateTime initialDate;
  final Function(DateTime)? onDateChanged;
  final Duration incrementBy;
  final String displayFormat;

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
        onDateChanged?.call(pickedDate);
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
                  date.value = date.value.subtract(incrementBy);
                  onDateChanged?.call(date.value);
                },
                child: const Icon(Icons.chevron_left),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: onDateClicked,
                child: Text(
                  DateFormat(
                    displayFormat,
                    Localizations.localeOf(context).languageCode,
                  ).format(date.value),
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
                  date.value = date.value.add(incrementBy);
                  onDateChanged?.call(date.value);
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
