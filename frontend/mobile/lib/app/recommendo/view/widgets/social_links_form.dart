import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/create_recommendation_cubit.dart';
import 'package:recommendo/app/recommendo/view/widgets/wizard_buttons.dart';

class SocialLinksForm extends StatefulWidget {
  const SocialLinksForm({super.key});

  @override
  SocialLinksFormState createState() => SocialLinksFormState();
}

class SocialLinksFormState extends State<SocialLinksForm> {
  late final TextEditingController _instagram;
  late final TextEditingController _facebook;
  late final TextEditingController _website;

  late final FocusNode _instagramFocus;
  late final FocusNode _facebookFocus;
  late final FocusNode _websiteFocus;

  late final CreateRecommendationCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CreateRecommendationCubit>();

    _instagram = TextEditingController(text: _cubit.state.instagram);
    _facebook = TextEditingController(text: _cubit.state.facebook);
    _website = TextEditingController(text: _cubit.state.website);

    _instagramFocus = FocusNode(debugLabel: 'instagram-focus');
    _facebookFocus = FocusNode(debugLabel: 'facebook-focus');
    _websiteFocus = FocusNode(debugLabel: 'website-focus');
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
      const SizedBox(height: 16),
      TextFormField(
        controller: _instagram,
        onChanged: _cubit.updateInstagram,
        focusNode: _instagramFocus,
        decoration: const InputDecoration(
          label: Text('Instagram'),
        ),
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(_facebookFocus),
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: _facebook,
        onChanged: _cubit.updateFacebook,
        focusNode: _facebookFocus,
        decoration: const InputDecoration(
          label: Text('Facebook'),
        ),
        onFieldSubmitted: (value) =>
            FocusScope.of(context).requestFocus(_websiteFocus),
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: _website,
        onChanged: _cubit.updateWebsite,
        focusNode: _websiteFocus,
        decoration: const InputDecoration(
          label: Text('Web site'),
        ),
        onFieldSubmitted: (value) => _cubit.submitSocialLinksForm(),
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
    _facebook.dispose();
    _website.dispose();

    _instagramFocus.dispose();
    _facebookFocus.dispose();
    _websiteFocus.dispose();
    super.dispose();
  }
}
