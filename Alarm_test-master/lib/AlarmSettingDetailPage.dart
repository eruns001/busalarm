import 'package:alarm_test/AlarmInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlarmSettingDetailPage extends StatefulWidget {
  const AlarmSettingDetailPage({
    Key key,
    @required this.alarmInfo,
  }) : super(key: key);

  final AlarmInfo alarmInfo;

  @override
  _AlarmSettingDetailPageState createState() => _AlarmSettingDetailPageState();
}

class _AlarmSettingDetailPageState extends State<AlarmSettingDetailPage> {
  Widget _buildPage(TextEditingController _displayHourController,
      TextEditingController _displayMinController, AlarmInfo _alarmInfo) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
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
                    value: _alarmInfo.useHour,
                    onChanged: (bool value) {
                      setState(
                        () {
                          _alarmInfo.useHour = value;
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
                    value: _alarmInfo.useMinute,
                    onChanged: (bool value) {
                      setState(
                        () {
                          _alarmInfo.useMinute = value;
                        },
                      );
                    },
                  ),
                  Text('분 표시        '),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActions(TextEditingController _displayHourController,
      TextEditingController _displayMinController, AlarmInfo _alarmInfo) {
    List<Widget> _returnWidget = new List<Widget>();

    _returnWidget.add(Container(
      child: FlatButton(
        child: Text('저장'),
        onPressed: () {
          _alarmInfo.beforeHour = int.parse(
              (_displayHourController.text.length == 0) ? '0' : _displayHourController.text);
          _alarmInfo.beforeMinute = int.parse((_displayMinController.text.length == 0) ? '0' : _displayMinController.text);
          Navigator.pop(context, _alarmInfo);
        },
      ),
    ));

    return _returnWidget;
  }

  Widget _buildLeading() {
    return Container(
      child: FlatButton(
        child: Icon(Icons.arrow_back_rounded),
        onPressed: () {
          Navigator.pop(context, null);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _displayHourController =
        new TextEditingController(text: widget.alarmInfo.beforeHour.toString());
    TextEditingController _displayMinController = new TextEditingController(
        text: widget.alarmInfo.beforeMinute.toString());
    AlarmInfo _alarmInfo = widget.alarmInfo;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.alarmInfo.busNum.toString(),
        ),
        leading: _buildLeading(),
        actions: _buildActions(
            _displayHourController, _displayMinController, _alarmInfo),
      ),
      body:
          _buildPage(_displayHourController, _displayMinController, _alarmInfo),
    );
  }
}
