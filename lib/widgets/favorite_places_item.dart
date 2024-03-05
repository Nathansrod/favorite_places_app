import 'package:favorite_places_app/screens/favorite_place_details_screen.dart';
import 'package:flutter/material.dart';

import '../models/favorite_place.dart';

class FavoritePlacesItem extends StatelessWidget {
  const FavoritePlacesItem({super.key, required this.favoritePlace});

  final FavoritePlace favoritePlace;

  void _navigateToDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FavoritePlaceDetailsScreen(
          favoritePlace: favoritePlace,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        _navigateToDetails(context);
      },
      leading: CircleAvatar(
        radius: 26,
        backgroundImage: FileImage(favoritePlace.image),
      ),
      title: Text(
        favoritePlace.name,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        favoritePlace.location.address,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
    );
  }
}
