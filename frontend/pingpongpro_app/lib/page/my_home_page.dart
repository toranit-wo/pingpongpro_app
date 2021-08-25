import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:pingpongpro_app/page/my_bottom_bar.dart';
import 'package:pingpongpro_app/models/sensor_recorder_model.dart';

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
      // appBar: AppBar(
      //   leading: Icon(Icons.android),
      //   title: const Text('PingPong Pro'),
      //   backgroundColor: Colors.white,
      // ),
      body: Container(
        child: Column(children: <Widget>[]),
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
          .setAccelerometerValues(<double>[event.x, event.y, event.z]);
    }));
    _streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      Provider.of<SensorRecorderModel>(context, listen: false)
          .setUserAccelerometerValues(<double>[event.x, event.y, event.z]);
    }));
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      Provider.of<SensorRecorderModel>(context, listen: false)
          .setGyroscopeValues(<double>[event.x, event.y, event.z]);
    }));
  }
}
