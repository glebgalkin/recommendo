import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/search_cubit.dart';

class SearchTagsHeader extends StatelessWidget {
  const SearchTagsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SearchTagsHeaderDelegate(),
    );
  }
}

class SearchTagsHeaderDelegate extends SliverPersistentHeaderDelegate {
  final array = [
    'Coffee',
    'Restaraunts',
    'Auto services',
    'Clothes',
    'Groceries',
    'Beaty',
  ];

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        scrollDirection: Axis.horizontal,
        itemCount: array.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return FilledButton.icon(
            onPressed: () {
              context.read<SearchCubit>().updateTerm(array[index]);
            },
            label: Text(array[index]),
            icon: const Icon(Icons.cabin),
          );
        },
      ),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
