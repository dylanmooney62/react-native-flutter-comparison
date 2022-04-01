import 'package:flutter/material.dart';
import 'package:flutter_food_finder/providers/location_provider.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  _handleFieldSubmitted(String address) {
    var location = context.read<LocationProvider>();

    // If search is empty set location to GPS as default
    address.isNotEmpty
        ? location.setLocationAddress(address)
        : location.setLocationGPS();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      onFieldSubmitted: _handleFieldSubmitted,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Enter Location',
      ),
    );
  }
}
