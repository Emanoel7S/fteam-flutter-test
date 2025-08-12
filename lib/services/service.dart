import 'dart:convert';
import 'package:flutter_api_app/models/character_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://rickandmortyapi.com/api';

  static Future<CharacterResponse> fetchCharacters({int page = 1}) async {
    final url = Uri.parse('$_baseUrl/character?page=$page');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return CharacterResponse.fromJson(data);
      } else {
        throw Exception(
          'ero ao carregar personagens (status ${response.statusCode})',
        );
      }
    } catch (e) {
      throw Exception('flha na conexão: $e');
    }
  }
}
