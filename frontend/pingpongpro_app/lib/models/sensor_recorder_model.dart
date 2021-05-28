import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class SensorRecorderModel extends ChangeNotifier {
  // Whether the app is in recording mode
  bool _isRecording = false;
  // The type of the current activity. None-type if not recording.
  String _activityType = '';
  // The current sensor data
  List<double> _accelerometerValues;
  List<double> _userAccelerometerValues;
  List<double> _gyroscopeValues;

  // Recorded sensor data history
  List<List<List<dynamic>>> _recordedData = [];

  bool get isRecording => _isRecording;
  String get activityType => _activityType;
  List<double> get accelerometerValues => _accelerometerValues;
  List<double> get userAccelerometerValues => _userAccelerometerValues;
  List<double> get gyroscopeValues => _gyroscopeValues;

  Timer _timer;

  void startRecording(String activityType) {
    _isRecording = true;
    _activityType = activityType;
    _timer =
        Timer.periodic(Duration(milliseconds: 1), (Timer t) => saveToHistory());
    notifyListeners();
  }

  void saveToHistory() {
    final DateTime now = DateTime.now();
    final time = [now.toString().split(' ')[1]];
    _recordedData.add([
      _accelerometerValues,
      _userAccelerometerValues,
      _gyroscopeValues,
      time
    ]);
    print(_recordedData);
    print(time);
    // print('\n');
  }

  void stopRecording() {
    // Parse filename with activityType and timestemp
    // final DateTime now = DateTime.now();
    //final time = now.toString().split(' ')[1].split('.')[0];
    final filename = _activityType;
    safeRecordedData(filename);
    _isRecording = false;
    _activityType = '';
    _timer.cancel();
    notifyListeners();
  }

  void safeRecordedData(String filename) async {
    final file = '$filename';
    final data = '$_recordedData';
    final response = await http.post(
      Uri.parse('http://toranit.pythonanywhere.com/apis/v1/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'title': file, 'data': data}),
    );

    // Format sensor data as string
    // Reset cached recorded data list
    _recordedData = [];
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(data);
      throw Exception('Failed to create album.');
    }
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
