import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  dynamic get(Uri uri, {Map<dynamic, dynamic>? params}) async {
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*"
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic post(Uri uri, {Map<dynamic, dynamic>? params}) async {
    final response = await http.post(
      uri,
      body: jsonEncode(params),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw Exception();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
