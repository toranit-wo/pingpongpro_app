import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pingpongpro_app/models/sensor_recorder_model.dart';

class DataPresentation extends StatefulWidget {
  @override
  _DataPresentationState createState() => _DataPresentationState();
}

class _DataPresentationState extends State<DataPresentation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
          child: Text('test Sensor Data',
              style: TextStyle(fontSize: 20, color: Colors.black87)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Consumer<SensorRecorderModel>(
                builder: (context, sensors, child) {
                  final List<String> accelerometer = sensors.accelerometerValues
                      ?.map((double v) => v.toStringAsFixed(1))
                      ?.toList();
                  return Text('Accelerometer: $accelerometer');
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Consumer<SensorRecorderModel>(
                builder: (context, sensors, child) {
                  final List<String> userAccelerometer = sensors
                      .userAccelerometerValues
                      ?.map((double v) => v.toStringAsFixed(1))
                      ?.toList();
                  return Text('UserAccelerometer: $userAccelerometer');
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Consumer<SensorRecorderModel>(
                builder: (context, sensors, child) {
                  final List<String> gyroscope = sensors.gyroscopeValues
                      ?.map((double v) => v.toStringAsFixed(1))
                      ?.toList();
                  return Text('Gyroscope: $gyroscope');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
