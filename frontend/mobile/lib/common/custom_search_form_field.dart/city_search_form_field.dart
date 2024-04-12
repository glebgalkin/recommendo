import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/bloc/search_field_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/widget/search_form_field.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/google_auto_completion_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/city_result.dart';
import 'package:recommendo/service_locator/service_locator.dart';

class SearchCityFormField extends FormField<CityResult?> {
  SearchCityFormField({
    required FormFieldSetter<CityResult> onSaved,
    required FormFieldValidator<CityResult> validator,
    super.initialValue,
    super.key,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (state) {
            return BlocProvider(
              create: (context) => SearchFieldBloc(
                formField: state,
                repository: getIt<GoogleAutoCompletionRepository>(
                  instanceName: autoCompleteCity,
                ),
              ),
              child: SearchFormField(
                state: state,
                fieldLabel: 'City',
              ),
            );
          },
        );
}
