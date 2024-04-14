import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/search_cubit.dart';
import 'package:recommendo/common/custom_search_form_field.dart/city_search_form_field.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      stretch: true,
      floating: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SearchCityFormField(
                onSaved: (value) {
                  context.read<SearchCubit>().updateCity(value);
                },
                validator: (value) {
                  if (value == null) {
                    return "Can't be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) =>
                    context.read<SearchCubit>().updateTerm(value),
                decoration: const InputDecoration(
                  filled: true,
                  label: Text('Term'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
