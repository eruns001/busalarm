import 'package:flutter/foundation.dart';

class StationInfo{
  String STATION_NM_INFO;
  String STATION_ID;
  String STATION_MANAGE_NO;

  StationInfo({
    @required this.STATION_ID,
    @required this.STATION_MANAGE_NO,
    @required this.STATION_NM_INFO
  });

  factory StationInfo.fromJson(Map<String, dynamic> json){
    return StationInfo(
        STATION_ID: json['STATION_ID'],
        STATION_MANAGE_NO: json['STATION_MANAGE_NO'],
        STATION_NM_INFO: json['STATION_NM_INFO']
    );
  }
}