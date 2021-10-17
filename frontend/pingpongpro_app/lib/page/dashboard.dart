import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pingpongpro_app/models/sensor_recorder_model.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<SensorRecorderModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        backgroundColor: Colors.white10,
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {},
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Container(
                  width: 50,
                  child: Icon(
                    Icons.notifications,
                    // ignore: deprecated_member_use
                    color: Theme.of(context).accentColor,
                    size: 35,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  width: 20,
                  height: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.red,
                    ),
                    width: 20,
                    height: 20,
                    child: Center(
                      child: Text(
                        '03',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 30, 25, 25),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.lightGreen,
                  ),
                  child: Image.asset(
                    'assets/img/table-tennis.png',
                    width: 60,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Text(
                  "${data.hits}",
                  style: TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 80,
                    fontFamily: 'Bebas',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                      ),
                      Text(
                        'Steps Taken'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.lightGreen,
                          fontFamily: 'Bebas',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 25,
                  color: Colors.grey[300],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total hits Today',
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 24,
                        fontFamily: 'Bebas',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 250,
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      StatCard(
                        title: 'Fore Hand',
                        achieved: data.forehandhits.toDouble(),
                        total: data.forehandhits.toDouble(),
                        color: Colors.red,
                        image: Image.asset('assets/img/fhand.png', width: 20),
                      ),
                      StatCard(
                        title: 'Back Hand',
                        achieved: data.backhandhits.toDouble(),
                        total: data.backhandhits.toDouble(),
                        color: Colors.blue,
                        image: Image.asset('assets/img/bhand.png', width: 20),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 25,
                  color: Colors.grey[300],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'result',
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 24,
                        fontFamily: 'Bebas',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 250,
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      StatCard2(
                        title: 'Fore Hand',
                        achieved1: data.foregood.last.toDouble(),
                        achieved2: data.foreover.last.toDouble(),
                        achieved3: data.foreunder.last.toDouble(),
                        total: 100,
                        color: Colors.orange,
                        image: Image.asset('assets/img/fhand.png', width: 20),
                      ),
                      StatCard2(
                        title: 'Back Hand',
                        achieved1: data.backgood.last.toDouble(),
                        achieved2: data.backover.last.toDouble(),
                        achieved3: data.backunder.last.toDouble(),
                        total: 100,
                        color: Theme.of(context).primaryColor,
                        image: Image.asset('assets/img/bhand.png', width: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final double total;
  final double achieved;
  final Image image;
  final Color color;

  const StatCard({
    Key key,
    @required this.title,
    @required this.total,
    @required this.achieved,
    @required this.image,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[200],
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  // ignore: deprecated_member_use
                  color: Theme.of(context).accentColor.withAlpha(100),
                  fontSize: 14,
                ),
              ),
              achieved < total
                  ? Image.asset(
                      'assets/img/down_orange.png',
                      width: 20,
                    )
                  : Image.asset(
                      'assets/img/up_red.png',
                      width: 20,
                    ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
          ),
          CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 8.0,
            percent: achieved / (total < achieved ? achieved : total),
            circularStrokeCap: CircularStrokeCap.round,
            center: image,
            progressColor: color,
            // ignore: deprecated_member_use
            backgroundColor: Theme.of(context).accentColor.withAlpha(30),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: achieved.toString(),
                style: TextStyle(
                  fontSize: 20,
                  // ignore: deprecated_member_use
                  color: Theme.of(context).accentColor,
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class StatCard2 extends StatelessWidget {
  final String title;
  final double total;
  final double achieved1;
  final double achieved2;
  final double achieved3;
  final Image image;
  final Color color;

  const StatCard2({
    Key key,
    @required this.title,
    @required this.total,
    @required this.achieved1,
    @required this.achieved2,
    @required this.achieved3,
    @required this.image,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[200],
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  // ignore: deprecated_member_use
                  color: Theme.of(context).accentColor.withAlpha(100),
                  fontSize: 14,
                ),
              ),
              achieved1 < total
                  ? Image.asset(
                      'assets/img/down_orange.png',
                      width: 20,
                    )
                  : Image.asset(
                      'assets/img/up_red.png',
                      width: 20,
                    ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: '$achieved1 %',
                      style: TextStyle(
                        fontSize: 16,
                        // ignore: deprecated_member_use
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    TextSpan(
                      text: ' / $total %',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ]),
                ),
                LinearPercentIndicator(
                  width: 100.0,
                  lineHeight: 8.0,
                  percent: achieved1 / (total < achieved1 ? achieved1 : total),
                  progressColor: Colors.lightGreenAccent[400],
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: '$achieved2 %',
                      style: TextStyle(
                        fontSize: 16,
                        // ignore: deprecated_member_use
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    TextSpan(
                      text: ' / $total %',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ]),
                ),
                LinearPercentIndicator(
                  width: 100.0,
                  lineHeight: 8.0,
                  percent: achieved2 / (total < achieved2 ? achieved2 : total),
                  progressColor: Colors.yellowAccent[400],
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: '$achieved3 %',
                      style: TextStyle(
                        fontSize: 16,
                        // ignore: deprecated_member_use
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    TextSpan(
                      text: ' / $total %',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ]),
                ),
                LinearPercentIndicator(
                  width: 100.0,
                  lineHeight: 8.0,
                  percent: achieved3 / (total < achieved3 ? achieved3 : total),
                  progressColor: Colors.orangeAccent[400],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
