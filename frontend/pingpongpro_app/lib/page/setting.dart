import 'package:flutter/material.dart';
// import 'package:pingpongpro_app/models/sensor_recorder_model.dart';
// import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key key}) : super(key: key);
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _name = 'User';
  int _goal;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildGoal() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Goal'),
      validator: (value) {
        if (value.isEmpty) {
          return 'goal is Required';
        }

        return null;
      },
      onSaved: (value) {
        _name = value;
      },
    );
  }

  // void _deletedata() {
  //   Provider.of<SensorRecorderModel>(context, listen: false).deletedata();
  //   // Exit modal dialog
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Setting")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildName(),
                  _buildGoal(),
                  SizedBox(height: 100),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }

                      _formKey.currentState.save();

                      print(_name);
                      print(_goal);

                      //Send to API
                    },
                  )
                ],
              ),
            ),

            // children: <Widget>[
            //   Form(
            //     key: _formKey,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //         _buildName(),
            //         _buildGoal(),
            //         SizedBox(height: 100),
            //         // ignore: deprecated_member_use
            //         RaisedButton(
            //           child: Text(
            //             'Submit',
            //             style: TextStyle(color: Colors.blue, fontSize: 16),
            //           ),
            //           onPressed: () {
            //             if (!_formKey.currentState.validate()) {
            //               return;
            //             }

            //             _formKey.currentState.save();

            //             print(_name);
            //             print(_goal);

            //             //Send to API
            //           },
            //         )
            //       ],
            //     ),
            //   ),
            Padding(
              padding: EdgeInsets.only(top: 40),
            ),
            // IconButton(
            //   // onPressed: _deletedata,
            //   icon: const Icon(Icons.delete),
            // ),
            // Text('clear data'),
          ],
        ),
      ),
    );
  }
}
