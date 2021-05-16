import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:pingpongpro_app/page/my_bottom_bar.dart';
import 'package:pingpongpro_app/models/sensor_recorder_model.dart';

///import 'package:pingpongpro_ui/page/data_presentation.dart';
import 'package:pingpongpro_app/page/speedometer_container.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: Icon(Icons.android), title: const Text('PingPong Pro')),
      body: Container(
        child: Column(children: <Widget>[
          SpeedometerContainer(),
        ]),
      ),
      bottomNavigationBar: MyBottomBar(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose of sensor stream subscription
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();

    // Listeners for sensor changes
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      Provider.of<SensorRecorderModel>(context, listen: false)
          .setXaccele(event.x);
    }));
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      Provider.of<SensorRecorderModel>(context, listen: false)
          .setYaccele(event.y);
    }));
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      Provider.of<SensorRecorderModel>(context, listen: false)
          .setZaccele(event.z);
    }));

    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      Provider.of<SensorRecorderModel>(context, listen: false)
          .setXgyro(event.x);
    }));
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      Provider.of<SensorRecorderModel>(context, listen: false)
          .setYgyro(event.y);
    }));
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      Provider.of<SensorRecorderModel>(context, listen: false)
          .setZgyro(event.z);
    }));
  }
}
