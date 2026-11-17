import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://www.freetogame.com/api';

  static Future<List<dynamic>> fetchGames() async {
    final response = await http.get(Uri.parse('$baseUrl/games'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal memuat data game');
    }
  }

  static Future<Map<String, dynamic>> fetchGameDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/game?id=$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal memuat detail game');
    }
  }
}
