import 'package:hive/hive.dart';

part 'local_place_result.g.dart';

@HiveType(typeId: 1)
class LocalPlaceResult {
  @HiveField(0)
  final String preview;

  @HiveField(1)
  final String value;

  @HiveField(2)
  final DateTime timeSelected;

  const LocalPlaceResult({
    required this.preview,
    required this.value,
    required this.timeSelected,
  });
}
