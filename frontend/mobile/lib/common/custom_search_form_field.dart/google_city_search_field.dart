import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/bloc/search_field_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/widget/custom_search_field.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/google_autocompletion_service.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/models/place_result.dart';
import 'package:recommendo/service_locator/service_locator.dart';

class GoogleCitySearchField extends StatelessWidget {
  const GoogleCitySearchField({
    required this.fieldLabel,
    this.onChanged,
    this.focusNode,
    this.initialValue,
    super.key,
  });

  final String fieldLabel;
  final PlaceResult? initialValue;
  final FocusNode? focusNode;
  final ValueChanged<PlaceResult?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final searchField = CustomSearchField(
      fieldLabel: fieldLabel,
      onChanged: (value) => onChanged?.call(value as PlaceResult?),
      initialValue: initialValue,
      focusNode: focusNode,
    );

    return BlocProvider(
      create: (_) => SearchFieldBloc(
        getIt<GoogleAutocompletionService>(
          instanceName: autoCompleteCity,
        ),
        initialValue,
      ),
      child: searchField,
    );
  }
}
