import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/bloc/search_field_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/widget/custom_search_field.dart';
import 'package:recommendo/common/custom_search_form_field.dart/widget/custom_search_form_field.dart';
import 'package:recommendo/common/custom_search_form_field.dart/widget/search_value_controller.dart';
import 'package:recommendo/common/google_search/service/google_autocompletion_service.dart';
import 'package:recommendo/common/google_search/service/models/place_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/widget/search_field_default_error.dart';
import 'package:recommendo/common/localized_error_text.dart';
import 'package:recommendo/l10n/l10n.dart';
import 'package:recommendo/service_locator/service_locator.dart';

class GoogleCitySearchFormField extends StatelessWidget {
  const GoogleCitySearchFormField({
    required this.onSaved,
    required this.validator,
    required this.fieldLabel,
    this.focusNode,
    this.initialValue,
    this.controller,
    this.isOfflineSearchCallback,
    super.key,
  });

  final FormFieldSetter<PlaceResult?> onSaved;
  final FormFieldValidator<PlaceResult?> validator;
  final String fieldLabel;
  final PlaceResult? initialValue;
  final FocusNode? focusNode;
  final SearchValueController? controller;
  final IsOfflineSearchCallback? isOfflineSearchCallback;

  @override
  Widget build(BuildContext context) {
    final searchFormField = CustomSearchFormField<PlaceResult>(
      onSaved: onSaved,
      validator: validator,
      fieldLabel: fieldLabel,
      initialValue: initialValue,
      focusNode: focusNode,
      controller: controller,
      isOfflineSearchCallback: isOfflineSearchCallback,
      errorWidget: (context, error) => SearchFieldDefaultError(
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
      child: searchFormField,
    );
  }
}
