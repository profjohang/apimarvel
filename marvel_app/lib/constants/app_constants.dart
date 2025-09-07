class AppConstants {
  // Marvel API Configuration
  static const String baseUrl = 'https://gateway.marvel.com/v1/public';
  static const String charactersEndpoint = '/characters';
  
  // CAMBIAR POR TUS CLAVES REALES DE MARVEL
  static const String publicKey = '7275f11e511df9f1af6624c76db5a894';
  static const String privateKey = 'b05c43ec966b86d4c8ed4caf5318d3fcf571f1dd';
  
  // App Configuration  
  static const String appName = 'Marvel Characters';
  static const int itemsPerPage = 20;
  
  // Strings
  static const String loading = 'Cargando...';
  static const String searchHint = 'Buscar personajes...';
  static const String noCharactersFound = 'No se encontraron personajes';
  static const String errorLoading = 'Error al cargar los datos';
  static const String retry = 'Reintentar';
  static const String description = 'Descripción';
  static const String noDescription = 'Sin descripción disponible';
}
