import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart' as sqlApi;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places_app/models/favorite_place.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'favorite_places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE favorite_places(id TEXT PRIMARY KEY, name TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
    },
    version: 1, // Change when updating the CREATE TABLE query
  );
  return db;
}

class FavoritePlacesNotifier extends StateNotifier<List<FavoritePlace>> {
  FavoritePlacesNotifier() : super(const []);

  Future<void> loadFavoritePlaces() async {
    final db = await _getDatabase();
    final data = await db.query('favorite_places');
    print('got here');
    final favoritePlaces = data
        .map(
          (row) => FavoritePlace(
            id: row['id'] as String,
            name: row['name'] as String,
            image: File(row['image'] as String),
            location: FavoritePlaceLocation(
              latitude: row['lat'] as double,
              longitude: row['lng'] as double,
              address: row['address'] as String,
            ),
          ),
        )
        .toList();
    print('got here 2');
    print(favoritePlaces);

    state = favoritePlaces;
  }

  void addFavoritePlace(
      String name, File image, FavoritePlaceLocation location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');

    final newFavoritePlace = FavoritePlace(
      name: name,
      image: copiedImage,
      location: location,
    );

    final db = await _getDatabase();

    db.insert(
      'favorite_places',
      {
        'id': newFavoritePlace.id,
        'name': newFavoritePlace.name,
        'image': newFavoritePlace.image.path,
        'lat': newFavoritePlace.location.latitude,
        'lng': newFavoritePlace.location.longitude,
        'address': newFavoritePlace.location.address,
      },
    );

    state = [
      ...state,
      newFavoritePlace,
    ];
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<FavoritePlace>>(
        (ref) => FavoritePlacesNotifier());
