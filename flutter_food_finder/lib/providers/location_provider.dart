import 'package:flutter/material.dart';
import 'package:flutter_food_finder/services/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LocationProvider extends ChangeNotifier {
  Location? _location;

  get location => _location;

  LocationProvider() {
    setLocationGPS();
  }

  setLocationGPS() async {
    try {
      Position position = await LocationService.getPosition();

      _location = Location(
          latitude: position.latitude,
          longitude: position.longitude,
          timestamp: DateTime.now());

      notifyListeners();
    } catch (error) {
      _handleError(error.toString());
    }
  }

  setLocationAddress(String address) async {
    try {
      List<Location> locations =
          await locationFromAddress(address, localeIdentifier: 'en_UK');

      _location = locations[0];

      notifyListeners();
    } catch (error) {
      _handleError(error.toString());
    }
  }

  _handleError(String message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);

    _location = Location(
        latitude: 51.509865, longitude: -0.118092, timestamp: DateTime.now());

    notifyListeners();
  }
}
