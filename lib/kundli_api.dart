import 'dart:convert';

import 'package:http/http.dart' as http;

class KundliApi {
  Future<String> getToken() async {
    final String clientID = '6cdc00cf-66ab-47da-8eec-1954ec1c099a';
    final String clientSecret = '7oZ20oY4ays6KISeZNRFvnctAu0km2NbpEbcFdIC';

    final String tokenUrl = 'https://api.prokerala.com/token';
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$clientID:$clientSecret'))}';

    final Map<String, String> body = {
      'grant_type': 'client_credentials',
    };

    final Map<String, String> headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final response =
        await http.post(Uri.parse(tokenUrl), body: body, headers: headers);

    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> data = json.decode(response.body);
      final String accessToken = data['access_token'];
      print(accessToken);
      return accessToken;
    } else {
      print(response.statusCode);

      Map<String, dynamic> data = response.body as Map<String, dynamic>;
      // return data;
    }
    return response.body;
  }

  Future<Map<String, dynamic>> getKundli({lat, lon, datetime, time}) async {
    final String accessToken = await getToken();

    final String url = "https://api.prokerala.com/v2/astrology/kundli/advanced";
    final String token = "Bearer $accessToken";
    var headers = {
      'Authorization': 'Bearer $accessToken',
      'content-type': 'application/json',
    };

    String kundliUrl =
        "https://api.prokerala.com/v2/astrology/kundli/advanced?ayanamsa=1&coordinates=$lat,$lon&datetime=${datetime}T$time:00.485Z";

    // var payload = {
    //   'datetime': '2004-02-12T15:19:21+05:30',
    //   'ayanamsa': 1,
    //   'coordinates': '10.214747,78.097626'
    // };

    final response = await http.get(
      Uri.parse(kundliUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      // print(response.body);
      final Map<String, dynamic> data = json.decode(response.body);
      // final String acessData = data['data'];
      print('this is api: $data');

      return data;
    } else {
      print('error: ${response.statusCode}');
      // print(response.body);
      Map<String, dynamic> data = response.body as Map<String, dynamic>;
      return data;
    }
  }
}
