import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/connection_cubit.dart';
import 'package:recommendo/l10n/l10n.dart';

class ConnectionHeader extends StatelessWidget {
  const ConnectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppConnectionCubit, AppConnectionState>(
      builder: (context, state) {
        return SliverPersistentHeader(
          pinned: true,
          delegate: ConnectionHeaderDelegate(
            hide: state == AppConnectionState.connectionOn,
          ),
        );
      },
    );
  }
}

class ConnectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  const ConnectionHeaderDelegate({required this.hide});

  final bool hide;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    if (hide) return const SizedBox.shrink();
    return Card(
      elevation: 10,
      child: SizedBox(
        height: 48,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CupertinoActivityIndicator(),
            const SizedBox(width: 16),
            Text(context.l10n.noInternetMessage),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => hide ? 0 : 48;

  @override
  double get minExtent => hide ? 0 : 48;

  @override
  bool shouldRebuild(covariant ConnectionHeaderDelegate oldDelegate) {
    return oldDelegate.hide != hide;
  }
}
