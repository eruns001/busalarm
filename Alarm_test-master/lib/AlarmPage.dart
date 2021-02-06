import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'AlarmInfo.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({
    Key key,
    @required this.alarmInfo,
  }) : super(key: key);

  final AlarmInfo alarmInfo;

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  Timer _timer;

  Future _timerCallBack() async {
    HapticFeedback.vibrate();
    await Future.delayed(Duration(milliseconds: 100));
    HapticFeedback.heavyImpact();
    await Future.delayed(Duration(milliseconds: 100));
    HapticFeedback.heavyImpact();
    await Future.delayed(Duration(milliseconds: 100));
    HapticFeedback.heavyImpact();
    await Future.delayed(Duration(milliseconds: 100));
  }

  Widget _buildPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.alarm_rounded,
            size: 200,
            color: Colors.white,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(
              '버스도착 ' +
                  ((widget.alarmInfo.useHour)
                      ? widget.alarmInfo.beforeHour.toString() + ' 시간 '
                      : '') +
                  ((widget.alarmInfo.useMinute)
                      ? widget.alarmInfo.beforeMinute.toString() + ' 분 '
                      : '') +
                  '전입니다.',
              textScaleFactor: 0.82,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
          Container(
            width: 100,
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white),
            ),
            child: CupertinoButton(
              child: Text('알람 끄기', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _timer = Timer.periodic(
      Duration(milliseconds: 1000),
      (timer) async {
        await _timerCallBack();
      },
    );

    return Scaffold(
      body: Container(
        color: Colors.black45,
        child: _buildPage(),
      ),
    );
  }
}
