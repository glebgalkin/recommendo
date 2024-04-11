import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/bloc/search_field_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/bloc/search_field_event.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/bloc/search_field_state.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_item.dart';

class SearchFormField extends StatefulWidget {
  const SearchFormField({
    required this.state,
    required this.fieldLabel,
    super.key,
  });

  final FormFieldState<BaseSearchItem?> state;
  final String fieldLabel;

  @override
  State<SearchFormField> createState() => SearchFormFieldState();
}

class SearchFormFieldState extends State<SearchFormField> {
  late SearchFieldBloc _searchBloc;
  final _link = LayerLink();

  @override
  void initState() {
    super.initState();
    _searchBloc = context.read<SearchFieldBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _searchBloc.overlayController,
      overlayChildBuilder: (context) => Positioned(
        // looks like TABARNAK
        width: _link.leaderSize!.width,
        child: CompositedTransformFollower(
          targetAnchor: Alignment.bottomLeft,
          link: _link,
          child: TextFieldTapRegion(
            child: const _SearchBody(),
            onTapOutside: (_) => _searchBloc.add(const TapppedOutside()),
          ),
        ),
      ),
      child: CompositedTransformTarget(
        link: _link,
        child: TextField(
          readOnly: _searchBloc.formField.isValid,
          controller: _searchBloc.textController,
          autocorrect: false,
          onTapOutside: (_) => _searchBloc.add(const TapppedOutside()),
          onChanged: (_) => _searchBloc.add(const TextChanged()),
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () => _searchBloc.add(const ClearTapped()),
              child: _searchBloc.formField.isValid
                  ? const Icon(Icons.clear)
                  : const Icon(Icons.search),
            ),
            errorText: _searchBloc.formField.errorText,
            label: Text(widget.fieldLabel),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _SearchBody extends StatelessWidget {
  const _SearchBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: BlocBuilder<SearchFieldBloc, SearchFieldState>(
        builder: (context, state) {
          return switch (state) {
            SearchStateEmpty() => const SizedBox.shrink(),
            SearchStateLoading() => const CupertinoActivityIndicator(),
            SearchStateError() => Text(state.error),
            SearchStateSuccess() => state.items.isEmpty
                ? const Text('No Results')
                : _SearchResults(items: state.items),
          };
        },
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({required this.items});

  final List<BaseSearchItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
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
