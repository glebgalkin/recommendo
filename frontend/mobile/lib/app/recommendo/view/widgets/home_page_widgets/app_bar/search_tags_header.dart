import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/search_cubit.dart';
import 'package:recommendo/l10n/l10n.dart';

class SearchTagsHeader extends StatelessWidget {
  const SearchTagsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final chips = <(String, Icon)>[
      (l10n.searchTagCafes, const Icon(Icons.local_cafe_outlined)),
      (l10n.searchTagGroceries, const Icon(Icons.local_grocery_store_outlined)),
      (l10n.searchTagClothes, const Icon(Icons.checkroom_outlined)),
      (l10n.searchTagAutoServcies, const Icon(Icons.directions_car_outlined)),
      (l10n.searchTagHotels, const Icon(Icons.hotel_outlined)),
      (l10n.searchTagRestaraunts, const Icon(Icons.restaurant_outlined)),
      (l10n.searchTagBeauty, const Icon(Icons.auto_awesome_outlined)),
    ];

    return SliverPersistentHeader(
      pinned: true,
      delegate: SearchTagsHeaderDelegate(searchChips: chips),
    );
  }
}

class SearchTagsHeaderDelegate extends SliverPersistentHeaderDelegate {
  const SearchTagsHeaderDelegate({required this.searchChips});

  final List<(String, Icon)> searchChips;

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
        itemCount: searchChips.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final chip = searchChips[index];
          return ActionChip(
            onPressed: () => context.read<SearchCubit>().updateTerm(chip.$1),
            label: Text(chip.$1),
            avatar: chip.$2,
            elevation: 4,
            iconTheme: const IconThemeData(size: 20),
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
