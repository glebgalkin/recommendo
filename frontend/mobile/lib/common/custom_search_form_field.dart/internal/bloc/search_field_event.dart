import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_item.dart';

sealed class SearchFieldEvent extends Equatable {
  const SearchFieldEvent();
}

final class TextChanged extends SearchFieldEvent {
  const TextChanged();

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

final class InitField extends SearchFieldEvent {
  const InitField({required this.state});

  final FormFieldState<BaseSearchItem?> state;

  @override
  List<Object?> get props => [state.value];

  @override
  String toString() => 'Init field { text: ${state.value} }';
}

final class ClearTapped extends SearchFieldEvent {
  const ClearTapped();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'ClearTapped';
}
