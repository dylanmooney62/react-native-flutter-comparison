import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  const Rating({Key? key, required this.rating}) : super(key: key);

  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: List<int>.filled(rating, 0)
            .map((e) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 24,
                ))
            .toList());
  }
}
