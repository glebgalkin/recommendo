import 'package:recommendo/common/custom_search_form_field.dart/internal/base_search_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/github/service/models/github_result_item.dart';

class GithubSearchResult extends BaseSearchResult {
  const GithubSearchResult({required this.items});

  factory GithubSearchResult.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>)
        .take(5)
        .map(
          (dynamic item) =>
              GithubSearchResultItem.fromJson(item as Map<String, dynamic>),
        )
        .toList();
    return GithubSearchResult(items: items);
  }

  @override
  final List<GithubSearchResultItem> items;
}
