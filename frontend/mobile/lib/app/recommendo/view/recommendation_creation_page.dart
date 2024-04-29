import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recommendo/app/recommendo/view/bloc/creating_page_blocs/create_recommendation_cubit.dart';
import 'package:recommendo/app/recommendo/view/widgets/creating_page_widgets/clean_form_dialog.dart';
import 'package:recommendo/app/recommendo/view/widgets/creating_page_widgets/confirmation_step.dart';
import 'package:recommendo/app/recommendo/view/widgets/creating_page_widgets/general_info_step.dart';
import 'package:recommendo/app/recommendo/view/widgets/creating_page_widgets/social_links_step.dart';
import 'package:recommendo/common/localized_error_text.dart';
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
          context.pop(true);
          return;
        }
        final errorMsg = localizedErrorText(state.snackbarError, context.l10n);
        context.snackBarErrorMsg(errorMsg);
      },
      listenWhen: (previous, current) =>
          current.snackbarError != null || current.close,
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
            0 => const GeneralInfoStep(key: ValueKey(0)),
            1 => const SocialLinksStep(key: ValueKey(1)),
            2 => const ConfirmationStep(key: ValueKey(2)),
            _ => const GeneralInfoStep(key: ValueKey(0)),
          },
        );
      },
    );

    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.creationPageAppBarTitle),
          actions: [
            IconButton(
              onPressed: () async {
                final doClear = await showModal<bool>(
                  context: context,
                  builder: (_) => const CleanFormDialog(),
                );
                if (doClear != null && doClear == true) {
                  if (context.mounted) {
                    context.read<CreateRecommendationCubit>().clearForm();
                  }
                }
              },
              icon: const Icon(Icons.backspace_outlined),
            ),
          ],
        ),
        body: child,
      ),
    );
  }
}
