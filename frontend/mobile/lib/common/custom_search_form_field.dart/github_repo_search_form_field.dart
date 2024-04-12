import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/bloc/search_field_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/widget/search_form_field.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/github/github_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/github/models/github_search_result_item.dart';
import 'package:recommendo/service_locator/service_locator.dart';

class GithubRepoSearchFormField extends FormField<GithubRepo?> {
  GithubRepoSearchFormField({
    required FormFieldSetter<GithubRepo> onSaved,
    required FormFieldValidator<GithubRepo> validator,
    super.initialValue,
    super.key,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: AutovalidateMode.disabled,
          builder: (state) {
            return BlocProvider(
              create: (context) => SearchFieldBloc(
                formField: state,
                repository: getIt<GithubRepository>(),
              ),
              child: SearchFormField(
                state: state,
                fieldLabel: 'Github',
              ),
            );
          },
        );
}
