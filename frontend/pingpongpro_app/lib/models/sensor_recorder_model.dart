import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:io';

class SensorRecorderModel extends ChangeNotifier {
  // Whether the app is in recording mode
  bool _isRecording = false;
  // The type of the current activity. None-type if not recording.
  String _activityType = '';
  // The current sensor data

  double _xaccele;
  double _yaccele;
  double _zaccele;
  double _xgyro;
  double _ygyro;
  double _zgyro;

  // Recorded sensor data history
  List<List<dynamic>> _recordedData = [];

  bool get isRecording => _isRecording;
  String get activityType => _activityType;

  double get xaccele => _xaccele;
  double get yaccele => _yaccele;
  double get zaccele => _zaccele;
  double get xgyro => _xgyro;
  double get ygyro => _xgyro;
  double get zgyro => _xgyro;

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
    final time = now.toString().split(' ')[1];
    _recordedData
        .add([_xaccele, _yaccele, _zaccele, _xgyro, _ygyro, _zgyro, time]);
    print(_recordedData);
    print(time);
    print('\n');
  }

  void stopRecording() {
    // Parse filename with activityType and timestemp
    final DateTime now = DateTime.now();
    final date = now.toString().split(' ')[0];
    //final time = now.toString().split(' ')[1].split('.')[0];
    final filename = '${_activityType}_$date.csv';
    safeRecordedData(filename);
    _isRecording = false;
    _activityType = '';
    _timer.cancel();
    notifyListeners();
  }

  void safeRecordedData(String filename) async {
    final directory = await getExternalStorageDirectory();
    final file = File('${directory.path}/$filename');
    // Format sensor data as string
    String csv = const ListToCsvConverter().convert(_recordedData);
    await file.writeAsString(csv);
    print('Saved data as csv file $filename in ${directory.path}');
    // Reset cached recorded data list
    _recordedData = [];
    final dir = await getExternalStorageDirectory();
    print(dir.listSync(recursive: true, followLinks: false));
  }

  void setXaccele(double values) {
    _xaccele = values;
    notifyListeners();
  }

  void setYaccele(double values) {
    _yaccele = values;
    notifyListeners();
  }

  void setZaccele(double values) {
    _zaccele = values;
    notifyListeners();
  }

  void setXgyro(double values) {
    _xgyro = values;
    notifyListeners();
  }

  void setYgyro(double values) {
    _ygyro = values;
    notifyListeners();
  }

  void setZgyro(double values) {
    _zgyro = values;
    notifyListeners();
  }
}
