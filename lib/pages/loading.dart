import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async {
    WorldTime obj = WorldTime(
        location: "Istanbul", flag: "germany.png", url: "Europe/Istanbul");
    await obj.getTime();
    Navigator.pushReplacementNamed(context, "/home", arguments: {
      'location': obj.location,
      'flag': obj.flag,
      'time': obj.time,
      "isDayTime": obj.isDayTime,
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: Center(
        child: SpinKitRotatingCircle(
          size: 50.0,
          color: Colors.blue,
        ),
      ),
    );
  }
}
