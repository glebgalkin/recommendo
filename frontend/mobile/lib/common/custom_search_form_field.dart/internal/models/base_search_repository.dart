import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_result.dart';

abstract class BaseSearchRepository {
  const BaseSearchRepository();
  Future<BaseSearchResult> search(String term);
}
