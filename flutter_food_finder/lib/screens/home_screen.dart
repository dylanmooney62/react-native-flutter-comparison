import 'package:flutter/material.dart';
import 'package:flutter_food_finder/providers/restaurant_provider.dart';
import 'package:flutter_food_finder/widgets/restaurant_list.dart';
import 'package:flutter_food_finder/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurants = context.watch<RestaurantProvider>().restaurants;

    return Scaffold(
        appBar: AppBar(title: const Text("FoodFinder")),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SearchBar(),
            ),
            Expanded(child: RestaurantList(restaurants: restaurants))
          ],
        ));
  }
}
