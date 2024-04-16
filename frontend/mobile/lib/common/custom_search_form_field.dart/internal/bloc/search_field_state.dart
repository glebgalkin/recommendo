import 'package:equatable/equatable.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_item.dart';

sealed class SearchFieldState extends Equatable {
  const SearchFieldState();

  @override
  List<Object> get props => [];
}

final class SearchStateEmpty extends SearchFieldState {
  const SearchStateEmpty();
}

final class SearchStateLoading extends SearchFieldState {
  const SearchStateLoading();
}

final class SearchStateSuccess extends SearchFieldState {
  const SearchStateSuccess(this.items);

  final List<BaseSearchItem> items;

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'SearchStateSuccess { items: ${items.length} }';
}

final class SearchStateError extends SearchFieldState {
  const SearchStateError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
