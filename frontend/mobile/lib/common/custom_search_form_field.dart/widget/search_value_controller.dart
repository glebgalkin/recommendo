import 'package:flutter/material.dart';
import 'package:recommendo/common/custom_search_form_field.dart/models/base_search_item.dart';

class SearchValueController extends ValueNotifier<BaseSearchItem?> {
  SearchValueController(super.value) {
    _textController = TextEditingController(text: value?.preview ?? '');
  }

  late final TextEditingController _textController;

  TextEditingController get previewController => _textController;

  void updateSearchValue(BaseSearchItem? newValue) {
    value = newValue;
    _textController.text = newValue?.preview ?? '';
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
