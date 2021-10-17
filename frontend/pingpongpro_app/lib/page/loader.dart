import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pingpongpro_app/models/data_model.dart';
import 'package:pingpongpro_app/page/dashboard.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  void setupdata() async {
    Data instance = Data(title: 'title');
    await instance.toJson();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Dashboard()));
  }

  @override
  void initState() {
    super.initState();
    setupdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitSpinningCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
