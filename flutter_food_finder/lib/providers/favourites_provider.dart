import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_food_finder/models/restaurant.dart';
import 'package:flutter_food_finder/services/yelp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesProvider extends ChangeNotifier {
  final List<Restaurant> _favourites = [];

  List<Restaurant> get favourites => _favourites;

  FavouritesProvider() {
    getFavourites();
  }

  getFavourites() async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve ids of favourites
    List<String> ids = (prefs.getStringList('favourites') ?? []);

    if (ids.isEmpty) return;

    // Request restaurant data for each id
    List<Restaurant?> restaurants =
        await Future.wait(ids.map((id) => Yelp.getRestaurantById(id)));

    // Filter out null values
    restaurants.removeWhere((r) => r == null);

    if (restaurants.isEmpty) return;

    _favourites.addAll(List<Restaurant>.from(restaurants));

    notifyListeners();
  }

  addFavourite(Restaurant restaurant) async {
    final prefs = await SharedPreferences.getInstance();

    _favourites.add(restaurant);

    prefs.setStringList('favourites',
        _favourites.map((Restaurant restaurant) => restaurant.id).toList());

    // Notify widgets to rebuild
    notifyListeners();
  }

  removeFavourite(Restaurant restaurant) async {
    final prefs = await SharedPreferences.getInstance();

    _favourites.removeWhere((r) => r.id == restaurant.id);

    prefs.setStringList('favourites',
        _favourites.map((Restaurant restaurant) => restaurant.id).toList());

    // Notify widgets to rebuild
    notifyListeners();
  }
}
