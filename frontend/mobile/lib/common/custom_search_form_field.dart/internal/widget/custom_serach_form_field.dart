import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/bloc/search_field_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/bloc/search_field_event.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/bloc/search_field_state.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_item.dart';

class CustomSearchFormField extends StatefulWidget {
  const CustomSearchFormField({
    required this.state,
    required this.fieldLabel,
    super.key,
  });

  final FormFieldState<BaseSearchItem?> state;
  final String fieldLabel;

  @override
  State<CustomSearchFormField> createState() => CustomSearchFormFieldState();
}

class CustomSearchFormFieldState extends State<CustomSearchFormField> {
  late SearchFieldBloc _searchBloc;
  final _link = LayerLink();

  @override
  void initState() {
    super.initState();
    _searchBloc = context.read<SearchFieldBloc>()
      ..add(InitField(state: widget.state));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _searchBloc.overlayController,
      overlayChildBuilder: (context) => CompositedTransformFollower(
        offset: const Offset(0, 59),
        link: _link,
        child: const _SearchBody(),
      ),
      child: CompositedTransformTarget(
        link: _link,
        child: TextField(
          controller: _searchBloc.textController,
          autocorrect: false,
          onChanged: (text) => _searchBloc.add(const TextChanged()),
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () => _searchBloc.add(const ClearTapped()),
              child: const Icon(Icons.clear),
            ),
            label: Text(widget.fieldLabel),
          ),
        ),
      ),
    );
  }
}

class _SearchBody extends StatelessWidget {
  const _SearchBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchFieldBloc, SearchFieldState>(
      builder: (context, state) {
        return switch (state) {
          SearchStateEmpty() => const SizedBox.shrink(),
          SearchStateLoading() => const CircularProgressIndicator.adaptive(),
          SearchStateError() => Text(state.error),
          SearchStateSuccess() => state.items.isEmpty
              ? const Text('No Results')
              : _SearchResults(items: state.items),
        };
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({required this.items});

  final List<BaseSearchItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) => _SearchResultItem(item: items[index]),
    );
  }
}

class _SearchResultItem extends StatelessWidget {
  const _SearchResultItem({required this.item});

  final BaseSearchItem item;

  @override
  Widget build(BuildContext context) {
    final leading = item.previewImage == null
        ? null
        : CircleAvatar(
            child: Image.network(item.previewImage!),
          );
    return ListTile(
      leading: leading,
      title: Text(item.preview),
      onTap: () => context.read<SearchFieldBloc>().add(
            ItemSelected(item: item),
          ),
    );
  }
}
