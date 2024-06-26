import 'package:recommendo/common/custom_search_form_field.dart/models/base_search_item.dart';
import 'package:recommendo/common/custom_search_form_field.dart/models/base_search_result.dart';

abstract class BaseSearchRepository {
  const BaseSearchRepository();

  Future<BaseSearchResult> search(String term);
  BaseSearchResult offlineSearch(String term);
  BaseSearchResult previousSearchResult();
  Future<void> saveSelected(BaseSearchItem item);
}
