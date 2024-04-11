import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/list_view_bloc.dart';
import 'package:recommendo/app/recommendo/view/widgets/creating_page_openner.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ListViewCubit>().state;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 300,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Sliver Example'),
            ),
          ),
          SliverInfiniteList(
            itemCount: state.values.length,
            isLoading: state.isLoading,
            hasError: state.error != null,
            onFetchData: () =>
                context.read<ListViewCubit>().add(const LoadMoreEvent()),
            separatorBuilder: (context, _) => const Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                dense: true,
                title: Text('roflotext $index'),
              );
            },
            emptyBuilder: (context) => const Center(
              child: Text('no recommendations'),
            ),
          ),
        ],
      ),
      floatingActionButton: const CreatingPageOpenner(),
    );
  }
}
