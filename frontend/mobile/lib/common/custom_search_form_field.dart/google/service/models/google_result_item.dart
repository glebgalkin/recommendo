import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_item.dart';

class GoogleMapsSearchResultItem extends BaseSearchItem {
  const GoogleMapsSearchResultItem({
    required this.fullName,
    required this.htmlUrl,
  });

  factory GoogleMapsSearchResultItem.fromJson(Map<String, dynamic> json) {
    return GoogleMapsSearchResultItem(
      fullName: json['full_name'] as String,
      htmlUrl: json['html_url'] as String,
    );
  }

  final String fullName;
  final String htmlUrl;

  @override
  String get preview => fullName;

  @override
  String? get previewImage => null;

  @override
  String get value => htmlUrl;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [value];
}
