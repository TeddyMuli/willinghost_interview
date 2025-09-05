import 'dart:convert';
import 'package:http/http.dart' as http;

class UpdateBnb {
  static const String apiUrl = 'http://10.0.2.2:8000/api';

  static Future<http.Response> updateBnb(
    int id,
    Map<String, dynamic> bnbData,
  ) async {
    final url = Uri.parse('$apiUrl/bnbs/$id');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bnbData),
    );
    return response;
  }
}
