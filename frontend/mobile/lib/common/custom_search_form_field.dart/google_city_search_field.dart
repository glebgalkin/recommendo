import 'package:flutter/material.dart' hide ErrorWidgetBuilder;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/bloc/search_field_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/widget/custom_search_field.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/widget/search_value_controller.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/google_autocompletion_service.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/models/place_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/search_field_default_error.dart';
import 'package:recommendo/common/localized_error_text.dart';
import 'package:recommendo/l10n/l10n.dart';
import 'package:recommendo/service_locator/service_locator.dart';

class GoogleCitySearchField extends StatelessWidget {
  const GoogleCitySearchField({
    required this.fieldLabel,
    this.onChanged,
    this.focusNode,
    this.initialValue,
    this.controller,
    this.inputDecoration,
    this.suffixIcon,
    super.key,
  });

  final String fieldLabel;
  final PlaceResult? initialValue;
  final FocusNode? focusNode;
  final ValueChanged<PlaceResult?>? onChanged;
  final SearchValueController? controller;
  final InputDecoration? inputDecoration;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final searchField = CustomSearchField(
      fieldLabel: fieldLabel,
      onChanged: (value) => onChanged?.call(value as PlaceResult?),
      initialValue: initialValue,
      focusNode: focusNode,
      controller: controller,
      inputDecoration: inputDecoration,
      suffixIcon: suffixIcon,
      errorBuilder: (context, error) => SearchFieldDefaultError(
        error: localizedErrorText(
          error.code,
          context.l10n,
        ),
      ),
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
