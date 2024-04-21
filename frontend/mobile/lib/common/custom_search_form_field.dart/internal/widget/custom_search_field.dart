import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/bloc/search_field_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_item.dart';
import 'package:recommendo/l10n/l10n.dart';

class CustomSearchField extends StatefulWidget {
  const CustomSearchField({
    required this.fieldLabel,
    this.onChanged,
    this.initialValue,
    this.focusNode,
    this.inputDecoration,
    super.key,
  });

  final BaseSearchItem? initialValue;
  final FocusNode? focusNode;
  final String fieldLabel;
  final InputDecoration? inputDecoration;
  final ValueChanged<BaseSearchItem?>? onChanged;

  @override
  CustomSearchFieldState createState() => CustomSearchFieldState();
}

class CustomSearchFieldState extends State<CustomSearchField> {
  late final SearchFieldBloc _bloc;
  late final LayerLink _link;
  late final OverlayPortalController _overlayPortalController;
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
    _link = LayerLink();
    _overlayPortalController = OverlayPortalController();
    _textEditingController =
        TextEditingController(text: widget.initialValue?.preview);
    widget.focusNode?.addListener(() {
      if (widget.focusNode!.hasFocus) {
        _bloc.add(const SearchStarted());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchFieldBloc, SearchFieldState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state.showOverlay) {
          FocusScope.of(context).requestFocus(widget.focusNode);
          _overlayPortalController.show();
        } else {
          _overlayPortalController.hide();
          _textEditingController.text = state.value?.preview ?? '';
          widget.onChanged?.call(state.value);
        }
      },
      listenWhen: (previous, current) =>
          previous.showOverlay != current.showOverlay ||
          previous.value != current.value,
      child: OverlayPortal(
        controller: _overlayPortalController,
        overlayChildBuilder: (context) => Positioned(
          // TODO(Konyaka1): Figure out how to make it better
          width: _link.leaderSize!.width,
          child: CompositedTransformFollower(
            targetAnchor: Alignment.bottomLeft,
            link: _link,
            child: TextFieldTapRegion(
              child: BlocProvider.value(
                value: _bloc,
                child: const _SearchBody(),
              ),
              onTapOutside: (_) {
                _bloc.add(const TapppedOutside());
                widget.focusNode?.unfocus();
              },
            ),
          ),
        ),
        child: CompositedTransformTarget(
          link: _link,
          child: BlocBuilder<SearchFieldBloc, SearchFieldState>(
            bloc: _bloc,
            buildWhen: (previous, current) => previous.value != current.value,
            builder: (context, state) {
              final effectiveDecoration = widget.inputDecoration ??
                  InputDecoration(
                    label: Text(widget.fieldLabel),
                    suffixIcon: _suffixIcon(state.value),
                  );
              return TextField(
                controller: _textEditingController,
                focusNode: widget.focusNode,
                readOnly: state.value != null,
                onTapOutside: (_) {
                  _bloc.add(const TapppedOutside());
                  widget.focusNode?.unfocus();
                },
                decoration: effectiveDecoration.copyWith(
                  label: Text(widget.fieldLabel),
                  suffixIcon: _suffixIcon(state.value),
                ),
                onChanged: (value) => _bloc.add(TextChanged(value)),
              );
            },
          ),
        ),
      ),
    );
  }

  GestureDetector _suffixIcon(BaseSearchItem? value) {
    return GestureDetector(
      onTap: () => value != null
          ? _bloc.add(const ClearTapped())
          : _bloc.add(const SearchStarted()),
      child: value != null ? const Icon(Icons.clear) : const Icon(Icons.search),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}

class _SearchBody extends StatelessWidget {
  const _SearchBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          // TODO(Konyaka1): fixme
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: BlocBuilder<SearchFieldBloc, SearchFieldState>(
        builder: (context, state) {
          return switch (state) {
            SearchFieldInitial() => const SizedBox.shrink(),
            SearchStateLoading() =>
              const ListTile(title: CupertinoActivityIndicator()),
            SearchStateError() =>
              ListTile(title: Text(state.error!.localizedError(context.l10n))),
            SearchStateSuccess() => _SearchResults(state: state),
          };
        },
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({required this.state});

  final SearchStateSuccess state;

  @override
  Widget build(BuildContext context) {
    if (state.searchList.isEmpty) {
      final text = state.previousList
          ? context.l10n.noPreviousSearches
          : context.l10n.noSearchResult;
      return ListTile(
        title: Text(text),
      );
    }
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.searchList.length,
      itemBuilder: (context, index) => _SearchResultItem(
        item: state.searchList[index],
      ),
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
      onTap: () =>
          context.read<SearchFieldBloc>().add(ItemSelected(item: item)),
    );
  }
}
