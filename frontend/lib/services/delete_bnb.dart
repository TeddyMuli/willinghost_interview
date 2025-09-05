import 'package:http/http.dart' as http;

class DeleteBnb {
  static const String apiUrl = 'http://10.0.2.2:8000/api';
  static Future<bool> deleteBnb(int id) async {
    final url = Uri.parse('$apiUrl/bnbs/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
