import 'package:flutter/material.dart';
import 'package:google_maps_places_autocomplete_widgets/address_autocomplete_widgets.dart';

const Duration fakeAPIDuration = Duration(seconds: 1);
const Duration debounceDuration = Duration(milliseconds: 500);

class AsyncAutocomplete extends StatefulWidget {
  const AsyncAutocomplete({required this.controller, super.key});

  final TextEditingController controller;

  @override
  State<AsyncAutocomplete> createState() => AsyncAutocompleteState();
}

class AsyncAutocompleteState extends State<AsyncAutocomplete> {
  @override
  Widget build(BuildContext context) {
    return AddressAutocompleteTextField(
      mapsApiKey: '',
      controller: widget.controller,
      onSuggestionClick: (place) {
        widget.controller.text = place.city!;
      },
    );
  }
}
