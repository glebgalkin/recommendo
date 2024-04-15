import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/github/models/github_search_result_item.dart';

class GithubSearchResult extends BaseSearchResult {
  const GithubSearchResult({required this.items});

  factory GithubSearchResult.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>)
        .take(5)
        .map(
          (dynamic item) => GithubRepo.fromJson(item as Map<String, dynamic>),
        )
        .toList();
    return GithubSearchResult(items: items);
  }

  @override
  final List<GithubRepo> items;
}
