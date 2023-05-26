import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String toStringWithDate([String format = 'dd-MM-yyyy']) {
    return DateFormat(format).format(this);
  }

  String toStringWithTime([String format = 'HH:mm']) {
    return DateFormat(format).format(this);
  }

  String toStringWithJapanDate([String format = 'yyyy/MM/dd(E)']) {
    return DateFormat(format, 'ja').format(this);
  }
}
