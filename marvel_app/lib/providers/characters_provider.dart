import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/marvel_api_service.dart';
import '../constants/app_constants.dart';

class CharactersProvider with ChangeNotifier {
  final MarvelApiService _apiService = MarvelApiService();
  
  // Variables de estado
  List<Character> _characters = [];
  List<Character> _searchResults = [];
  bool _isLoading = false;
  bool _isSearching = false;
  String _error = '';
  int _currentOffset = 0;
  bool _hasMore = true;

  // Getters para acceder al estado desde las pantallas
  List<Character> get characters => _characters;
  List<Character> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  String get error => _error;
  bool get hasMore => _hasMore;

  // Cargar personajes (con paginación)
  Future<void> loadCharacters({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _characters.clear();
      _currentOffset = 0;
      _hasMore = true;
    }

    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final newCharacters = await _apiService.getCharacters(
        offset: _currentOffset,
      );

      if (newCharacters.isEmpty) {
        _hasMore = false;
      } else {
        _characters.addAll(newCharacters);
        _currentOffset += newCharacters.length;
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Buscar personajes
  Future<void> searchCharacters(String query) async {
    if (query.isEmpty) {
      _searchResults.clear();
      notifyListeners();
      return;
    }

    _isSearching = true;
    _error = '';
    notifyListeners();

    try {
      _searchResults = await _apiService.searchCharacters(query);
    } catch (e) {
      _error = e.toString();
    }

    _isSearching = false;
    notifyListeners();
  }

  // Limpiar resultados de búsqueda
  void clearSearch() {
    _searchResults.clear();
    notifyListeners();
  }
}
