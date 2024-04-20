part of 'search_cubit.dart';

@JsonSerializable()
final class SearchState extends Equatable {
  const SearchState(this.cityResult, this.term);

  final PlaceResult? cityResult;
  final String term;

  @override
  List<Object?> get props => [cityResult, term];

  @override
  bool get stringify => true;

  factory SearchState.fromJson(Map<String, dynamic> json) =>
      _$SearchStateFromJson(json);

  Map<String, dynamic> toJson() => _$SearchStateToJson(this);
}
