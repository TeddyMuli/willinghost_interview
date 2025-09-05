import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateBnb {
  static const String apiUrl = 'http://10.0.2.2:8000/api';

  static Future<http.Response> createBnb(Map<String, dynamic> bnbData) async {
    final url = Uri.parse('$apiUrl/bnbs');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bnbData),
    );
    return response;
  }
}
