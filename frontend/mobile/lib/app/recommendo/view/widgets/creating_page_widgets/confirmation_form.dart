import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/create_recommendation_cubit.dart';
import 'package:recommendo/app/recommendo/view/widgets/creating_page_widgets/wizard_buttons.dart';

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
          ListTile(
            leading: const Icon(Icons.location_city),
            title: Text(cubit.state.city!.preview),
          ),
          ListTile(
            leading: const Icon(Icons.title),
            title: Text(cubit.state.title),
          ),
          if (cubit.state.description.isNotEmpty)
            ListTile(
              leading: const Icon(Icons.description),
              title: Text(cubit.state.description),
            ),
          if (cubit.state.type == SocialLinkType.instagram)
            ListTile(
              leading: const Icon(Icons.center_focus_strong),
              title: Text(cubit.state.instagram),
            ),
          if (cubit.state.type == SocialLinkType.googleMaps)
            ListTile(
              leading: const Icon(Icons.map),
              title: Text(cubit.state.establishment!.preview),
            ),
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
