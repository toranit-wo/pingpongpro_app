import 'package:flutter/material.dart';

class PastRecordingsPage extends StatefulWidget {
  @override
  _PastRecordingsPageState createState() => _PastRecordingsPageState();
}

class _PastRecordingsPageState extends State<PastRecordingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Past Recordings'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/img/topspin.png'),
            Text('******'),
            Image.asset('assets/img/topspin.png'),
            Text('******'),
            Image.asset('assets/img/topspin.png'),
            Text('******'),
            Image.asset('assets/img/topspin.png'),
            Text('******'),
            Image.asset('assets/img/topspin.png'),
            Text('******'),
          ],
        ));
  }
}
