import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_food_finder/config/environment_config.dart';
import 'package:flutter_food_finder/providers/location_provider.dart';
import 'package:flutter_food_finder/providers/restaurant_provider.dart';
import 'package:provider/provider.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMapController? controller;

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return controller!.addImage(name, list);
  }

  void _onMapCreated(MapboxMapController controller) {
    this.controller = controller;
  }

  void _addMarkers() {
    addImageFromAsset("marker", "assets/images/map-marker.png");

    var restaurants =
        Provider.of<RestaurantProvider>(context, listen: false).restaurants;

    for (var restaurant in restaurants) {
      double lat = restaurant.coordinates['latitude'];
      double lng = restaurant.coordinates['longitude'];

      controller!.addSymbol(SymbolOptions(
          geometry: LatLng(lat, lng), iconImage: "marker", iconSize: 1.5));
    }
  }

  @override
  Widget build(BuildContext context) {
    var location = context.watch<LocationProvider>().location;

    if (location == null) {
      return const CircularProgressIndicator();
    }

    return MapboxMap(
      styleString: MapboxStyles.MAPBOX_STREETS,
      accessToken: EnvironmentConfig.MAPBOX_ACCESS_TOKEN,
      onMapCreated: _onMapCreated,
      onStyleLoadedCallback: _addMarkers,
      initialCameraPosition: CameraPosition(
          target: LatLng(location.latitude, location.longitude), zoom: 12),
    );
  }
}
