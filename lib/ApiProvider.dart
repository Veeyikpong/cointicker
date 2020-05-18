import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProvider {
  final String baseUrl = "https://rest.coinapi.io/v1/";

  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(baseUrl + url);
      print(response.body.toString());
      print(response.toString());
      return jsonDecode(response.body.toString());
    } catch (e) {
      throw e;
    }
  }
}
