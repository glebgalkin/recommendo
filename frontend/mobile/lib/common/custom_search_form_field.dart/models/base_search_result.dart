import 'package:recommendo/common/custom_search_form_field.dart/models/base_search_item.dart';

abstract class BaseSearchResult {
  const BaseSearchResult();
  List<BaseSearchItem> get items;
}
