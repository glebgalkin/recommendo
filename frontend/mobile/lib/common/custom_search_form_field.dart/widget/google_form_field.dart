import 'package:flutter/material.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/base_search_item.dart';
import 'package:recommendo/common/custom_search_form_field.dart/widget/custom_serach_form_field.dart';

class GoogleFormField extends FormField<BaseSearchItem?> {
  GoogleFormField({
    required FormFieldSetter<BaseSearchItem> onSaved,
    required FormFieldValidator<BaseSearchItem> validator,
    super.initialValue,
    super.key,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: AutovalidateMode.disabled,
          builder: (state) {
            return CustomSearchFormField(state: state);
          },
        );
}
