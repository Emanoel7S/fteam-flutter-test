import 'package:flutter/foundation.dart';
import '../models/character.dart';
import '../services/service.dart';

class CharacterViewModel extends ChangeNotifier {
  List<Character> _characters = [];
  int _currentPage = 1;
  int _totalPages = 1;
  bool _isLoading = false;
  String? _errorMessage;

  List<Character> get characters => _characters;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCharacters({int page = 1}) async {
    if (_isLoading) return;
    if (page > _totalPages) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.fetchCharacters(page: page);

      if (page == 1) {
        _characters = response.results;
      } else {
        _characters.addAll(response.results);
      }

      _currentPage = page;
      _totalPages = response.pages;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'erro ao carregar personagens: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchNextPage() async {
    if (_currentPage < _totalPages) {
      await fetchCharacters(page: _currentPage + 1);
    }
  }
  Future<void> fetchPreviousPage() async {
    if (_currentPage > 1 ) {
      await fetchCharacters(page: _currentPage - 1);
    }
  }

  void refreshList() {
    _characters.clear();
    _currentPage = 1;
    _totalPages = 1;
    fetchCharacters(page: 1);
  }
}
