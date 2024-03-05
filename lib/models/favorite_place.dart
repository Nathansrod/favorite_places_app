import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class FavoritePlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const FavoritePlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class FavoritePlace {
  final String id;
  final String name;
  final File image;
  final FavoritePlaceLocation location;

  FavoritePlace({
    required this.name,
    required this.image,
    required this.location,
    String? id,
  }) : id = id ?? uuid.v4();
}
