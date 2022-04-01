import 'package:flutter/material.dart';
import 'package:flutter_food_finder/models/restaurant.dart';
import 'package:flutter_food_finder/providers/favourites_provider.dart';
import 'package:flutter_food_finder/widgets/restaurant_card/favourite_button.dart';
import 'package:flutter_food_finder/widgets/restaurant_card/rating.dart';
import 'package:provider/provider.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard(
      {Key? key, required this.restaurant, required this.distance})
      : super(key: key);

  final Restaurant restaurant;
  final String distance;

  @override
  Widget build(BuildContext context) {
    final imageUrl = restaurant.imageUrl.isNotEmpty
        ? restaurant.imageUrl
        : "https://picsum.photos/id/163/400/300";

    var favourites = context.watch<FavouritesProvider>();

    bool isFavourite =
        favourites.favourites.indexWhere((r) => r.id == restaurant.id) >= 0;

    return Container(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 280,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.44),
                                  BlendMode.dstATop),
                              image: NetworkImage(imageUrl)),
                        )),
                        Positioned(
                            top: 0,
                            left: 0,
                            child: FavouriteButton(
                              isFavourite: isFavourite,
                              onPressed: () => !isFavourite
                                  ? favourites.addFavourite(restaurant)
                                  : favourites.removeFavourite(restaurant),
                            )),
                        Positioned(
                            top: 12,
                            right: 12,
                            child: Row(children: [
                              const Icon(
                                Icons.navigation,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "${distance}m",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Open-sans'),
                              )
                            ]))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Text(restaurant.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Open-sans')),
                            ),
                            Expanded(
                                flex: 4,
                                child:
                                    Rating(rating: restaurant.rating.toInt()))
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          restaurant.address,
                          style: const TextStyle(fontFamily: 'Open-sans'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
