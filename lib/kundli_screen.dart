import 'package:flutter/material.dart';
import 'package:jyotisha_app/kundli_api.dart';

class KundliScreen extends StatefulWidget {
  final Map data;
  const KundliScreen({super.key, required this.data});

  @override
  State<KundliScreen> createState() => _KundliScreenState();
}

class _KundliScreenState extends State<KundliScreen> {
  Map<String, dynamic> mapdata = {};
  List<Map<String, dynamic>> listData = [];
  @override
  Widget build(BuildContext context) {
    String datetime =
        '${widget.data['year']}-${widget.data['month']}-${widget.data['day']}';
    String time = '${widget.data['hour']}:${widget.data['minute']}';
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder<Map<String, dynamic>>(
              future: KundliApi().getKundli(
                  datetime: datetime,
                  lat: widget.data['latitude'],
                  lon: widget.data['longitude'],
                  time: time),
              builder: (context, snapshot) {
                print('data: ${snapshot.data}');
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // Display a loading indicator
                } else {

                  // mapdata = snapshot.data as Map<>
                  // setState(() {
                  //   // listData =
                  //       // snapshot.data as List<Map<String, dynamic>>;
                    mapdata = snapshot.data as Map<String, dynamic>;
                  // });
                  // print('this is listdata: $listData');.
                  // print('this is mapdata: $mapdata');
                  print('this is mapdata: $mapdata');
                  return Column(
                    children: [

                Text('Nakshatra Details: ', style: TextStyle(fontSize: 20),),
                Text('nakshatra: ',style: TextStyle(fontSize: 18,color: Colors.blue),),
                // Text('nakshatra: ${mapdata['data']['nakshatra_details']['nakshatra']}'),
                Text('name: ${mapdata['data']['nakshatra_details']['nakshatra']['name']}'),
                Text('Lord: ',style: TextStyle(fontSize: 16,color: Colors.green)),
                Text('name: ${mapdata['data']['nakshatra_details']['nakshatra']['lord']['name']}',),
                Text('vedic_name: ${mapdata['data']['nakshatra_details']['nakshatra']['lord']['vedic_name']}'),
                // Divider(thickness: 2,),
                SizedBox(height: 10,),
                Text('chandra_rasi: ',style: TextStyle(fontSize: 18,color: Colors.blue)),
                // Text('chandra_rasi: ${mapdata['data']['nakshatra_details']['chandra_rasi']}'),
                Text('name: ${mapdata['data']['nakshatra_details']['chandra_rasi']['name']}'),
                Text('Lord: ',style: TextStyle(fontSize: 16,color: Colors.green)),
                Text('name: ${mapdata['data']['nakshatra_details']['chandra_rasi']['lord']['name']}'),
                Text('name: ${mapdata['data']['nakshatra_details']['chandra_rasi']['lord']['vedic_name']}'),
                // Divider(thickness: 2,),

                SizedBox(height: 10,),
                Text('soorya_rasi: ',style: TextStyle(fontSize: 18,color: Colors.blue)),
                // Text('soorya_rasi: ${mapdata['data']['nakshatra_details']['soorya_rasi']}'),
                Text('name: ${mapdata['data']['nakshatra_details']['soorya_rasi']['name']}'),
                Text('Lord: '),
                Text('name: ${mapdata['data']['nakshatra_details']['soorya_rasi']['lord']['name']}'),
                Text('name: ${mapdata['data']['nakshatra_details']['soorya_rasi']['lord']['vedic_name']}'),
                // Divider(thickness: 2,),

                SizedBox(height: 10,),
                Text('zodiac: ',style: TextStyle(fontSize: 18,color: Colors.blue)),
                Text('name: ${mapdata['data']['nakshatra_details']['zodiac']['name']}'),
                Divider(thickness: 2,),

               SizedBox(height: 10,),
                Text('Additional info: ',style: TextStyle(fontSize: 20),),
                // Text('additional_info: ${mapdata['data']['nakshatra_details']['additional_info']}'),
                Text('deity: ${mapdata['data']['nakshatra_details']['additional_info']['deity']}'),
                Text('ganam: ${mapdata['data']['nakshatra_details']['additional_info']['ganam']}'),
                Text('symbol: ${mapdata['data']['nakshatra_details']['additional_info']['symbol']}'),
                Text('animal_sign: ${mapdata['data']['nakshatra_details']['additional_info']['animal_sign']}'),
                Text('nadi: ${mapdata['data']['nakshatra_details']['additional_info']['nadi']}'),
                Text('color: ${mapdata['data']['nakshatra_details']['additional_info']['color']}'),
                Text('best_direction: ${mapdata['data']['nakshatra_details']['additional_info']['best_direction']}'),
                Text('syllables: ${mapdata['data']['nakshatra_details']['additional_info']['syllables']}'),
                Text('birth_stone: ${mapdata['data']['nakshatra_details']['additional_info']['birth_stone']}'),
                Text('planet: ${mapdata['data']['nakshatra_details']['additional_info']['planet']}'),
                 Text('enemy_yoni: ${mapdata['data']['nakshatra_details']['additional_info']['enemy_yoni']}'),
                Divider(thickness: 2,),

SizedBox(height: 20,),
                // Text('mangal_dosha: ${mapdata['data']['mangal_dosha']}'),
                Text('Mangal Dosha',style: TextStyle(fontSize: 20,),),
                Text('dosha: ${mapdata['data']['mangal_dosha']['has_dosha']}'),
                Text('description: ${mapdata['data']['mangal_dosha']['description']}'),
                SizedBox(height: 20,),
                Text('exception: ${mapdata['data']['mangal_dosha']['has_exception']}'),
                Text('type: ${mapdata['data']['mangal_dosha']['type']}'),
                Text('exceptions: ${mapdata['data']['mangal_dosha']['exceptions']}'),
                SizedBox(height: 20,),
                
                Text('remedies: ${mapdata['data']['mangal_dosha']['remedies']}'),
                    ],
                  );
                }
              })),
    );
  }
}
