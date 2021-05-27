// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:pingpongpro_app/models/sensor_recorder_model.dart';
// import 'package:http/http.dart' as http;

// class ApiProvider with ChangeNotifier {
//   ApiProvider() {
//     this.fetchTasks();
//   }
//   List<SensorRecorderModel> _recordedData = [];
//   List<SensorRecorderModel> get recordedData {
//     return [..._recordedData];
//   }

//   void add (SensorRecorderModel recordedData)async{
//     final response = await http.post('***url***', headers: {"Content-Type": "application/json"},body: json.encode(recordedData));
//     if (response.statusCode == 201) {
//       recordedData.id = json.decode(response.body)['id'];
//       _recordedData.add(recordedData);
//       notifyListeners();
//     }
//   }
//   fetchTasks() async {
//     final url = 'http://10.0.2.2:8000/apis/v1/?format=json';
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       var data = json.decode(response.body) as List;
//       _recordedData = data.map<SensorRecorderModel>((json) => SensorRecorderModel.fromJson(json)).toList();
//       notifyListeners();
//     }
//   }
// }
