import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/create_recommendation_cubit.dart';
import 'package:recommendo/app/recommendo/view/widgets/wizard_buttons.dart';
import 'package:recommendo/l10n/l10n.dart';

class SocialLinksForm extends StatefulWidget {
  const SocialLinksForm({super.key});

  @override
  SocialLinksFormState createState() => SocialLinksFormState();
}

class SocialLinksFormState extends State<SocialLinksForm> {
  late final TextEditingController _instagram;

  late final CreateRecommendationCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CreateRecommendationCubit>();

    _instagram = TextEditingController(text: _cubit.state.instagram);
  }

  @override
  Widget build(BuildContext context) {
    final controllers = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GoBackButton(
          onPressed: _cubit.goBack,
        ),
        GoForwardButton(
          onPressed: _cubit.submitSocialLinksForm,
        ),
      ],
    );

    final children = [
      TextFormField(
        controller: _instagram,
        onChanged: _cubit.updateInstagram,
        decoration: InputDecoration(
          label: Text(context.l10n.recommendationSocialLink),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return context.l10n.recommendationSocialLinkErrorMsg;
          }
          return null;
        },
        onFieldSubmitted: (_) => _cubit.submitSocialLinksForm(),
      ),
      const SizedBox(height: 32),
      controllers,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _cubit.socialLinksFormKey,
        child: Column(
          children: children,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _instagram.dispose();

    super.dispose();
  }
}
