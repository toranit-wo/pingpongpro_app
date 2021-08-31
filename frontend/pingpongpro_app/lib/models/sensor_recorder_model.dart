// import 'dart:convert';
// import 'dart:io';
// import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';
import 'dart:async';

// import 'package:path_provider/path_provider.dart';
import 'package:pingpongpro_app/models/data_model.dart';
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

  List<DataAllhits> _toDataAllhits = [];

  List<DataAllhits> get dataallhits {
    return [..._toDataAllhits];
  }

  Timer _timer;

  List<double> xacc = [];
  List<double> newxa = [];
  List<double> newzg = [];
  List<double> yacc = [];
  List<double> zacc = [];

  List<double> xgyr = [];
  List<double> ygyr = [];
  List<double> zgyr = [];

  List<double> maxhit = [];
  List<double> minhit = [];
  List<double> center = [];
  List<double> cleardatag = [];

  double sd = 0;
  double sa = 0;
  int allhit = 0;

  // SensorRecorderModel() {
  //   this.fetchDataAllhits();
  // }

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
    // safeRecordedData(filename);
    prosessData(filename);
    _isRecording = false;
    _activityType = '';
    _timer.cancel();
    notifyListeners();
  }

  void prosessData(String filename) {
    final title = filename;
    var reaccele = _recordedDataAccele;
    var regyro = _recordedDataGyro;
    for (var item in reaccele) {
      xacc.add(item[0]);
      yacc.add(item[1]);
      zacc.add(item[2]);
    }
    for (var item in regyro) {
      xgyr.add(item[0]);
      ygyr.add(item[1]);
      zgyr.add(item[2]);
    }
    for (var item in xacc) {
      if (sd != item) {
        newxa.add(item);
        sd = item;
      }
    }
    for (var item in zgyr) {
      if (sa != item) {
        newzg.add(item);
        sa = item;
      }
    }
    var prakxa = findPeaks(Array(newxa));

    var prakzg = findPeaks(Array(newzg));

    var hits = prakzg[1];
    for (var fdata in hits) {
      if (fdata >= 2.0) {
        cleardatag.add(fdata);
      }
    }
    allhit = cleardatag.length;
    for (var data in prakxa[1]) {
      if (data < -6.3) {
        maxhit.add(data);
      } else if (data > -4.9) {
        minhit.add(data);
      } else {
        center.add(data);
      }
    }
    // print(maxhit);
    // print(minhit);
    // print(center);
    // var maxh = (maxhit.length / hits[0].length) * 100;
    // var minh = (minhit.length / hits[0].length) * 100;
    // var cenh = (center.length / hits[0].length) * 100;
    // print(title);
    // print(maxh);
    // print(minh);
    // print(cenh);

    xacc = [];
    newxa = [];
    newzg = [];
    yacc = [];
    zacc = [];

    xgyr = [];
    ygyr = [];
    zgyr = [];

    maxhit = [];
    minhit = [];
    center = [];

    sd = 0;
    sa = 0;
  }

  // void safeRecordedData(String filename) async {
  //   final DateTime now = DateTime.now();
  //   final date = now.toString().split(' ')[0];
  //   final time = now.toString().split(' ')[1].split('.')[0];
  //   final directory = await getExternalStorageDirectory();
  //   final fileCSV = File('${directory.path}/${filename}_$date--$time');
  //   String csv = const ListToCsvConverter().convert(_CsvWritedData);
  //   await fileCSV.writeAsString(csv);
  //   print('Saved data as csv file $filename in ${directory.path}');
  //   int id = 0;
  //   if (filename == 'Forehand') {
  //     id = 1;
  //   } else {
  //     id = 2;
  //   }
  //   Map data = {
  //     'accelerometer': _recordedDataAccele,
  //     'useraccelerometer': _recordedDatauserAccele,
  //     'gyroscope': _recordedDataGyro,
  //     'timer': _recordedDataTimer
  //   };
  //   final body = jsonEncode(data);
  //   final response = await http.put(
  //       Uri.parse('http://toranit.pythonanywhere.com/apis/$id/'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, dynamic>{'title': filename, 'data': body}));

  //   _recordedDataAccele = [];
  //   _recordedDatauserAccele = [];
  //   _recordedDataGyro = [];
  //   _recordedDataTimer = [];
  //   _CsvWritedData = [];
  //   final dir = await getExternalStorageDirectory();
  //   print(dir.listSync(recursive: true, followLinks: false));
  //   print("${response.statusCode}");
  //   print("${response.body}");
  // }

  // fetchDataAllhits() async {
  //   final url = 'http://toranit.pythonanywhere.com/DataAllhits/?format=json';
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body) as List;
  //     _toDataAllhits =
  //         data.map<DataAllhits>((json) => DataAllhits.fromJson(json)).toList();
  //     notifyListeners();
  //   }
  // }

  // void deletedata() {}

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
