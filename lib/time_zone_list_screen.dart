import 'package:flutter/material.dart';

import 'package:timezone/browser.dart';



class TimeZoneListScreen extends StatefulWidget {
  final Map timezones;

  TimeZoneListScreen({this.timezones});

  @override
  _TimeZoneListScreenState createState() => _TimeZoneListScreenState();
}

class _TimeZoneListScreenState extends State<TimeZoneListScreen> {
  List<Location> listOfTimezones = [];

  @override
  void initState() {
    getTimeZonesList();
    // TODO: implement initState
    super.initState();
  }

  void getTimeZonesList() {
    print(widget.timezones.values);
    print(listOfTimezones);
    print(widget.timezones);

    widget.timezones.forEach((key, value) {
      listOfTimezones.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(onTap: (){
            print('tapped');
          },
            child: ListTile(
                onTap: () {

                },
                title: Text(
                  '${listOfTimezones[index]}',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          );
        },
        itemCount: listOfTimezones.length,
        shrinkWrap: true,
      ),
    );
  }
}
