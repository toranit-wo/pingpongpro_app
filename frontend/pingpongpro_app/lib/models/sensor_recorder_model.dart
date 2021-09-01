import 'package:flutter/material.dart';
import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';
import 'dart:async';
import 'package:pingpongpro_app/models/data_model.dart';

class SensorRecorderModel extends ChangeNotifier {
  bool _isRecording = false;
  String _activityType = '';
  List<double> _accelerometerValues;
  List<double> _userAccelerometerValues;
  List<double> _gyroscopeValues;

  List<List<double>> _recordedDataAccele = [];
  List<List<double>> _recordedDatauserAccele = [];
  List<List<double>> _recordedDataGyro = [];
  List<List<double>> _recordedDataTimer = [];

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

  void startRecording(String activityType) {
    _isRecording = true;
    _activityType = activityType;
    _timer =
        Timer.periodic(Duration(milliseconds: 1), (Timer t) => saveToHistory());
    notifyListeners();
  }

  void saveToHistory() {
    _recordedDataAccele.add(_accelerometerValues);
    _recordedDatauserAccele.add(_userAccelerometerValues);
    _recordedDataGyro.add(_gyroscopeValues);
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
    List xacc = [];
    List zgyr = [];
    List newxa = [];
    List newzg = [];
    double sd = 0;
    double sa = 0;

    // ignore: unused_local_variable
    final title = filename;
    print(_recordedDataAccele.length);
    print(_recordedDataGyro.length);
    for (var item in _recordedDataAccele) {
      xacc.add(item[0]);
      print("------------");
      print(xacc.length);
      for (var item in _recordedDataGyro) {
        zgyr.add(item[2]);
      }
      print(zgyr.length);
      print("------------");
      for (var item in xacc) {
        if (sd != item) {
          newxa.add(item);
          sd = item;
        }
      }
      print("------------");
      print(newxa.length);
      for (var item in zgyr) {
        if (item != sa) {
          newzg.add(item);
          sa = item;
        }
      }
      print(newzg);
      print("------------");
      var prakxa = findPeaks(Array(newxa));
      print(prakxa[1]);
      var prakzg = findPeaks(Array(newzg));
      print(prakzg[1]);

      // var hits = prakzg[1];
      // for (var fdata in hits) {
      //   if (fdata >= 2.0) {
      //     cleardatag.add(fdata);
      //   }
      // }
      // allhit = cleardatag.length;
      // print(allhit);
      // for (var data in prakxa[1]) {
      //   if (data < -6.3) {
      //     maxhit.add(data);
      //   } else if (data > -4.9) {
      //     minhit.add(data);
      //   } else {
      //     center.add(data);
      //   }
      // }
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
