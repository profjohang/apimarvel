import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import '../models/character.dart';
import '../constants/app_constants.dart';

class MarvelApiService {
  // Generar hash MD5 requerido por la API de Marvel
  String _generateHash(String timestamp) {
    final input = '$timestamp${AppConstants.privateKey}${AppConstants.publicKey}';
    final bytes = utf8.encode(input);
    final digest = md5.convert(bytes);
    return digest.toString();
  }

  // Obtener parámetros de autenticación
  Map<String, String> _getAuthParams() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = _generateHash(timestamp);
    
    return {
      'ts': timestamp,
      'apikey': AppConstants.publicKey,
      'hash': hash,
    };
  }

  // Obtener lista de personajes
  Future<List<Character>> getCharacters({int offset = 0}) async {
    try {
      final authParams = _getAuthParams();
      final queryParams = {
        ...authParams,
        'offset': offset.toString(),
        'limit': AppConstants.itemsPerPage.toString(),
      };

      final uri = Uri.parse('${AppConstants.baseUrl}${AppConstants.charactersEndpoint}')
          .replace(queryParameters: queryParams);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['data']['results'] as List;
        
        return results.map((json) => Character.fromJson(json)).toList();
      } else {
        throw Exception('Error HTTP: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Buscar personajes por nombre
  Future<List<Character>> searchCharacters(String query) async {
    try {
      final authParams = _getAuthParams();
      final queryParams = {
        ...authParams,
        'nameStartsWith': query,
        'limit': '20',
      };

      final uri = Uri.parse('${AppConstants.baseUrl}${AppConstants.charactersEndpoint}')
          .replace(queryParameters: queryParams);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['data']['results'] as List;
        
        return results.map((json) => Character.fromJson(json)).toList();
      } else {
        throw Exception('Error en búsqueda: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
