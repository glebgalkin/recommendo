import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/search_cubit.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/widget/google_city_search_field.dart';
import 'package:recommendo/l10n/l10n.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({
    super.key,
  });

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  late final SearchCubit _cubit;
  late final TextEditingController _controller;
  late final FocusNode _citySearchFocus;
  late final FocusNode _termFieldFocus;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SearchCubit>();
    _controller = TextEditingController(text: _cubit.state.term);
    _citySearchFocus = FocusNode(debugLabel: '_citySearch');
    _termFieldFocus = FocusNode(debugLabel: '_termFieldFocus');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: _cubit,
      builder: (context, state) => SliverAppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        stretch: true,
        floating: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                GoogleCitySearchField(
                  fieldLabel: l10n.searchCityLabel,
                  initialValue: state.cityResult,
                  focusNode: _citySearchFocus,
                  onChanged: (value) {
                    _cubit.updateCity(value);
                    if (value != null) {
                      FocusScope.of(context).requestFocus(_termFieldFocus);
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _controller,
                  focusNode: _termFieldFocus,
                  onChanged: (value) => _cubit.updateTerm(value),
                  decoration: InputDecoration(
                    label: Text(l10n.searchTermFieldLabel),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _citySearchFocus.dispose();
    _termFieldFocus.dispose();
    super.dispose();
  }
}
