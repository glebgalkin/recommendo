import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/recommendo/view/bloc/create_recommendation_cubit.dart';
import 'package:recommendo/recommendo/view/widgets/wizard_buttons.dart';

class SocialLinksForm extends StatefulWidget {
  const SocialLinksForm({super.key});

  @override
  SocialLinksFormState createState() => SocialLinksFormState();
}

class SocialLinksFormState extends State<SocialLinksForm> {
  late final FocusNode instagramFocus;
  late final FocusNode facebookFocus;
  late final FocusNode websiteFocus;

  @override
  void initState() {
    super.initState();
    instagramFocus = FocusNode(debugLabel: 'instagram-focus');
    facebookFocus = FocusNode(debugLabel: 'facebook-focus');
    websiteFocus = FocusNode(debugLabel: 'website-focus');
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateRecommendationCubit>();

    final controllers = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GoBackButton(
          onPressed: cubit.goBack,
        ),
        GoForwardButton(
          onPressed: cubit.submitSocialLinksForm,
        ),
      ],
    );

    final children = [
      const SizedBox(height: 16),
      TextFormField(
        controller: cubit.instagram,
        focusNode: instagramFocus,
        decoration: const InputDecoration(
          label: Text('Instagram'),
        ),
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(facebookFocus),
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: cubit.facebook,
        focusNode: facebookFocus,
        decoration: const InputDecoration(
          label: Text('Facebook'),
        ),
        onFieldSubmitted: (value) =>
            FocusScope.of(context).requestFocus(websiteFocus),
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: cubit.website,
        focusNode: websiteFocus,
        decoration: const InputDecoration(
          label: Text('Web site'),
        ),
        onFieldSubmitted: (value) => cubit.submitSocialLinksForm(),
      ),
      const SizedBox(height: 32),
      controllers,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: cubit.socialLinksFormKey,
        child: Column(
          children: children,
        ),
      ),
    );
  }

  @override
  void dispose() {
    instagramFocus.dispose();
    facebookFocus.dispose();
    websiteFocus.dispose();
    super.dispose();
  }
}
