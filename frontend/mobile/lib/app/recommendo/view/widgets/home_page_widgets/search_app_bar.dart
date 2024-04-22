import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/search_cubit.dart';
import 'package:recommendo/common/custom_search_form_field.dart/google_city_search_field.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/bloc/search_field_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/widget/search_value_controller.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/google_autocompletion_service.dart';
import 'package:recommendo/l10n/l10n.dart';
import 'package:recommendo/service_locator/service_locator.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({
    super.key,
  });

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  late final TextEditingController _controller;
  late final FocusNode _citySearchFocus;
  late final FocusNode _termFieldFocus;
  late final SearchValueController _searchValueController;
  late final SearchFieldBloc _searchFieldBloc;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SearchCubit>();
    _searchFieldBloc = SearchFieldBloc(
      getIt<GoogleAutocompletionService>(
        instanceName: autoCompleteCity,
      ),
      cubit.state.cityResult,
    );
    _controller = TextEditingController(text: cubit.state.term);
    _citySearchFocus = FocusNode(debugLabel: '_citySearch');
    _termFieldFocus = FocusNode(debugLabel: '_termFieldFocus');
    _searchValueController = SearchValueController(cubit.state.cityResult);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        _searchValueController.updateSearchValue(state.cityResult);
        if (state.cityResult != null) {
          _searchFieldBloc.add(ItemSelected(item: state.cityResult!));
        }
      },
      listenWhen: (previous, current) =>
          previous.cityResult != current.cityResult,
      builder: (context, state) {
        final child = Column(
          children: [
            GoogleCitySearchField(
              fieldLabel: state.loadingGeoLocatoin
                  ? l10n.loadingGeoLocationLabel
                  : l10n.searchCityLabel,
              initialValue: state.cityResult,
              focusNode: _citySearchFocus,
              bloc: _searchFieldBloc,
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
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              focusNode: _termFieldFocus,
              onTapOutside: (_) => _termFieldFocus.unfocus(),
              onChanged: (value) =>
                  context.read<SearchCubit>().updateTerm(value),
              decoration: InputDecoration(
                label: Text(l10n.searchTermFieldLabel),
              ),
            ),
          ],
        );
        return SliverAppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          stretch: true,
          floating: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(130),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: child,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _citySearchFocus.dispose();
    _termFieldFocus.dispose();
    _searchValueController.dispose();
    _searchFieldBloc.close();
    super.dispose();
  }
}
