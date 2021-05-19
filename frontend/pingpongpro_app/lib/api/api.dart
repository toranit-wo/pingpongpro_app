import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pingpongpro_app/models/sensor_recorder_model.dart';
import 'package:http/http.dart' as http;

class SensordataProvider with ChangeNotifier {
  List<SensorRecorderModel> _sensorrecord = [];

  List<SensorRecorderModel> get sensors {
    return [..._sensorrecord];
  }

  fetchTask() async{
    final url = 'http://127.0.0.1:8000/sensors/?format=json',
    final response = await http.get(url);
  }
}
