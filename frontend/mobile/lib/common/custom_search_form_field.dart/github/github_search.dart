import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/bloc/search_field_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/github/service/github_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/github/service/models/github_result_item.dart';
import 'package:recommendo/common/custom_search_form_field.dart/widget/custom_serach_form_field.dart';
import 'package:recommendo/service_locator/service_locator.dart';

class GithubSearchFormField extends FormField<GithubSearchResultItem?> {
  GithubSearchFormField({
    required FormFieldSetter<GithubSearchResultItem> onSaved,
    required FormFieldValidator<GithubSearchResultItem> validator,
    super.initialValue,
    super.key,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: AutovalidateMode.disabled,
          builder: (state) {
            return BlocProvider(
              create: (context) =>
                  SearchFieldBloc(repository: getIt<GithubRepository>()),
              child: CustomSearchFormField(state: state),
            );
          },
        );
}
