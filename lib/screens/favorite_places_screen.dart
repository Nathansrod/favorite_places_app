import 'package:favorite_places_app/models/favorite_place.dart';
import 'package:favorite_places_app/providers/favorite_place_provider.dart';
import 'package:favorite_places_app/screens/new_favorite_place_screen.dart';
import 'package:favorite_places_app/widgets/favorite_places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlacesScreen extends ConsumerStatefulWidget {
  const FavoritePlacesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoritePlacesScreenState();
}

class _FavoritePlacesScreenState extends ConsumerState<FavoritePlacesScreen> {
  late Future<void> _favoritePlacesFuture;

  void _navigateToNewFavoritePlace(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NewFavoritePlaceScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _favoritePlacesFuture = ref.read(favoritePlacesProvider.notifier).loadFavoritePlaces();
  }

  @override
  Widget build(BuildContext context) {
    final favoritePlaces = ref.watch(favoritePlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              _navigateToNewFavoritePlace(context);
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: FutureBuilder(
          future: _favoritePlacesFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : FavoritePlacesList(
                      favoritePlaces: favoritePlaces,
                    ),
        ),
      ),
    );
  }
}
