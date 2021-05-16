import 'package:flutter/material.dart';
import 'package:pingpongpro_app/models/sensor_recorder_model.dart';
import 'package:provider/provider.dart';

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
                  final double xaccelerometer = sensors.xaccele;
                  return Text('Accelerometer X: $xaccelerometer');
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
                  final double yaccelerometer = sensors.yaccele;
                  return Text('Accelerometer Y: $yaccelerometer');
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
                  final double zaccelerometer = sensors.zaccele;
                  return Text('Accelerometer Z: $zaccelerometer');
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
                  final double xgyro = sensors.xgyro;
                  return Text('Gyro X: $xgyro');
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
                  final double ygyro = sensors.ygyro;
                  return Text('Gyro Y: $ygyro');
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
                  final double zgyro = sensors.zgyro;
                  return Text('Gyro Z: $zgyro');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
