import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
import 'dart:async';

class SensorRecorderModel extends ChangeNotifier {
  // Whether the app is in recording mode
  bool _isRecording = false;
  // The type of the current activity. None-type if not recording.
  String activityTypes = '';
  // The current sensor data
  List<double> _accelerometerValues;
  List<double> _userAccelerometerValues;
  List<double> _gyroscopeValues;
  int id;
  List<dynamic> recordedData = [];

  bool get isRecording => _isRecording;
  String get activityType => activityTypes;
  List<double> get accelerometerValues => _accelerometerValues;
  List<double> get userAccelerometerValues => _userAccelerometerValues;
  List<double> get gyroscopeValues => _gyroscopeValues;

  Timer _timer;

  void startRecording(String activityType) {
    _isRecording = true;
    activityTypes = activityType;
    _timer =
        Timer.periodic(Duration(milliseconds: 1), (Timer t) => saveToHistory());
    notifyListeners();
  }

  void saveToHistory() {
    final DateTime now = DateTime.now();
    final time = [now.toString().split(' ')[1]];
    recordedData.add([
      _accelerometerValues,
      _userAccelerometerValues,
      _gyroscopeValues,
      time
    ]);
    print(recordedData);
    print(time);
    print('\n');
  }

  void stopRecording() {
    // Parse filename with activityType and timestemp
    //final time = now.toString().split(' ')[1].split('.')[0];
    safeRecordedData();
    _isRecording = false;
    activityTypes = '';
    _timer.cancel();
    notifyListeners();
  }

  SensorRecorderModel({this.id, this.activityTypes, this.recordedData});
  factory SensorRecorderModel.fromJson(Map<String, dynamic> json) {
    return SensorRecorderModel(id: json['title'], recordedData: json['data']);
  }
  dynamic toJson() => {'id': id, 'title': activityTypes, 'data': recordedData};

  void safeRecordedData() async {
    SensorRecorderModel sensorRecorderModel;
    final response = await http.post(Uri.parse('http://10.0.2.2:8000/apis/v1/'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(sensorRecorderModel));
    if (response.statusCode == 201) {
      sensorRecorderModel.id = json.decode(response.body)['id'];
    }
    print('send data');
    recordedData = [];
  }

  void setAccelerometerValues(List values) {
    _accelerometerValues = values;
    notifyListeners();
  }

  void setUserAccelerometerValues(List values) {
    _userAccelerometerValues = values;
    notifyListeners();
  }

  void setGyroscopeValues(List values) {
    _gyroscopeValues = values;
    notifyListeners();
  }
}
