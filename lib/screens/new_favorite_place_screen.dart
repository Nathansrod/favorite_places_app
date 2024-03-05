import 'dart:io';

import 'package:favorite_places_app/models/favorite_place.dart';
import 'package:favorite_places_app/providers/favorite_place_provider.dart';
import 'package:favorite_places_app/widgets/image_input.dart';
import 'package:favorite_places_app/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewFavoritePlaceScreen extends ConsumerStatefulWidget {
  const NewFavoritePlaceScreen({super.key});

  @override
  ConsumerState<NewFavoritePlaceScreen> createState() =>
      _NewFavoritePlaceScreenState();
}

class _NewFavoritePlaceScreenState
    extends ConsumerState<NewFavoritePlaceScreen> {
  final TextEditingController _favoritePlaceNameController =
      TextEditingController();
  File? _selectedImage;
  FavoritePlaceLocation? _selectedLocation;

  @override
  void dispose() {
    _favoritePlaceNameController.dispose();
    super.dispose();
  }

  void _onSelectImage(File image) {
    _selectedImage = image;
  }

  void _onSelectLocation(FavoritePlaceLocation location) {
    _selectedLocation = location;
  }

  void _addFavoritePlace() {
    final favoritePlaceName = _favoritePlaceNameController.text;

    if (favoritePlaceName.isEmpty || _selectedImage == null || _selectedLocation == null) {
      return;
    }

    ref.read(favoritePlacesProvider.notifier).addFavoritePlace(
        favoritePlaceName, _selectedImage!, _selectedLocation!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                label: Text('Name'),
              ),
              controller: _favoritePlaceNameController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ImageInput(
              onSelectImage: _onSelectImage,
            ),
            const SizedBox(
              height: 12,
            ),
            LocationInput(
              onSelectLocation: _onSelectLocation,
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton.icon(
              onPressed: _addFavoritePlace,
              icon: const Icon(
                Icons.add,
                size: 24,
              ),
              label: const Text('Add place'),
            ),
          ],
        ),
      ),
    );
  }
}
