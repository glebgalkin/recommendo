import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/create_recommendation_cubit.dart';
import 'package:recommendo/app/recommendo/view/widgets/wizard_buttons.dart';

class ConfirmationForm extends StatelessWidget {
  const ConfirmationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateRecommendationCubit>();
    final controllers = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GoBackButton(
          onPressed: cubit.goBack,
        ),
        BlocBuilder<CreateRecommendationCubit, CreateRecommendationState>(
          bloc: cubit,
          buildWhen: (previous, current) => previous.sending != current.sending,
          builder: (context, state) {
            return state.sending
                ? const CupertinoActivityIndicator()
                : SubmitButton(onPressed: cubit.submitRecommendation);
          },
        ),
      ],
    );
    final children = [
      const SizedBox(height: 16),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('City ${cubit.state.city!.value}'),
          Text('Title ${cubit.title.text}'),
          Text('Description ${cubit.description.text}'),
          Text('Instagram ${cubit.instagram.text}'),
          Text('Facebook ${cubit.facebook.text}'),
          Text('Web site ${cubit.website.text}'),
        ],
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
