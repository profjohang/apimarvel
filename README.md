# Marvel Characters App 🦸‍♂️

Aplicación Flutter que consume la API de Marvel para mostrar información de personajes.

## 📱 Características

- ✅ Consume API REST de Marvel Comics
- ✅ Lista de personajes con scroll infinito
- ✅ Búsqueda de personajes en tiempo real
- ✅ Pantalla de detalles con imagen expandible
- ✅ Caché de imágenes para mejor rendimiento
- ✅ Manejo de estados de carga y errores
- ✅ Pull-to-refresh para actualizar datos
- ✅ Arquitectura Provider para gestión de estado

## 🚀 Tecnologías Utilizadas

- **Flutter** 3.0+
- **Dart** 3.0+
- **Provider** - Gestión de estado
- **HTTP** - Peticiones a la API
- **Crypto** - Generación de hash MD5 para autenticación
- **Cached Network Image** - Caché de imágenes

## 📋 Requisitos Previos

1. **Flutter SDK** instalado
2. **Cuenta de desarrollador en Marvel** (gratuita)
3. **Android Studio** o **VS Code** con extensiones de Flutter

## 🔧 Instalación

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/tu-usuario/marvel-flutter-app.git
   cd marvel-flutter-app
   ```

2. **Instalar dependencias:**
   ```bash
   flutter pub get
   ```

3. **Configurar claves de API:**
   - Ve a [Marvel Developer Portal](https://developer.marvel.com/)
   - Regístrate y obtén tu Public Key y Private Key
   - Actualiza las constantes en `lib/constants/app_constants.dart`:
   ```dart
   static const String publicKey = 'TU_PUBLIC_KEY';
   static const String privateKey = 'TU_PRIVATE_KEY';
   ```

4. **Ejecutar la aplicación:**
   ```bash
   flutter run
   ```

## 📁 Estructura del Proyecto

```
lib/
├── main.dart                    # Punto de entrada
├── constants/
│   └── app_constants.dart       # Constantes de la aplicación
├── models/
│   └── character.dart           # Modelo de datos del personaje
├── services/
│   └── marvel_api_service.dart  # Servicio para consumir la API
├── providers/
│   └── characters_provider.dart # Gestión de estado con Provider
├── widgets/
│   └── character_card.dart      # Widget reutilizable para personajes
└── screens/
    ├── home_screen.dart         # Pantalla principal
    └── character_detail_screen.dart # Pantalla de detalles
```

## 🌐 API Utilizada

- **Marvel Comics API**: `https://developer.marvel.com/`
- **Endpoint principal**: `https://gateway.marvel.com/v1/public/characters`
- **Autenticación**: Hash MD5 con timestamp + claves públicas/privadas
- **Documentación**: [Marvel API Documentation](https://developer.marvel.com/docs)

## 📱 Capturas de Pantalla

### Pantalla Principal
- Lista de personajes en formato grid
- Barra de búsqueda integrada
- Indicadores de carga

### Pantalla de Detalles
- Imagen expandible del personaje
- Descripción completa
- Información adicional (cómics, series)

## 🎓 Propósito Académico

Este proyecto fue desarrollado como trabajo académico para demostrar:

1. **Consumo de API REST** con método GET
2. **Modelado de datos** con `fromJson()` y `toJson()`
3. **Gestión de estado** con Provider
4. **Arquitectura limpia** y separación de responsabilidades
5. **Manejo de errores** y casos edge
6. **UI/UX responsive** con Material Design

## 🚀 Funcionalidades Implementadas

### Requerimientos Cumplidos:
- [x] Buscar y seleccionar una API pública de Internet
- [x] Consumir un endpoint de esta API (GET)
- [x] Definir una clase modelo con métodos fromJson y toJson
- [x] Mostrar en la aplicación los datos obtenidos

### Funcionalidades Adicionales:
- [x] Búsqueda en tiempo real
- [x] Scroll infinito con paginación
- [x] Caché de imágenes
- [x] Pull-to-refresh
- [x] Navegación entre pantallas
- [x] Manejo robusto de errores

## 🛠️ Comandos Útiles

```bash
# Limpiar el proyecto
flutter clean

# Obtener dependencias
flutter pub get

# Ejecutar en modo debug
flutter run

# Ejecutar en modo release
flutter run --release

# Generar APK
flutter build apk
```

## 📄 Licencia

Este proyecto es de uso académico y educativo.

## 👨‍💻 Autor

**Johan Guerrero** - *Estudiante* - UPB

---

⭐ Si te gustó este proyecto, dale una estrella en GitHub!
