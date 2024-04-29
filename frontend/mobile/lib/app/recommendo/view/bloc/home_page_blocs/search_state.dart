part of 'search_cubit.dart';

@JsonSerializable()
final class SearchState extends Equatable {
  const SearchState({
    this.cityResult,
    this.term = '',
    this.loadingGeoLocatoin = false,
    this.errorCode,
  });

  final PlaceResult? cityResult;
  @JsonKey(includeToJson: false)
  final String term;
  @JsonKey(includeToJson: false)
  final bool loadingGeoLocatoin;
  @JsonKey(includeToJson: false)
  final LocalizedErrorMessage? errorCode;

  @override
  List<Object?> get props => [
        cityResult,
        term,
        loadingGeoLocatoin,
        errorCode,
      ];

  @override
  bool get stringify => true;

  factory SearchState.fromJson(Map<String, dynamic> json) =>
      _$SearchStateFromJson(json);

  Map<String, dynamic> toJson() => _$SearchStateToJson(this);
}
