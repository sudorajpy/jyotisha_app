import 'package:flutter/material.dart';
import 'package:jyotisha_app/kundli_api.dart';
import 'package:jyotisha_app/kundli_screen.dart';
import 'package:jyotisha_app/panchang_screen.dart';

class TabScreen extends StatefulWidget {
  final Map data;
  const TabScreen({super.key, required this.data});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  DateTime dateTime = DateTime.now();

  int dayIndex = 1;
  int tabIndex = 0;
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jyotisha App"),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      dateTime = DateTime.now();

                      dateTime = dateTime.subtract(Duration(days: 1));
                      year = dateTime.year;
                      month = dateTime.month;
                      day = dateTime.day;
                      dayIndex = 0;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.3,
                    height: 50,
                    color: dayIndex == 0
                        ? Color.fromARGB(255, 177, 207, 8)
                        : Color.fromARGB(255, 219, 225, 100),
                    child: Center(
                      child: Text("Yesterday"),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      dateTime = DateTime.now();

                      dayIndex = 1;
                      year = dateTime.year;
                      month = dateTime.month;
                      day = dateTime.day;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.3,
                    height: 50,
                    color: dayIndex == 1
                        ? Color.fromARGB(255, 177, 207, 8)
                        : Color.fromARGB(255, 219, 225, 100),
                    child: Center(
                      child: Text("Today"),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    KundliApi().getToken();
                    setState(() {
                      dateTime = DateTime.now();
                      dateTime = dateTime.add(Duration(days: 1));
                      year = dateTime.year;
                      month = dateTime.month;
                      day = dateTime.day;

                      dayIndex = 2;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.3,
                    height: 50,
                    color: dayIndex == 2
                        ? Color.fromARGB(255, 177, 207, 8)
                        : Color.fromARGB(255, 219, 225, 100),
                    child: Center(
                      child: Text("Tommorow"),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      tabIndex = 0;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: tabIndex == 0
                            ? BorderSide(
                                color: Colors.black,
                                width: 2,
                              )
                            : BorderSide.none,
                      ),
                    ),
                    // color: Colors.green,
                    child: Center(
                      child: Text(
                        "Panchang",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      tabIndex = 1;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 50,
                    decoration: BoxDecoration(
                      border: tabIndex == 1
                          ? Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text("Kundali", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.31,
              // color: Color.fromARGB(255, 113, 152, 84),
              child: tabIndex == 0
                  ? AstrologyScreen(
                      year: year,
                      month: month,
                      day: day,
                      hours: dateTime.hour,
                      minutes: dateTime.minute,
                      seconds: dateTime.second,
                      latitude: widget.data["latitude"],
                      longitude: widget.data["longitude"],
                    )
                  : KundliScreen(
                    data: widget.data,
                  ),
            )
          ])),
    );
  }
}
