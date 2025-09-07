class Character {
  final int id;
  final String name;
  final String description;
  final String thumbnail;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
  });

  // Método para convertir JSON de la API a objeto Character
  factory Character.fromJson(Map<String, dynamic> json) {
    final thumbnailData = json['thumbnail'];
    final thumbnailUrl = '${thumbnailData['path']}.${thumbnailData['extension']}';
    
    return Character(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Sin nombre',
      description: json['description'] ?? '',
      thumbnail: thumbnailUrl.replaceAll('http:', 'https:'),
    );
  }

  // Método para convertir objeto Character a JSON (por si se necesita)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'thumbnail': thumbnail,
    };
  }
}
