import 'package:recommendo/common/custom_search_form_field.dart/github/service/models/github_user.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_item.dart';

class GithubSearchResultItem extends BaseSearchItem {
  const GithubSearchResultItem({
    required this.fullName,
    required this.htmlUrl,
    required this.owner,
  });

  factory GithubSearchResultItem.fromJson(Map<String, dynamic> json) {
    return GithubSearchResultItem(
      fullName: json['full_name'] as String,
      htmlUrl: json['html_url'] as String,
      owner: GithubUser.fromJson(json['owner'] as Map<String, dynamic>),
    );
  }

  final String fullName;
  final String htmlUrl;
  final GithubUser owner;

  @override
  String get preview => fullName;

  @override
  String get previewImage => owner.avatarUrl;

  @override
  String get value => owner.login;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [value];
}
