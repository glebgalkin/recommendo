import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/connection_cubit.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/search_cubit.dart';
import 'package:recommendo/common/google_search/view/google_city_search_field.dart';
import 'package:recommendo/common/custom_search_form_field.dart/widget/search_value_controller.dart';
import 'package:recommendo/l10n/l10n.dart';

class SearchBarForm extends StatefulWidget {
  const SearchBarForm({this.termFieldFocus, super.key});

  final FocusNode? termFieldFocus;

  @override
  State<SearchBarForm> createState() => SearchBarFormState();
}

class SearchBarFormState extends State<SearchBarForm> {
  late final TextEditingController _controller;
  late final FocusNode _citySearchFocus;
  late final FocusNode _termFieldFocus;
  late final SearchValueController _searchValueController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SearchCubit>();
    _controller = TextEditingController(text: cubit.state.term);
    _citySearchFocus = FocusNode(debugLabel: '_citySearch');
    _termFieldFocus =
        widget.termFieldFocus ?? FocusNode(debugLabel: '_termFieldFocus');
    _searchValueController = SearchValueController(cubit.state.cityResult);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final child = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          _citySearch(l10n),
          const SizedBox(height: 16),
          _termSearch(context, l10n),
        ],
      ),
    );

    return BlocListener<SearchCubit, SearchState>(
      listener: (context, state) {
        _searchValueController.updateSearchValue(state.cityResult);
        _controller.text = state.term;
      },
      listenWhen: (previous, current) =>
          previous.cityResult != current.cityResult ||
          previous.term != current.term,
      child: child,
    );
  }

  Widget _citySearch(AppLocalizations l10n) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return GoogleCitySearchField(
          fieldLabel: state.loadingGeoLocatoin
              ? l10n.loadingGeoLocationLabel
              : l10n.searchCityLabel,
          isOfflineSearchCallback: (context) =>
              context.read<AppConnectionCubit>().isOffline,
          initialValue: state.cityResult,
          focusNode: _citySearchFocus,
          controller: _searchValueController,
          suffixIcon: state.loadingGeoLocatoin
              ? const CupertinoActivityIndicator()
              : null,
          onChanged: (value) {
            context.read<SearchCubit>().updateCity(value);
            if (value != null) {
              FocusScope.of(context).requestFocus(_termFieldFocus);
            }
          },
        );
      },
    );
  }

  Widget _termSearch(BuildContext context, AppLocalizations l10n) {
    return TextField(
      controller: _controller,
      focusNode: _termFieldFocus,
      onTapOutside: (_) => _termFieldFocus.unfocus(),
      onChanged: (value) => context.read<SearchCubit>().updateTerm(value),
      decoration: InputDecoration(
        label: Text(l10n.searchTermFieldLabel),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _citySearchFocus.dispose();
    if (widget.termFieldFocus == null) _termFieldFocus.dispose();
    _searchValueController.dispose();
    super.dispose();
  }
}
