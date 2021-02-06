import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AlarmSettingPage.dart';
import 'AlarmSettingPageTest.dart';
import 'ClassStationInfo.dart';
import 'SecondPage.dart';
import 'package:http/http.dart' as http;

import 'AlarmInfo.dart';

import 'StationListPage.dart';
import 'dart:convert';




String dropdownValue = '검복리마운틴앞' ;
List<String> SIstringList = [];
var stationmap = Map<String, StationInfo>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Alarm Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  Future<String> getData() async {
    List<StationInfo> dump = [];
    List<String> SItemp = [];
    var maptemp = Map<String, StationInfo>();
    http.Response response = await http.get('https://openapi.gg.go.kr/BusStation?Type=json&pSize=10&KEY=1f28ac029b8a452889cbbcb715513122');
    List<dynamic> jsonlist = json.decode(response.body)['BusStation'][1]['row'];
    for(int a=0; a<jsonlist.length; a++){
      StationInfo temp = StationInfo.fromJson(jsonlist[a]);
      log("StationInfo: ${temp.STATION_NM_INFO}");
      dump.add(temp);
      SItemp.add(temp.STATION_NM_INFO);
      maptemp[temp.STATION_NM_INFO] = temp;
    }
    setState(() {
      stationmap = maptemp;
      SIstringList = SItemp;
      dropdownValue = SIstringList[0];
    });
    return response.body;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          SecondPage(),
          //AlarmSettingPage(),
          AlarmSettingPageTest(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: '',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          _currentIndex = index;
          setState(() {});
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await getData();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return StationListPage();
              },
            ),
          );
        }
      ),
    );
  }
}

