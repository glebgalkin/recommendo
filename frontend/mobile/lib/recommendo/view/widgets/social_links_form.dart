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
  late final TextEditingController instagram;
  late final TextEditingController facebook;
  late final TextEditingController website;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CreateRecommendationCubit>();

    instagram = TextEditingController(text: cubit.state.instagram);
    facebook = TextEditingController(text: cubit.state.facebook);
    website = TextEditingController(text: cubit.state.website);
    instagram.addListener(() {
      cubit.updateInstagram(instagram.text);
    });
    facebook.addListener(() {
      cubit.updateInstagram(facebook.text);
    });
    website.addListener(() {
      cubit.updateInstagram(website.text);
    });
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
      TextField(
        controller: instagram,
        decoration: const InputDecoration(
          label: Text('Instagram'),
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: facebook,
        decoration: const InputDecoration(
          label: Text('Facebook'),
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: website,
        decoration: const InputDecoration(
          label: Text('Web site'),
        ),
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
    instagram.dispose();
    facebook.dispose();
    website.dispose();
    super.dispose();
  }
}
