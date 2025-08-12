import 'character.dart';

class CharacterResponse {
  final int count;
  final int pages;
  final String? next;
  final String? prev;
  final List<Character> results;

  const CharacterResponse({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
    required this.results,
  });

  factory CharacterResponse.fromJson(Map<String, dynamic> json) {
    final info = json['info'] ?? {};
    final results = (json['results'] as List? ?? [])
        .map((item) => Character.fromJson(item))
        .toList();

    return CharacterResponse(
      count: info['count'] ?? 0,
      pages: info['pages'] ?? 0,
      next: info['next'],
      prev: info['prev'],
      results: results,
    );
  }
}
