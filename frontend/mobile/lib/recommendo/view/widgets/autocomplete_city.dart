import 'package:flutter/material.dart';
import 'package:google_maps_places_autocomplete_widgets/address_autocomplete_widgets.dart';

class CityAutocompleteField extends StatefulWidget {
  const CityAutocompleteField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  State<CityAutocompleteField> createState() => CityAutocompleteFieldState();
}

class CityAutocompleteFieldState extends State<CityAutocompleteField> {
  @override
  Widget build(BuildContext context) {
    return AddressAutocompleteTextField(
      mapsApiKey: '',
      controller: widget.controller,
      decoration: const InputDecoration(
        label: Text('City'),
      ),
      onSuggestionClick: (place) {
        widget.controller.text = place.city!;
      },
    );
  }
}
