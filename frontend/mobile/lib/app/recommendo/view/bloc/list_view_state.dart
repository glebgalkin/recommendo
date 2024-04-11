part of 'list_view_cubit.dart';

class ListViewState extends Equatable {
  const ListViewState({
    required this.values,
    required this.isLoading,
    required this.error,
    required this.hasReachedMax,
  });

  final List<RecommendationModel> values;
  final bool isLoading;
  final Object? error;
  final bool hasReachedMax;

  @override
  List<Object?> get props => [
        values,
        isLoading,
        error,
        hasReachedMax,
      ];

  ListViewState copyWith({
    List<RecommendationModel>? values,
    bool? isLoading,
    Object? error,
    bool? hasReachedMax,
  }) {
    return ListViewState(
      values: values ?? this.values,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

const initialState = ListViewState(
  values: [],
  isLoading: true,
  error: null,
  hasReachedMax: false,
);
