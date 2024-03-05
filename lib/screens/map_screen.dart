import 'package:favorite_places_app/constants.dart';
import 'package:favorite_places_app/models/favorite_place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, this.location});

  final FavoritePlaceLocation? location;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    final isSelecting = widget.location == null;
    final lat = isSelecting ? kDefaultLat : widget.location!.latitude;
    final lng = isSelecting ? kDefaultLng : widget.location!.longitude;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isSelecting ? 'Pick your location' : widget.location!.address,
        ),
        actions: [
          if (isSelecting)
            IconButton(
              icon: const Icon(
                Icons.save,
              ),
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
            ),
        ],
      ),
      body: GoogleMap(
        onTap: isSelecting ? (position) {
          setState(() {
            _pickedLocation = position;
          });
        } : null,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            lat,
            lng,
          ),
          zoom: 16,
        ),
        markers: (_pickedLocation == null && isSelecting) ? {} : {
          Marker(
            markerId: const MarkerId(
              'm1',
            ),
            position: _pickedLocation ?? LatLng(
              lat,
              lng,
            ),
          ),
        },
      ),
    );
  }
}
