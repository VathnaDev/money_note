import 'package:intl/intl.dart';

const ddMMMyyyyEE = "dd MMM yyyy (EE)";
const MMMMyyyy = "MMMM ,yyyy";
const MMMddyyyy = "MMM dd yyyy";

extension DateExt on DateTime {

  String ddMMMyyyyEEFormat() {
    final df = DateFormat(ddMMMyyyyEE);
    return df.format(this);
  }

  String MMMyyyyFormat() {
    final df = DateFormat('MMMyyyy');
    return df.format(this);
  }

  String MMMddyyyyFormat() {
    final df = DateFormat(MMMddyyyy);
    return df.format(this);
  }
}
