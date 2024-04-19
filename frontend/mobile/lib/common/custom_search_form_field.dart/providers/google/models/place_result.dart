import 'package:hive/hive.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_item.dart';

part 'place_result.g.dart';

@HiveType(typeId: 0)
class PlaceResult extends BaseSearchItem {
  const PlaceResult({
    required this.preview,
    required this.value,
  });

  @override
  @HiveField(0)
  final String preview;

  @override
  @HiveField(1)
  final String value;

  factory PlaceResult.fromJson(Map<String, dynamic> json) {
    return PlaceResult(
      preview: json['description'] as String,
      value: json['place_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': preview,
      'id': value,
    };
  }

  @override
  String? get previewImage => null;
}