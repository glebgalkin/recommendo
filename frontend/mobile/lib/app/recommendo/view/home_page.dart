import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/search_cubit.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/app_bar/search_tags_header.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/app_menu_fab.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/recommendations_list.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/search_app_bar.dart';
import 'package:recommendo/common/localized_error_text.dart';
import 'package:recommendo/common/snack_bar_extensions.dart';
import 'package:recommendo/l10n/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return BlocListener<SearchCubit, SearchState>(
              listener: (context, state) {
                final msg = localizedErrorText(state.errorCode, context.l10n);
                context.snackBarErrorMsg(msg);
              },
              listenWhen: (previous, current) => current.errorCode != null,
              child: SafeArea(
                bottom: false,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: const CustomScrollView(
                      slivers: [
                        SearchAppBar(),
                        SearchTagsHeader(),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          sliver: RecommendationsList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: const AppMenuFab(),
      ),
    );
  }
}
