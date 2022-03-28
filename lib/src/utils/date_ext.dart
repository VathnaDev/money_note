import 'package:intl/intl.dart';

const ddMMMyyyyEE = "dd MMM yyyy (EE)";
const MMMMyyyy = "MMMM ,yyyy";
const MMMddyyyy = "MMM dd yyyy";

extension DateExt on DateTime {
  String ddMMMyyyyEEFormat({String? locale}) {
    final df = DateFormat(ddMMMyyyyEE, locale);
    return df.format(this);
  }

  String MMMyyyyFormat({String? locale}) {
    final df = DateFormat(MMMMyyyy, locale);
    return df.format(this);
  }

  String MMMddyyyyFormat({String? locale}) {
    final df = DateFormat(MMMddyyyy, locale);
    return df.format(this);
  }
}
