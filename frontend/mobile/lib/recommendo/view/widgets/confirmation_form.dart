import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/recommendo/view/bloc/create_recommendation_cubit.dart';
import 'package:recommendo/recommendo/view/widgets/wizard_buttons.dart';

class ConfirmationForm extends StatelessWidget {
  const ConfirmationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controllers = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GoBackButton(
          onPressed: () => context.read<CreateRecommendationCubit>().goBack(),
        ),
        BlocBuilder<CreateRecommendationCubit, CreateRecommendationState>(
          buildWhen: (previous, current) => previous.sending != current.sending,
          builder: (context, state) {
            return state.sending
                ? const CupertinoActivityIndicator()
                : SubmitButton(
                    onPressed: () => context
                        .read<CreateRecommendationCubit>()
                        .submitRecommendation(),
                  );
          },
        ),
      ],
    );
    final children = [
      const SizedBox(height: 16),
      BlocBuilder<CreateRecommendationCubit, CreateRecommendationState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('City ${state.city}'),
              Text('Title ${state.title}'),
              Text('Description ${state.description}'),
              Text('Instagram ${state.instagram}'),
              Text('Facebook ${state.facebook}'),
              Text('Web site ${state.website}'),
            ],
          );
        },
      ),
      const SizedBox(height: 32),
      controllers,
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: children,
      ),
    );
  }
}
