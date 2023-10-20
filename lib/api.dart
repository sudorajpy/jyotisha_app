import 'dart:convert';
import 'package:http/http.dart' as http;

class APIs {
  final completePanchangUrl =
      Uri.parse("https://json.freeastrologyapi.com/complete-panchang");
  final nakshatraUrl = Uri.parse(
      "https://json.astrologyapi.com/v1/find_nakshatra/:nakshatraName"); // Replace with your API endpoint

  final planetUrl = Uri.parse(
      "https://json.freeastrologyapi.com/planets"); // Replace with your API endpoint
  final headers = {
    'Content-Type': 'application/json',
    'x-api-key':
        'T2i63rap5Yao90JIWxmUy87ObTv9zS6m6GqG0aNg', // Replace with your API key
  };

  Future<Map<String, dynamic>> fetchPanchangData(
      {year, month, day, hour, minute, lat, lon}) async {
    final payload = {
      "year": year,
      "month": month,
      "date": day,
      "hours": hour,
      "minutes": minute,
      "seconds": "0",
      "latitude": lat,
      "longitude": lon,
      "timezone": 5.5,
      "config": {"observation_point": "topocentric", "ayanamsha": "lahiri"}
    };
    final completePanchangResponse = await http.post(completePanchangUrl,
        headers: headers, body: jsonEncode(payload));
    if (completePanchangResponse.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(completePanchangResponse.body);
      String output = data['output']; // Access the 'output' field
      Map<String, dynamic> completePanchangRespons = json.decode(output);
      return completePanchangRespons;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> fetchNakshtraData(
      {year, month, day, hour, minute,lat, lon}) async {
    final payload = {
      "year": year,
      "month": month,
      "date": day,
      "hours": hour,
      "minutes": minute,
      "seconds": "0",
      "latitude": lat,
      "longitude": lon,
      "timezone": 5.5,
      "config": {"observation_point": "topocentric", "ayanamsha": "lahiri"}
    };
    final nakshtraResponse = await http.post(nakshatraUrl,
        headers: headers, body: jsonEncode(payload));
    if (nakshtraResponse.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(nakshtraResponse.body);
      // String output = data['output']; // Access the 'output' field
      // Map<String, dynamic> response = json.decode(output);
      return data;
    } else {
      throw Exception('Failed to load data ${nakshtraResponse.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchPlanetData(
      {year, month, day, hour, minute, lat, lon}) async {
    {
      final payload = {
        "year": year,
        "month": month,
        "date": day,
        "hours": hour,
        "minutes": minute,
        "seconds": "0",
        "latitude": lat,
        "longitude": lon,
        "timezone": 5.5,
        "config": {"observation_point": "topocentric", "ayanamsha": "lahiri"}
      };
      final planetResponse = await http.post(planetUrl,
          headers: headers, body: jsonEncode(payload));
      if (planetResponse.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(planetResponse.body);
        // String output = data['output']; // Access the 'output' field
        // Map<String, dynamic> response = json.decode(output) as Map<String, dynamic>;
        return data;
      } else {
        throw Exception('Failed to load data ${planetResponse.statusCode}');
      }
    }
  }

  Future<Map<String, dynamic>> fetchData(
      {year, month, day, hour, minute, second, lat, lon}) async {
    var url = Uri.parse(
        'https://vedicrishi-horoscope-and-astrology-v1.p.rapidapi.com/advanced_panchang/');
    var headers = {
      'content-type': 'application/json',
      'X-RapidAPI-Key': '902eeecb1amshacf0216712bb1a8p1b883cjsn3dfdac1768ed',
      'X-RapidAPI-Host': 'vedicrishi-horoscope-and-astrology-v1.p.rapidapi.com'
    };
    var body = jsonEncode({
      "day": "25",
      "month": "12",
      "year": "1988",
      "hour": "10",
      "min": "12",
      "lat": "25.123",
      "lon": "82.34",
      "tzone": "5.5"
    });

    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);

        return data;
      } else {
        print("Request failed with status: ${response.statusCode}.");
        return {'error': 'error'};
      }
    } catch (error) {
      print("Error: $error");
      return {'error': 'error'};
    }
  }
}
