import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:path_provider/path_provider.dart';
//import 'package:pingpongpro_app/models/data_model.dart';

class SensorRecorderModel extends ChangeNotifier {
  bool _isRecording = false;
  String _activityType = '';
  List<double> _accelerometerValues;
  List<double> _userAccelerometerValues;
  List<double> _gyroscopeValues;

  List<dynamic> _recordedDataAccele = [];
  List<dynamic> _recordedDatauserAccele = [];
  List<dynamic> _recordedDataGyro = [];
  List<dynamic> _recordedDataTimer = [];
  // ignore: non_constant_identifier_names
  List<List<dynamic>> _CsvWritedData = [];

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
    final time = now.toString().split(' ')[1].split(':')[2];
    _recordedDataAccele.add(_accelerometerValues);
    _recordedDatauserAccele.add(_userAccelerometerValues);
    _recordedDataGyro.add(_gyroscopeValues);
    _recordedDataTimer.add(time);
    _CsvWritedData.add([
      _accelerometerValues,
      _userAccelerometerValues,
      _gyroscopeValues,
      time
    ]);
  }

  void stopRecording() {
    final filename = _activityType;
    safeRecordedData(filename);
    _isRecording = false;
    _activityType = '';
    _timer.cancel();
    notifyListeners();
  }

  void safeRecordedData(String filename) async {
    final DateTime now = DateTime.now();
    final date = now.toString().split(' ')[0];
    final time = now.toString().split(' ')[1].split('.')[0];
    final directory = await getExternalStorageDirectory();
    final fileCSV = File('${directory.path}/${filename}_$date--$time');
    String csv = const ListToCsvConverter().convert(_CsvWritedData);
    await fileCSV.writeAsString(csv);
    print('Saved data as csv file $filename in ${directory.path}');
    int id = 0;
    if (filename == 'Forehand') {
      id = 1;
    } else {
      id = 2;
    }
    // Map data = {
    //   'accelerometer': _recordedDataAccele,
    //   'useraccelerometer': _recordedDatauserAccele,
    //   'gyroscope': _recordedDataGyro,
    //   'timer': _recordedDataTimer
    // };
    // final body = jsonEncode(data);
    final response = await http.put(
        Uri.parse('http://toranit.pythonanywhere.com/apis/v1/$id/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': filename,
          'accelerometer': _recordedDataAccele,
          'useraccelerometer': _recordedDatauserAccele,
          'gyroscope': _recordedDataGyro
        }));

    _recordedDataAccele = [];
    _recordedDatauserAccele = [];
    _recordedDataGyro = [];
    _recordedDataTimer = [];
    _CsvWritedData = [];
    final dir = await getExternalStorageDirectory();
    print(dir.listSync(recursive: true, followLinks: false));
    print("${response.statusCode}");
    print("${response.body}");
  }

  // Future<Data> fetchData() async {
  //   final response = await http
  //       .get(Uri.parse('http://toranit.pythonanywhere.com/apis/v1/total/'));

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return Data.fromJson(jsonDecode(response.body));
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load data');
  //   }
  // }

  void deletedata() {}

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
