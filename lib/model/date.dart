import 'package:intl/intl.dart';

class Date {
  DateTime date;

  Date.now() {
    date = DateTime.now();
  }

  Date.fromString(int date) {
    this.date = DateTime.fromMillisecondsSinceEpoch(date);
  }

  String get dateString => DateFormat.yMMMd().format(date);

  int get dateTime => date.millisecondsSinceEpoch;
}
