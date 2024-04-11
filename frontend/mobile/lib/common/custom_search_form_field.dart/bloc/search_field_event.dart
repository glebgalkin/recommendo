import 'package:equatable/equatable.dart';

sealed class SearchFieldEvent extends Equatable {
  const SearchFieldEvent();
}

final class TextChanged extends SearchFieldEvent {
  const TextChanged({required this.text});

  final String text;

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'TextChanged { text: $text }';
}
