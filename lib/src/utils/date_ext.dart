import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String displayFormat() {
    final df = DateFormat('dd MMM yyyy (EE)');
    return df.format(this);
  }
}
