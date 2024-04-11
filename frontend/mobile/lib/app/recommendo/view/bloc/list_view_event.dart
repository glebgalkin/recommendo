part of 'list_view_bloc.dart';

sealed class ListViewEvent {
  const ListViewEvent();
}

class LoadMoreEvent extends ListViewEvent {
  const LoadMoreEvent();
}
