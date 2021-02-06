import 'package:flutter/foundation.dart';

class AlarmInfo {
  String busNum;
  DateTime arrival;
  bool useHour;
  bool useMinute;
  int beforeHour;
  int beforeMinute;
  bool alarmAtNext = false;
  bool enable = false;

  AlarmInfo({
    this.busNum,
    this.arrival,
    @required this.useHour,
    @required this.useMinute,
    @required this.beforeHour,
    @required this.beforeMinute,
    this.alarmAtNext,
    this.enable,
  });
}
