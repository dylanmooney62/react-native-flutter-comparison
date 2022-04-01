import 'package:flutter_food_finder/services/distance_convertor.dart';
import 'package:geolocator/geolocator.dart';

class Restaurant {
  final String id;
  final String name;
  final String imageUrl;
  final String address;
  final double rating;
  final Map<String, dynamic> coordinates;

  const Restaurant(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.address,
      required this.rating,
      required this.coordinates});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
        id: json['id'],
        name: json['name'],
        imageUrl: json['image_url'],
        address: json['location']['address1'],
        rating: json['rating'],
        coordinates: json['coordinates']);
  }

  double getDistanceFrom(double lat, double lng) {
    final double meters = Geolocator.distanceBetween(
        lat, lng, coordinates['latitude'], coordinates['longitude']);

    return DistanceConvertor.metersToMiles(meters);
  }
}
