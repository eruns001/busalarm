
import 'package:alarm_test/AlarmInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'AlarmSettingPageTest.dart';
import 'main.dart';



class StationListPage extends StatefulWidget {
  const StationListPage({
    Key key
  }):super (key: key);

  @override
  _StationListState createState()  => _StationListState();
}

class _StationListState extends State<StationListPage> {
  String bustemp = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                  bustemp = newValue;
                  //stationmap[dropdownValue].STATION_ID;
                });
              },
              items: SIstringList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            IconButton(
              color: Colors.black,
              icon: Icon(
                CupertinoIcons.check_mark,
                color:  const Color(0xff46abdb),
                size: 50,
              ),
              onPressed: () async {
                AlarmInfo temp = await AlarmInfo(
                  busNum: bustemp,
                  arrival: DateTime.now().add(Duration(minutes: 2, seconds: 30)),
                  useHour: true,
                  useMinute: true,
                  beforeHour: 0,
                  beforeMinute: 0,
                  enable: false,
                  alarmAtNext: false,
                );
                addAlarmInfoList(temp);
                Navigator.pop(context, null);
              },
            ),
          ],
        ),
      ),
    );
  }
}

/*
Future<Album> fetchAlbum() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/albums/1');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}*/