import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recommendo/app/recommendo/view/bloc/creating_page_blocs/create_recommendation_cubit.dart';
import 'package:recommendo/app/recommendo/view/widgets/creating_page_widgets/confirmation_step.dart';
import 'package:recommendo/app/recommendo/view/widgets/creating_page_widgets/general_info_step.dart';
import 'package:recommendo/app/recommendo/view/widgets/creating_page_widgets/social_links_step.dart';
import 'package:recommendo/common/snack_bar_extensions.dart';
import 'package:recommendo/l10n/l10n.dart';

class RecommendationCreationPage extends StatelessWidget {
  const RecommendationCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final child =
        BlocConsumer<CreateRecommendationCubit, CreateRecommendationState>(
      listener: (context, state) {
        if (state.close) {
          context.pop();
          return;
        }
        context.snackBarErrorMsg(state.snackbarError);
      },
      listenWhen: (previous, current) =>
          (current.snackbarError.isNotEmpty &&
              previous.snackbarError != current.snackbarError) ||
          current.close,
      buildWhen: (previous, current) => previous.step != current.step,
      builder: (context, state) {
        return PageTransitionSwitcher(
          reverse: state.reverseAnimation,
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return SharedAxisTransition(
              transitionType: SharedAxisTransitionType.horizontal,
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: switch (state.step) {
            0 => const GeneralInfoStep(),
            1 => const SocialLinksStep(),
            2 => const ConfirmationStep(),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );

    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.creationPageAppBarTitle),
        ),
        body: child,
      ),
    );
  }
}