part of 'search_field_bloc.dart';

sealed class SearchFieldEvent extends Equatable {
  const SearchFieldEvent();

  @override
  List<Object> get props => [];
}

final class TextChanged extends SearchFieldEvent {
  const TextChanged(this.text);

  final String text;

  @override
  List<Object> get props => [];

  @override
  String toString() => 'TextChanged';
}

final class ItemSelected extends SearchFieldEvent {
  const ItemSelected({required this.item});

  final BaseSearchItem item;

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'Item selected { text: $item }';
}

final class TapppedOutside extends SearchFieldEvent {
  const TapppedOutside();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'TapOutside';
}

final class ClearTapped extends SearchFieldEvent {
  const ClearTapped();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'ClearTapped';
}

final class SearchStarted extends SearchFieldEvent {
  const SearchStarted();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'SearchStarted';
}
