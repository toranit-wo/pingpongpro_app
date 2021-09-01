import 'package:flutter/material.dart';
import 'package:pingpongpro_app/page/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:pingpongpro_app/models/sensor_recorder_model.dart';

class MyBottomBar extends StatefulWidget {
  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  List<String> _activityOptions = ['Forehand', 'Backhand'];
  List<DropdownMenuItem<String>> _activityDropdownMenuItems = [];

  @override
  void initState() {
    for (String option in _activityOptions) {
      _activityDropdownMenuItems.add(DropdownMenuItem(
          value: option,
          child: Text(option, style: TextStyle(fontSize: 16.0))));
    }
    super.initState();
  }

  void _confirmRecordingStart() async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          String _selectedActivity = _activityDropdownMenuItems[0].value;
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return FractionallySizedBox(
              heightFactor: 0.66,
              child: Container(
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16.0),
                    topRight: const Radius.circular(16.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Start new recording?',
                        style: TextStyle(fontSize: 22)),
                    Text(
                      'To start a new activity recording, please select '
                      'an activity from below.',
                      style: TextStyle(fontSize: 16),
                    ),
                    DropdownButton(
                      value: _selectedActivity,
                      items: _activityDropdownMenuItems,
                      onChanged: (String selectedActivity) {
                        setState(() => _selectedActivity = selectedActivity);
                      },
                      isExpanded: true,
                      isDense: false,
                      itemHeight: 56.0,
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(18.0),
                      splashColor: Colors.grey,
                      onPressed: () => _startRecording(_selectedActivity),
                      child: Text('Start Recording',
                          style: TextStyle(fontSize: 20.0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  void _startRecording(String selectedActivity) {
    // Activate recordingState of RecorderModel and set activity type
    Provider.of<SensorRecorderModel>(context, listen: false)
        .startRecording(selectedActivity);
    // Exit modal dialog
    Navigator.pop(context);
  }

  void _stopRecording() {
    Provider.of<SensorRecorderModel>(context, listen: false).stopRecording();
    // Exit modal dialog
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Dashboard()),
    );
  }

  Widget isNotRecordingBar() {
    return Material(
      color: Colors.white,
      child: Center(
        child: Ink(
          decoration: const ShapeDecoration(
            color: Colors.lightBlue,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: const Icon(Icons.android),
            color: Colors.white,
            onPressed: _confirmRecordingStart,
          ),
        ),
      ),
    );
  }

  Widget isRecordingBar() {
    return Material(
      color: Colors.white,
      child: Center(
        child: Ink(
          decoration: const ShapeDecoration(
            color: Colors.red,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: const Icon(Icons.android),
            color: Colors.white,
            onPressed: _stopRecording,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SensorRecorderModel>(
      builder: (context, recorder, child) {
        // If recording, return different UI
        if (recorder.isRecording == false) {
          return isNotRecordingBar();
        } else {
          return isRecordingBar();
        }
      },
    );
  }
}
