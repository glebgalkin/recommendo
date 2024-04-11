import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/bloc/search_field_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/bloc/search_field_event.dart';
import 'package:recommendo/common/custom_search_form_field.dart/bloc/search_field_state.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/base_search_item.dart';

class CustomSearchFormField extends StatefulWidget {
  const CustomSearchFormField({required this.state, super.key});

  final FormFieldState<BaseSearchItem?> state;

  @override
  State<CustomSearchFormField> createState() => CustomSearchFormFieldState();
}

class CustomSearchFormFieldState extends State<CustomSearchFormField> {
  final _textController = TextEditingController();
  late SearchFieldBloc _githubSearchBloc;
  final _overlayController = OverlayPortalController();
  final _link = LayerLink();
  late BaseSearchItem? fieldValue;

  @override
  void initState() {
    super.initState();
    _githubSearchBloc = context.read<SearchFieldBloc>();
    fieldValue = widget.state.value;
    _textController.text = fieldValue?.preview ?? '';
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _overlayController,
      overlayChildBuilder: (context) => CompositedTransformFollower(
        offset: const Offset(0, 59),
        link: _link,
        child: _SearchBody(
          formField: widget.state,
          overlayPortalController: _overlayController,
        ),
      ),
      child: CompositedTransformTarget(
        link: _link,
        child: TextField(
          controller: _textController,
          autocorrect: false,
          onChanged: (text) {
            _githubSearchBloc.add(
              TextChanged(text: text),
            );
            if (text.isNotEmpty) {
              _overlayController.show();
            } else {
              _overlayController.hide();
            }
          },
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: _onClearTapped,
              child: const Icon(Icons.clear),
            ),
            label: const Text('City'),
          ),
        ),
      ),
    );
  }

  void _onClearTapped() {
    _textController.text = '';
    _overlayController.hide();
  }
}

class _SearchBody extends StatelessWidget {
  final FormFieldState<BaseSearchItem?> formField;
  final OverlayPortalController overlayPortalController;

  const _SearchBody({
    required this.formField,
    required this.overlayPortalController,
  });

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
              : _SearchResults(
                  items: state.items,
                  state: formField,
                  controller: overlayPortalController,
                ),
        };
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({
    required this.items,
    required this.state,
    required this.controller,
  });

  final List<BaseSearchItem> items;
  final FormFieldState<BaseSearchItem?> state;
  final OverlayPortalController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: CircleAvatar(
            child: Image.network(items[index].previewImage),
          ),
          title: Text(items[index].preview),
          onTap: () {
            state
              ..didChange(items[index])
              ..save();
            controller.hide();
          },
        );
      },
    );
  }
}
