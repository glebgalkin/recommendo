import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/bloc/search_field_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/widget/custom_search_form_field.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/google_autocompletion_service.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/models/place_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/search_field_default_error.dart';
import 'package:recommendo/common/localized_error_text.dart';
import 'package:recommendo/l10n/l10n.dart';
import 'package:recommendo/service_locator/service_locator.dart';

class GoogleEstablishmentSearchFormField extends StatelessWidget {
  const GoogleEstablishmentSearchFormField({
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
    final searchFormField = CustomSearchFormField<PlaceResult>(
      onSaved: onSaved,
      validator: validator,
      fieldLabel: fieldLabel,
      initialValue: initialValue,
      focusNode: focusNode,
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
          instanceName: autoCompleteEstablishment,
        ),
        initialValue,
      ),
      child: searchFormField,
    );
  }
}
