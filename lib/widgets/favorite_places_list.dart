import 'package:favorite_places_app/models/favorite_place.dart';
import 'package:favorite_places_app/widgets/favorite_places_item.dart';
import 'package:flutter/material.dart';

class FavoritePlacesList extends StatelessWidget {
  const FavoritePlacesList({super.key, required this.favoritePlaces});

  final List<FavoritePlace> favoritePlaces;

  @override
  Widget build(BuildContext context) {
    if (favoritePlaces.isEmpty) {
      return Center(
        child: Text(
          'No places added yet.',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    return ListView.builder(
      itemCount: favoritePlaces.length,
      itemBuilder: (context, index) => FavoritePlacesItem(
        favoritePlace: favoritePlaces[index],
      ),
    );
  }
}
