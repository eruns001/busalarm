import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AlarmInfo.dart';
import 'AlarmPage.dart';
import 'SecondPage.dart';

class AlarmSettingPage extends StatefulWidget {
  const AlarmSettingPage({Key key,}) : super(key: key);

  _AlarmSettingPageState createState() => _AlarmSettingPageState();
}

class _AlarmSettingPageState extends State<AlarmSettingPage> {
  Timer _timer;
  StreamController<bool> _buttonController =
  new StreamController<bool>.broadcast();
  StreamController<bool> _visibilityController =
  new StreamController<bool>.broadcast();
  StreamController<Duration> _dateController =
  new StreamController<Duration>.broadcast();

  TextEditingController _minController = new TextEditingController(text: null);
  TextEditingController _secondController =
  new TextEditingController(text: null);

  TextEditingController _displayHourController =
  new TextEditingController(text: null);
  TextEditingController _displayMinController =
  new TextEditingController(text: null);

  DateTime _targetTime;

  AlarmInfo _alarmInfo = new AlarmInfo(
      useHour: false, useMinute: true, beforeHour: 0, beforeMinute: 15);

  bool _useHour = false;
  bool _useMin = false;

  void _setAlarm(
      TextEditingController _minController,
      TextEditingController _secondController,
      ) {
    _buttonController.add(true);
    _visibilityController.add(true);

    _targetTime = DateTime.now();
    _targetTime = _targetTime.add(
      Duration(
        minutes: int.parse(
            (_minController.text.length == 0) ? '0' : _minController.text),
        seconds: int.parse((_secondController.text.length == 0)
            ? '1'
            : _secondController.text),
      ),
    );

    _timer = Timer.periodic(
      Duration(seconds: 1),
          (timer) {
        _timerCallBack();
      },
    );
  }

  void _timerCallBack() {
    DateTime _nowTime = DateTime.now();
    DateTime _alarmTime = _targetTime;
    print('nowTime    : ' + _nowTime.toString());
    print('targetTIme : ' + _targetTime.toString());
    print('alarmTime  : ' + _alarmTime.toString());

    _dateController.add(_targetTime.difference(_nowTime));

    if (_nowTime.year == _alarmTime.year &&
        _nowTime.month == _alarmTime.month &&
        _nowTime.day == _alarmTime.day &&
        _nowTime.hour == _alarmTime.hour &&
        _nowTime.minute ==_alarmTime.minute &&
        _nowTime.second == _alarmTime.second) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return AlarmPage(alarmInfo: _alarmInfo);
          },
        ),
      );
      _timer?.cancel();
      _buttonController.add(false);
      _visibilityController.add(false);
    }
  }

  Widget _buildPage() {
    return ListView(
      children: <Widget>[
        Container(
          height: 50,
        ),
        Container(
          child: Center(
            child: Text('알람 울릴 시간 설정'),
          ),
        ),
        Container(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 20,
              width: 70,
              child: TextField(
                textAlign: TextAlign.end,
                controller: _minController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: '분',
                  suffixIcon: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.clear,
                      size: 15,
                    ),
                    onPressed: () {
                      _minController.clear();
                    },
                  ),
                ),
                maxLength: 2,
              ),
            ),
            Container(
              width: 30,
            ),
            Container(
              height: 20,
              width: 70,
              child: TextField(
                textAlign: TextAlign.end,
                controller: _secondController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: '초',
                  suffixIcon: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.clear,
                      size: 15,
                    ),
                    onPressed: () {
                      _secondController.clear();
                    },
                  ),
                ),
                maxLength: 2,
              ),
            ),
          ],
        ),
        Container(
          height: 20,
        ),
        Container(
          height: 30,
          child: StreamBuilder(
            stream: _buttonController.stream,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return FlatButton(
                child: Text('알람 설정'),
                onPressed: (snapshot.data ?? false)
                    ? null
                    : () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  currentFocus.unfocus();
                  _setAlarm(_minController, _secondController);
                },
              );
            },
          ),
        ),
        Container(
          height: 20,
        ),
        Container(
          child: FlatButton(
            child: Text('알람 취소'),
            onPressed: () {
              _timer?.cancel();
              _buttonController.add(false);
              _visibilityController.add(false);
            },
          ),
        ),
        Container(
          height: 20,
        ),
        Container(
          child: Center(
            child: Text('알람 화면에 표시될 시간 설정'),
          ),
        ),
        Container(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 20,
              width: 80,
              child: TextField(
                textAlign: TextAlign.end,
                controller: _displayHourController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: '시간',
                  suffixIcon: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.clear,
                      size: 15,
                    ),
                    onPressed: () {
                      _displayHourController.clear();
                    },
                  ),
                ),
                maxLength: 2,
              ),
            ),
            Container(
              width: 20,
            ),
            Container(
              height: 20,
              width: 80,
              child: TextField(
                textAlign: TextAlign.end,
                controller: _displayMinController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: '분',
                  suffixIcon: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.clear,
                      size: 15,
                    ),
                    onPressed: () {
                      _displayMinController.clear();
                    },
                  ),
                ),
                maxLength: 2,
              ),
            ),
          ],
        ),
        Container(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Checkbox(
                  value: _useHour,
                  onChanged: (bool value) {
                    setState(
                          () {
                        _useHour = value;
                      },
                    );
                  },
                ),
                Text('시간 표시'),
              ],
            ),
            Container(
              width: 20,
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: _useMin,
                  onChanged: (bool value) {
                    setState(
                          () {
                        _useMin = value;
                      },
                    );
                  },
                ),
                Text('분 표시        '),
              ],
            ),
          ],
        ),
        Container(
          child: FlatButton(
            child: Text('설정'),
            onPressed: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              currentFocus.unfocus();
              _alarmInfo = new AlarmInfo(
                useHour: _useHour,
                useMinute: _useMin,
                beforeHour: int.parse((_displayHourController.text.length == 0)
                    ? '0'
                    : _displayHourController.text),
                beforeMinute: int.parse((_displayMinController.text.length == 0)
                    ? '0'
                    : _displayMinController.text),
              );
            },
          ),
        ),
        Container(
          height: 20,
        ),
        Container(
          child: FlatButton(
            child: Text('출력'),
            onPressed: () {
              setState(
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AlarmPage(alarmInfo: _alarmInfo);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
        StreamBuilder(
          stream: _visibilityController.stream,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return Visibility(
              visible: (snapshot.data ?? false),
              child: StreamBuilder(
                stream: _dateController.stream,
                builder:
                    (BuildContext context, AsyncSnapshot<Duration> snapshot) {
                  return Container(
                    height: 100,
                    child: Text((snapshot.data ?? 'loading').toString()),
                  );
                },
              ),
            );
          },
        ),
        Container(
          child: FlatButton(
            child: Text('다음페이지'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SecondPage();
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    //_timer?.cancel();
    _buttonController.close();
    _visibilityController.close();
    _dateController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarm Setting Page'),
      ),
      body: _buildPage(),
    );
  }
}