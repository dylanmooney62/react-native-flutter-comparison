import 'package:flutter/material.dart';

class FavouriteButton extends StatelessWidget {
  const FavouriteButton(
      {Key? key, required this.isFavourite, required this.onPressed})
      : super(key: key);

  final bool isFavourite;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Widget icon;

    if (isFavourite) {
      icon = const Icon(Icons.favorite, color: Colors.red, size: 36);
    } else {
      icon = const Icon(Icons.favorite_outline, color: Colors.white, size: 36);
    }

    return IconButton(onPressed: onPressed, icon: icon);
  }
}
