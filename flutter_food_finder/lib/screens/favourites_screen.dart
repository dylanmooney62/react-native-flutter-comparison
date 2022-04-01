import 'package:flutter/material.dart';
import 'package:flutter_food_finder/providers/favourites_provider.dart';
import 'package:flutter_food_finder/widgets/restaurant_list.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurants = context.watch<FavouritesProvider>().favourites;

    return Scaffold(
        appBar: AppBar(title: const Text("Favourites")),
        body: RestaurantList(restaurants: restaurants));
  }
}
