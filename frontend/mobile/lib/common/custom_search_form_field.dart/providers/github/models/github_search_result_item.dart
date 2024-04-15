import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_item.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/github/models/github_user.dart';

class GithubRepo extends BaseSearchItem {
  const GithubRepo({
    required this.fullName,
    required this.htmlUrl,
    required this.owner,
  });

  factory GithubRepo.fromJson(Map<String, dynamic> json) {
    return GithubRepo(
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
