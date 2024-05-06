part of 'search_field_bloc.dart';

sealed class SearchFieldState extends Equatable {
  const SearchFieldState({
    required this.showOverlay,
    required this.isLoading,
    required this.error,
    required this.value,
    required this.searchList,
  });

  final bool showOverlay;
  final bool isLoading;
  final SearchResultError? error;
  final BaseSearchItem? value;
  final List<BaseSearchItem> searchList;

  @override
  List<Object?> get props => [showOverlay, isLoading, error, searchList, value];
}

final class SearchFieldInitial extends SearchFieldState {
  const SearchFieldInitial({super.value})
      : super(
          showOverlay: false,
          isLoading: false,
          searchList: const [],
          error: null,
        );
}

final class SearchStateError extends SearchFieldState {
  const SearchStateError({required super.error, super.value})
      : super(
          showOverlay: true,
          isLoading: false,
          searchList: const [],
        );
}

final class SearchStateLoading extends SearchFieldState {
  const SearchStateLoading({super.value})
      : super(
          showOverlay: true,
          isLoading: true,
          searchList: const [],
          error: null,
        );
}

final class SearchStateSuccess extends SearchFieldState {
  const SearchStateSuccess({
    required super.searchList,
    this.previousList = false,
    super.value,
  }) : super(
          showOverlay: true,
          isLoading: false,
          error: null,
        );

  final bool previousList;
}
