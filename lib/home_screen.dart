import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jyotisha_app/kundli_screen.dart';
import 'package:jyotisha_app/panchang_screen.dart';
import 'package:jyotisha_app/tab_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var nameController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var placeController = TextEditingController();

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  DateTime selectedDate = DateTime.now();
  int year = 0, month = 0, day = 0;
  int hour = 0, minute = 0;

  DateTime dateTime = DateTime.now();
  DateTime selectedTime = DateTime.now();

  @override
  void initState() {
    checkGps();
    super.initState();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(dateTime.timeZoneName);
    print(dateTime.timeZoneOffset);
    print(dateTime.timeZoneOffset.inHours.toDouble());
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Jyotisha App'),
      ),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                // keyboardType: TextInputType.none,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: 'Enter your name',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: dateController,
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  ).then((value) {
                    if (value != null) {
                     

                      // Now you have year, month, and day in separate variables
                      print('Year: $year, Month: $month, Day: $day');

                      setState(() {
                         year = value.year;
                      month = value.month;
                      day = value.day;
                        dateController.text = value.toString().substring(0, 10);
                      });
                    }
                  });
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(),
                  labelText: 'Enter your birth date',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: timeController,
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    if (value != null) {
                      // int year = selectedDate.year;
                      // int month = selectedDate.month;
                      // int day = selectedDate.day;

                      // Now you have year, month, and day in separate variables
                      // print('Year: $year, Month: $month, Day: $day');

                      setState(() {
                        hour = value.hour;
                        minute = value.minute;
                        timeController.text =
                            value.toString().substring(10, 15);
                        selectedTime = DateTime.now().add(
                            Duration(hours: value.hour, minutes: value.minute));
                            
                      });
                    }
                  });

                  // _selectTime(context);
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.access_time),
                  border: OutlineInputBorder(),
                  labelText: 'Enter your birth time',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: placeController,
                onTap: () {},
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.place),
                  border: OutlineInputBorder(),
                  labelText: 'Enter your birth place',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Longitude: $long',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Latitude: $lat',
                style: TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        dateController.text.isNotEmpty &&
                        timeController.text.isNotEmpty &&
                        placeController.text.isNotEmpty) {
                      Map<String, dynamic> data = {
                        'name': nameController.text,
                        'date': selectedDate,
                        'year': year,
                        'month': month,
                        'day': day,
                        'hour': hour,
                        'minute': minute,
                        'seconds': 0,
                        'time': selectedTime,
                        'place': placeController.text,
                        'longitude': long,
                        'latitude': lat,
                        'timezone': dateTime.timeZoneOffset.inHours.toDouble(),
                        "tz": 5.5,
                        "config": {"observation_point": "topocentric", "ayanamsha": "lahiri"}
                      };
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TabScreen(
                            data: data,
                          )));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill all the fields'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: Text('Submit'))
            ],
          )),
    );
  }
}


                      // Map<String, dynamic> tz = {
                      //   'tZone': dateTime.timeZoneOffset.inHours.toDouble(),
                      //   'place': placeController.text,
                      //   'long': long,
                      //   'lat': lat,
                      //   'year': year,
                      //   'month': month,
                      //   'day': day,
                      //   'hour': selectedTime.hour,
                      //   'minute': selectedTime.minute,
                      // };
                      // final payload = {
                      //   "year": 2022,
                      //   "month": 8,
                      //   "date": 11,
                      //   "hours": 6,
                      //   "minutes": 0,
                      //   "seconds": 0,
                      //   "latitude": 17.38333,
                      //   "longitude": 78.4666,
                      //   "timezone": 5.5,
                      //   "config": {
                      //     "observation_point": "topocentric",
                      //     "ayanamsha": "lahiri"
                      //   }
                      // };