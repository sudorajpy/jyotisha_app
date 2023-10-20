import 'package:flutter/material.dart';
import 'package:jyotisha_app/api.dart';
import 'package:jyotisha_app/const.dart';
// import 'astrology_api.dart';

class AstrologyScreen extends StatefulWidget {
  final int year, month, day, hours, minutes, seconds;
  final String latitude, longitude;
  const AstrologyScreen(
      {Key? key,
      required this.year,
      required this.month,
      required this.day,
      required this.hours,
      required this.minutes,
      required this.seconds, required this.latitude, required this.longitude})
      : super(key: key);
  @override
  State<AstrologyScreen> createState() => _AstrologyScreenState();
}

class _AstrologyScreenState extends State<AstrologyScreen> {
   
  @override
  void initState() {
    // fetchAstrologyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     final payload = {
    "year": widget.year,
    "month": widget.month,
    "date": widget.day,
    "hours": widget.hours,
    "minutes": widget.minutes,
    "seconds": widget.seconds,
    "latitude": widget.latitude,
    "longitude": widget.longitude,
    "timezone": 5.5,
    "config": {"observation_point": "topocentric", "ayanamsha": "lahiri"}
  };
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<Map<String, dynamic>>(
                future: APIs().fetchPanchangData(
                  day: widget.day,
                  hour: widget.hours,
                  minute: widget.minutes,
                  month: widget.month,
                  // second: widget.seconds,
                  year: widget.year,
                  lat: widget.latitude,
                  lon: widget.longitude,
                  
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Display a loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Once data is fetched, you can display it using Text widgets or other widgets.
                    // print('${snapshot.data}');
                    final astrologyData = snapshot.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sunrise:',
                                  style: TextStyle(color: subH),
                                ),
                                Text(
                                  ' ${astrologyData!["sun_rise"]}',
                                  style: TextStyle(fontSize: txtSize),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Text(
                                  'Sunset:',
                                  style: TextStyle(color: subH),
                                ),
                                Text(
                                  ' ${astrologyData["sun_set"]}',
                                  style: TextStyle(fontSize: txtSize),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'weekday:',
                                  style: TextStyle(color: subH),
                                ),
                                Text(
                                  ' ${astrologyData["weekday"]["vedic_weekday_name"]}',
                                  style: TextStyle(fontSize: txtSize),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Text(
                                  'lunar_month:',
                                  style: TextStyle(color: subH),
                                ),
                                Text(
                                  ' ${astrologyData["lunar_month"]["lunar_month_name"]}',
                                  style: TextStyle(fontSize: txtSize),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'ritu:',
                                  style: TextStyle(color: subH),
                                ),
                                Text(
                                  ' ${astrologyData["ritu"]["name"]}',
                                  style: TextStyle(fontSize: txtSize),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Text(
                                  'aayanam:',
                                  style: TextStyle(color: subH),
                                ),
                                Text(
                                  ' ${astrologyData["aayanam"]}',
                                  style: TextStyle(fontSize: txtSize),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'tithi:',
                                  style: TextStyle(color: subH),
                                ),
                                Text(
                                  ' ${astrologyData["tithi"]["name"]}',
                                  style: TextStyle(fontSize: txtSize),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Text(
                                  'nakshatra:',
                                  style: TextStyle(color: subH),
                                ),
                                Text(
                                  ' ${astrologyData["nakshatra"]["name"]}',
                                  style: TextStyle(fontSize: txtSize),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'yoga 1:',
                                  style: TextStyle(color: subH),
                                ),
                                Text(
                                  ' ${astrologyData["yoga"]['1']["name"]}',
                                  style: TextStyle(fontSize: txtSize),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Text(
                                  'yoga:',
                                  style: TextStyle(color: subH),
                                ),
                                Text(
                                  ' ${astrologyData["yoga"]['2']["name"]}',
                                  style: TextStyle(fontSize: txtSize),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'karana 1:',
                                  style: TextStyle(color: subH),
                                ),
                                Text(
                                  ' ${astrologyData["karana"]['1']["name"]}',
                                  style: TextStyle(fontSize: txtSize),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Text(
                                  'karana 2:',
                                  style: TextStyle(color: subH),
                                ),
                                Text(
                                  ' ${astrologyData["karana"]['2']["name"]}',
                                  style: TextStyle(fontSize: txtSize),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    );
                  }
                },
              ),
              Divider(
                thickness: 4,
              ),
              FutureBuilder<Map<String, dynamic>>(
                  future: APIs().fetchPlanetData(
                    day: widget.day,
                  hour: widget.hours,
                  minute: widget.minutes,
                  month: widget.month,
                  // second: widget.seconds,
                  year: widget.year,
                  lat: widget.latitude,
                  lon: widget.longitude,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Display a loading indicator
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Once data is fetched, you can display it using Text widgets or other widgets.
                      // print('${snapshot.data}');
                      print('this is data ${snapshot.data!['output'][0]['12']}');
                      // final astrologyData = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('name: ${snapshot.data!['output'][0]['1']['name']}'),
                          Text('fullDegree: ${snapshot.data!['output'][0]['1']['fullDegree']}'),
                          Text('normDegree: ${snapshot.data!['output'][0]['1']['normDegree']}'),
                          SizedBox(height: 10,),
                          Text('name: ${snapshot.data!['output'][0]['2']['name']}'),
                          Text('fullDegree: ${snapshot.data!['output'][0]['2']['fullDegree']}'),
                          Text('normDegree: ${snapshot.data!['output'][0]['2']['normDegree']}'),
                          SizedBox(height: 10,),

                          Text('name: ${snapshot.data!['output'][0]['3']['name']}'),
                          Text('fullDegree: ${snapshot.data!['output'][0]['3']['fullDegree']}'),
                          Text('normDegree: ${snapshot.data!['output'][0]['3']['normDegree']}'),
                          SizedBox(height: 10,),

                          Text('name: ${snapshot.data!['output'][0]['4']['name']}'),
                          Text('fullDegree: ${snapshot.data!['output'][0]['4']['fullDegree']}'),
                          Text('normDegree: ${snapshot.data!['output'][0]['4']['normDegree']}'),
                          SizedBox(height: 10,),

                          Text('name: ${snapshot.data!['output'][0]['5']['name']}'),
                          Text('fullDegree: ${snapshot.data!['output'][0]['5']['fullDegree']}'),
                          Text('normDegree: ${snapshot.data!['output'][0]['5']['normDegree']}'),
                          SizedBox(height: 10,),

                          Text('name: ${snapshot.data!['output'][0]['6']['name']}'),
                          Text('fullDegree: ${snapshot.data!['output'][0]['6']['fullDegree']}'),
                          Text('normDegree: ${snapshot.data!['output'][0]['6']['normDegree']}'),
                          SizedBox(height: 10,),

                          Text('name: ${snapshot.data!['output'][0]['7']['name']}'),
                          Text('fullDegree: ${snapshot.data!['output'][0]['7']['fullDegree']}'),
                          Text('normDegree: ${snapshot.data!['output'][0]['7']['normDegree']}'),
                          SizedBox(height: 10,),

                          Text('name: ${snapshot.data!['output'][0]['8']['name']}'),
                          Text('fullDegree: ${snapshot.data!['output'][0]['8']['fullDegree']}'),
                          Text('normDegree: ${snapshot.data!['output'][0]['8']['normDegree']}'),
                          SizedBox(height: 10,),

                          Text('name: ${snapshot.data!['output'][0]['9']['name']}'),
                          Text('fullDegree: ${snapshot.data!['output'][0]['9']['fullDegree']}'),
                          Text('normDegree: ${snapshot.data!['output'][0]['9']['normDegree']}'),
                          SizedBox(height: 10,),

                         Text('name: ${snapshot.data!['output'][0]['10']['name']}'),
                          Text('fullDegree: ${snapshot.data!['output'][0]['10']['fullDegree']}'),
                          Text('normDegree: ${snapshot.data!['output'][0]['10']['normDegree']}'),
                          SizedBox(height: 10,),

                           Text('name: ${snapshot.data!['output'][0]['11']['name']}'),
                          Text('fullDegree: ${snapshot.data!['output'][0]['11']['fullDegree']}'),
                          Text('normDegree: ${snapshot.data!['output'][0]['11']['normDegree']}'),
                          SizedBox(height: 10,),

                           Text('name: ${snapshot.data!['output'][0]['12']['name']}'),
                          Text('fullDegree: ${snapshot.data!['output'][0]['12']['fullDegree']}'),
                          Text('normDegree: ${snapshot.data!['output'][0]['12']['normDegree']}'),
                          SizedBox(height: 10,),

                           Text('name: ${snapshot.data!['output'][0]['13']['name']}'),
                          Text('fullDegree: ${snapshot.data!['output'][0]['13']['fullDegree']}'),
                          Text('normDegree: ${snapshot.data!['output'][0]['13']['normDegree']}'),
                          Divider(
                            thickness: 4,
                          ),

                        ],
                      );
                    }
                  }),
              // Text('Planet Data'),
              // Text(
              //     '${widget.year} ${widget.month} ${widget.day} ${widget.hours} ${widget.minutes} ${widget.seconds} '),
              // FutureBuilder<Map<String, dynamic>>(
              //     future: APIs().fetchData(),
              //     builder: (context, snapshot) {
              //       print(snapshot.data);
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return CircularProgressIndicator(); // Display a loading indicator
              //       } else if (snapshot.hasError) {
              //         return Text('Error: ${snapshot.error}');
              //       } else {
              //         return Text(snapshot.data.toString());
              //       }
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
