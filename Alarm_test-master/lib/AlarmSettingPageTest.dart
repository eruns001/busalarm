import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AlarmInfo.dart';
import 'AlarmPage.dart';
import 'AlarmSettingDetailPage.dart';

List<AlarmInfo> _alarmList = [
  AlarmInfo(
    busNum: '8',
    arrival: DateTime.now().add(Duration(minutes: 2, seconds: 30)),
    useHour: true,
    useMinute: true,
    beforeHour: 0,
    beforeMinute: 0,
    enable: false,
    alarmAtNext: false,
  ),
];
void addAlarmInfoList(AlarmInfo alarmInfo){
  _alarmList.add(alarmInfo);
}

class AlarmSettingPageTest extends StatefulWidget {
  const AlarmSettingPageTest({Key key}) : super(key: key);

  _AlarmSettingPageTestState createState() => _AlarmSettingPageTestState();
}

class _AlarmSettingPageTestState extends State<AlarmSettingPageTest> {
  Timer _alarm;

  Widget _buildPage() {
    return Container(
      child: ListView.builder(
        itemCount: _alarmList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (_alarmList.length == 0) {
            return Center(
              child: Column(
                children: <Widget>[
                  Text('버스를 즐겨찾기 등록하면'),
                  Text('알람기능을 사용할 수 있어요.'),
                ],
              ),
            );
          } else {
            if (index == 0) {
              return Container(
                child: Text(
                  '총 ${_alarmList.length} 개',
                ),
              );
            } else {
              return Container(
                height: 80,
                color: Colors.yellow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                            _alarmList.elementAt(index - 1).busNum.toString() +
                                ' 번',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          final AlarmInfo result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return AlarmSettingDetailPage(
                                  alarmInfo: _alarmList.elementAt(index - 1),
                                );
                              },
                            ),
                          );

                          if (result == null) {
                            /* do nothing */
                          } else {
                            setState(
                              () {
                                _alarmList[index - 1] = result;
                              },
                            );
                          }
                        },
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        VerticalDivider(),
                        CupertinoSwitch(
                          value: _alarmList.elementAt(index - 1).enable,
                          onChanged: (bool value) {
                            _alarmList.elementAt(index - 1).enable = value;

                            if (_alarmList.elementAt(index - 1).enable) {
                              _alarmList.elementAt(index - 1).alarmAtNext =
                                  false;
                              _alarmList.elementAt(index - 1).arrival =
                                  DateTime.now()
                                      .add(Duration(minutes: 2, seconds: 30));
                            } else {}

                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }

  _alarmCallback() {
    bool flag = false;
    print(DateTime.now());
    for (int index = 0; index < _alarmList.length; index++) {
      DateTime _now = DateTime.now();
      DateTime _target = _alarmList.elementAt(index).arrival.subtract(
            Duration(
                hours: _alarmList.elementAt(index).beforeHour,
                minutes: _alarmList.elementAt(index).beforeMinute),
          );
      print(_target);

      if (_alarmList.elementAt(index).enable &&
          _target.year == _now.year &&
          _target.month == _now.month &&
          _target.day == _now.day &&
          _target.hour == _now.hour &&
          _target.minute <= _now.minute &&
          !_alarmList.elementAt(index).alarmAtNext &&
          !flag) {
        flag = true;
        _alarmList.elementAt(index).alarmAtNext = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return AlarmPage(alarmInfo: _alarmList.elementAt(index));
            },
          ),
        );
      } else if (flag) {
        break;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _alarm = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        _alarmCallback();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    _alarm?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알람 설정 관리'),
        centerTitle: true,
      ),
      body: _buildPage(),
    );
  }
}
