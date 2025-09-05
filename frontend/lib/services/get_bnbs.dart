import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bnb.dart';

class FetchBnbs {
  static const String apiUrl = String.fromEnvironment('API_URL');

  static Future<List<Bnb>> fetchBnbs() async {
    final url = Uri.parse('$apiUrl/bnbs');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Bnb.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Bnbs');
    }
  }
}
