import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location = " "; //location name for the UI
  String time = " "; //the time in that location
  String flag = " "; //url to an asset flag icon
  String? url; //location url for api endpoint
  bool isDayTime = true;

  WorldTime({this.location = " ", this.flag = " ", this.url = " "});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data =
          jsonDecode(response.body); //decodes json string to an map object
      int timeToAdd; //to hold utc offset hour
      String datetime = data["datetime"],
          offset = data["utc_offset"], //offset from response
          sign = offset[0], //+ or - in offset
          timeDifference = offset.substring(1, 3); //hour in offset
      timeToAdd = int.parse(timeDifference); //parsing hour to int
      DateTime now = sign == "+" //using ternary operator to simpilfy code
          ? DateTime.parse(datetime).add(Duration(hours: timeToAdd))
          : DateTime.parse(datetime).subtract(Duration(hours: timeToAdd));

      //set the time property
      isDayTime = now.hour >= 7 && now.hour <= 20;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print("Caught error while getting time: $e");
      time = "Could not get time zone";
    }
  }
}
