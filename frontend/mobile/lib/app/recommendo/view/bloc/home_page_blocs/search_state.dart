part of 'search_cubit.dart';

final class SearchState extends Equatable {
  const SearchState(this.cityResult, this.term);

  final PlaceResult? cityResult;
  final String term;

  @override
  List<Object?> get props => [cityResult, term];

  @override
  bool get stringify => true;
}
