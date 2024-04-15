part of 'search_cubit.dart';

final class SearchState extends Equatable {
  const SearchState(this.cityResult, this.term);

  final CityResult? cityResult;
  final String term;

  @override
  List<Object?> get props => [cityResult, term];
}
