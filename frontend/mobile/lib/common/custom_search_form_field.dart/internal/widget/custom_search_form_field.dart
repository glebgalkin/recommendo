import 'package:flutter/material.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_item.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/widget/custom_search_field.dart';

class CustomSearchFormField<T extends BaseSearchItem> extends FormField<T?> {
  CustomSearchFormField({
    required String fieldLabel,
    required BaseSearchRepository searchRepository,
    ValueChanged<T?>? onChanged,
    InputDecoration? decoration,
    FocusNode? focusNode,
    super.onSaved,
    super.validator,
    super.initialValue,
    super.key,
  }) : super(
          builder: (field) {
            final effectiveDecoration = (decoration ?? const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            void onChangedHandler(BaseSearchItem? value) {
              field
                ..didChange(value as T?)
                ..save();
              onChanged?.call(value);
            }

            return CustomSearchField(
              searchRepository: searchRepository,
              fieldLabel: fieldLabel,
              initialValue: initialValue,
              onChanged: onChangedHandler,
              focusNode: focusNode,
              inputDecoration: effectiveDecoration.copyWith(
                errorText: field.errorText,
              ),
            );
          },
        );
}
