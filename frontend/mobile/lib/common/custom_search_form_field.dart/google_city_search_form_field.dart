import 'package:flutter/material.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/widget/custom_search_form_field.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/google_auto_completion_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/place_result.dart';
import 'package:recommendo/service_locator/service_locator.dart';

class GoogleCitySearchFormField extends StatelessWidget {
  const GoogleCitySearchFormField({
    required this.onSaved,
    required this.validator,
    required this.fieldLabel,
    this.focusNode,
    this.initialValue,
    super.key,
  });

  final FormFieldSetter<PlaceResult?> onSaved;
  final FormFieldValidator<PlaceResult?> validator;
  final String fieldLabel;
  final PlaceResult? initialValue;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return CustomSearchFormField<PlaceResult>(
      onSaved: onSaved,
      validator: validator,
      fieldLabel: fieldLabel,
      initialValue: initialValue,
      focusNode: focusNode,
      searchRepository: getIt<GoogleAutoCompletionRepository>(
        instanceName: autoCompleteCity,
      ),
    );
  }
}
