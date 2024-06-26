import 'package:flutter/material.dart' hide ErrorWidgetBuilder;
import 'package:recommendo/common/custom_search_form_field.dart/models/base_search_item.dart';
import 'package:recommendo/common/custom_search_form_field.dart/widget/custom_search_field.dart';
import 'package:recommendo/common/custom_search_form_field.dart/widget/search_value_controller.dart';

class CustomSearchFormField<T extends BaseSearchItem> extends FormField<T?> {
  CustomSearchFormField({
    required String fieldLabel,
    required ErrorWidgetBuilder errorWidget,
    ValueChanged<T?>? onChanged,
    InputDecoration? decoration,
    FocusNode? focusNode,
    SearchValueController? controller,
    IsOfflineSearchCallback? isOfflineSearchCallback,
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
              fieldLabel: fieldLabel,
              initialValue: initialValue,
              onChanged: onChangedHandler,
              focusNode: focusNode,
              errorBuilder: errorWidget,
              controller: controller,
              isOfflineSearchCallback: isOfflineSearchCallback,
              inputDecoration: effectiveDecoration.copyWith(
                errorText: field.errorText,
              ),
            );
          },
        );
}
