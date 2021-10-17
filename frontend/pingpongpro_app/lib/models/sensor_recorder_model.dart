import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:pingpongpro_app/models/data_model.dart';

class SensorRecorderModel extends ChangeNotifier {
  SensorRecorderModel() {
    this.fetchTasks();
  }

  bool _isRecording = false;
  String _activityType = '';
  List<dynamic> _accelerometerValues;
  List<dynamic> _userAccelerometerValues;
  List<dynamic> _gyroscopeValues;

  List<dynamic> _recordedDataAccele = [];
  List<dynamic> _recordedDatauserAccele = [];
  List<dynamic> _recordedDataGyro = [];

  bool get isRecording => _isRecording;
  String get activityType => _activityType;
  List<dynamic> get accelerometerValues => _accelerometerValues;
  List<dynamic> get userAccelerometerValues => _userAccelerometerValues;
  List<dynamic> get gyroscopeValues => _gyroscopeValues;

  Timer _timer;

  int hits = 0;
  dynamic over = 0;
  dynamic under = 0;
  dynamic good = 0;

  List<int> forehand = [];
  List<double> foreover = [];
  List<double> foreunder = [];
  List<double> foregood = [];
  List<int> backhand = [];
  List<double> backover = [];
  List<double> backunder = [];
  List<double> backgood = [];
  int forehandhits = 0;
  int backhandhits = 0;

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
    var filename = _activityType;
    // safeRecordedData(filename);
    if (filename == 'Forehand') {
      forehandData(filename);
    } else {
      backhandData(filename);
    }
    _isRecording = false;
    _activityType = '';
    _timer.cancel();
    notifyListeners();
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  void forehandData(String filename) {
    final title = filename;
    List xacc = [];
    List zgyr = [];
    List<double> newxa = [];
    List<double> newzg = [];
    List hitc = [];
    List maxhit = [];
    List minhit = [];
    List center = [];
    double sd = 0;
    double sa = 0;

    // print("---Count hit ---");
    // print(_recordedDataGyro.length);
    for (var item in _recordedDataGyro) {
      zgyr.add(item[2]);
    }
    // print(zgyr.length);
    for (var item in zgyr) {
      if (item != sa) {
        newzg.add(roundDouble(item, 5));
        sa = item;
      }
    }
    // print(newzg);
    for (var item in (findPeaks(Array(newzg)))[1]) {
      if (item >= 2.7) {
        hitc.add(item);
      }
    }
    hits = hitc.length;

    // print("---good hit---");
    // print(_recordedDataAccele.length);
    for (var item in _recordedDatauserAccele) {
      xacc.add(item[0]);
    }
    // print(xacc.length);
    for (var item in xacc) {
      if (sd != item) {
        newxa.add(roundDouble(item, 5));
        sd = item;
      }
    }
    // print(newxa);
    // print(((findPeaks(Array(newxa)))[1]).length);
    for (var item in (findPeaks(Array(newxa)))[1]) {
      if (item < -6.3) {
        maxhit.add(item);
      } else if (item > -4.9) {
        minhit.add(item);
      } else {
        center.add(item);
      }
    }
    over = (maxhit.length / ((findPeaks(Array(newxa)))[1]).length) * 100;
    over = roundDouble(over, 3);
    under = (minhit.length / ((findPeaks(Array(newxa)))[1]).length) * 100;
    under = roundDouble(under, 3);
    good = (center.length / ((findPeaks(Array(newxa)))[1]).length) * 100;
    good = roundDouble(good, 3);

    // print("---End---");
    // Data(title: title, hits: hits, over: over, under: under, good: good);
    addact(title);
  }

  void backhandData(String filename) {
    var title = filename;
    List xacc = [];
    List xgyr = [];
    List<double> newxa = [];
    List<double> newzg = [];
    List hitc = [];
    List maxhit = [];
    List minhit = [];
    List center = [];
    double sd = 0;
    double sa = 0;

    // print("---Count hit ---");
    // print(_recordedDataGyro.length);
    for (var item in _recordedDataGyro) {
      xgyr.add(item[0]);
    }
    // print(zgyr.length);
    for (var item in xgyr) {
      if (item != sa) {
        newzg.add(roundDouble(item, 5));
        sa = item;
      }
    }
    // print(newzg);
    for (var item in (findPeaks(Array(newzg)))[1]) {
      if (item >= 1.25) {
        hitc.add(item);
      }
    }
    hits = hitc.length;

    // print("---good hit---");
    // print(_recordedDataAccele.length);
    for (var item in _recordedDatauserAccele) {
      xacc.add(item[0]);
    }
    // print(xacc.length);
    for (var item in xacc) {
      if (sd != item) {
        newxa.add(roundDouble(item, 5));
        sd = item;
      }
    }
    // print(newxa);
    // print(((findPeaks(Array(newxa)))[1]).length);
    for (var item in (findPeaks(Array(newxa)))[1]) {
      if (item < 6.3) {
        maxhit.add(item);
      } else if (item > 4.9) {
        minhit.add(item);
      } else {
        center.add(item);
      }
    }
    over = (maxhit.length / ((findPeaks(Array(newxa)))[1]).length) * 100;
    over = roundDouble(over, 3);
    under = (minhit.length / ((findPeaks(Array(newxa)))[1]).length) * 100;
    under = roundDouble(under, 3);
    good = (center.length / ((findPeaks(Array(newxa)))[1]).length) * 100;
    good = roundDouble(good, 3);

    // print("---End---");
    // Data(title: title, hits: hits, over: over, under: under, good: good);
    addact(title);
  }

  List<Data> _datas = [];
  List<Data> get datas {
    return [..._datas];
  }

  // ignore: missing_return
  void addact(String filename) async {
    var title = filename;
    final response = await http.post(
        Uri.parse('http://toranit.pythonanywhere.com/pingpong/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          'title': title,
          'hits': hits,
          'over': over,
          'under': under,
          'good': good
        }));
    print("${response.statusCode}");
    print("${response.body}");
  }

  void deleteTodo(Data data) async {
    final response = await http
        .delete(Uri.parse('http://10.0.2.2:8000/apis/v1/${data.id}/'));
    if (response.statusCode == 204) {
      _datas.remove(data);
      notifyListeners();
    }
  }

  fetchTasks() async {
    final url = 'http://toranit.pythonanywhere.com/pingpong/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _datas = data.map<Data>((json) => Data.fromJson(json)).toList();
      for (var item in _datas) {
        if (item.title == 'Forehand') {
          forehand.add(item.hits);
          foreover.add(roundDouble(item.over, 1));
          foreunder.add(roundDouble(item.under, 1));
          foregood.add(roundDouble(item.good, 1));
        } else {
          backhand.add(item.hits);
          backover.add(roundDouble(item.over, 1));
          backunder.add(roundDouble(item.under, 1));
          backgood.add(roundDouble(item.good, 1));
        }
      }
      forehand.forEach((e) => forehandhits += e);
      backhand.forEach((e) => backhandhits += e);
      notifyListeners();
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
