import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/google/service/google_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/google/service/models/google_search_result_item.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/bloc/search_field_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/widget/search_form_field.dart';
import 'package:recommendo/service_locator/service_locator.dart';

class SearchCityFormField extends FormField<GoogleMapsSearchResultItem?> {
  SearchCityFormField({
    required FormFieldSetter<GoogleMapsSearchResultItem> onSaved,
    required FormFieldValidator<GoogleMapsSearchResultItem> validator,
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
                repository: getIt<GoogleMapsRepository>(),
              ),
              child: SearchFormField(
                state: state,
                fieldLabel: 'City',
              ),
            );
          },
        );
}
