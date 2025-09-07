import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/characters_provider.dart';
import '../widgets/character_card.dart';
import '../screens/character_detail_screen.dart';
import '../constants/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchMode = false;

  @override
  void initState() {
    super.initState();
    // Cargar personajes al iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CharactersProvider>().loadCharacters();
    });

    // Listener para scroll infinito
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= 
          _scrollController.position.maxScrollExtent * 0.8) {
        context.read<CharactersProvider>().loadCharacters();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearchMode = !_isSearchMode;
      if (!_isSearchMode) {
        _searchController.clear();
        context.read<CharactersProvider>().clearSearch();
      }
    });
  }

  void _onSearchChanged(String query) {
    context.read<CharactersProvider>().searchCharacters(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearchMode 
          ? TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: AppConstants.searchHint,
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: _onSearchChanged,
              autofocus: true,
            )
          : const Text(AppConstants.appName),
        backgroundColor: Colors.red[600],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isSearchMode ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: Consumer<CharactersProvider>(
        builder: (context, provider, child) {
          // Mostrar error si existe y no hay datos
          if (provider.error.isNotEmpty && provider.characters.isEmpty) {
            return _buildErrorWidget(provider.error, () {
              provider.loadCharacters(refresh: true);
            });
          }

          final charactersToShow = _isSearchMode && _searchController.text.isNotEmpty
            ? provider.searchResults
            : provider.characters;

          // Mostrar loading si no hay datos
          if (charactersToShow.isEmpty && 
              (provider.isLoading || provider.isSearching)) {
            return const Center(child: CircularProgressIndicator());
          }

          // Mostrar mensaje si no hay resultados
          if (charactersToShow.isEmpty) {
            return _buildEmptyWidget();
          }

          // Mostrar grid de personajes
          return RefreshIndicator(
            onRefresh: () => provider.loadCharacters(refresh: true),
            child: GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: charactersToShow.length + 
                (!_isSearchMode && provider.hasMore && provider.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                // Indicador de carga al final
                if (index >= charactersToShow.length) {
                  return const Center(child: CircularProgressIndicator());
                }

                final character = charactersToShow[index];
                return CharacterCard(
                  character: character,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CharacterDetailScreen(
                          character: character,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorWidget(String error, VoidCallback onRetry) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[400],
          ),
          const SizedBox(height: 16),
          const Text(
            AppConstants.errorLoading,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text(AppConstants.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            _isSearchMode 
              ? AppConstants.noCharactersFound
              : 'No hay personajes disponibles',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
