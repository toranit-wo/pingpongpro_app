import 'package:pingpongpro_app/page/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pingpongpro_app/models/sensor_recorder_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SensorRecorderModel(),
      child: MaterialApp(
        title: 'Pingpong Pro',
        theme: ThemeData(
            primarySwatch: Colors.indigo, primaryColor: Colors.indigo[500]),
        home: Welcome(),
      ),
    );
  }
}

///      MaterialApp(
///      title: 'Fitness App',
///      theme: ThemeData(
///        primarySwatch: Colors.blue,
///        primaryColor: Color(0XFF6D3FFF),
///        accentColor: Color(0XFF233C63),
///        fontFamily: 'Poppins',
///      ),
///      home: Welcome(),
///    );
///  }
///}
