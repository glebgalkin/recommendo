import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/create_recommendation_cubit.dart';
import 'package:recommendo/app/recommendo/view/widgets/wizard_buttons.dart';
import 'package:recommendo/common/custom_search_form_field.dart/google_establishment_search_form_field.dart';
import 'package:recommendo/l10n/l10n.dart';

class SocialLinksForm extends StatefulWidget {
  const SocialLinksForm({super.key});

  @override
  SocialLinksFormState createState() => SocialLinksFormState();
}

class SocialLinksFormState extends State<SocialLinksForm> {
  late final TextEditingController _instagram;
  late final FocusNode _dropdownFocus;
  late final FocusNode _instagramFocus;
  late final FocusNode _googleMapsFocus;

  late final CreateRecommendationCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CreateRecommendationCubit>();

    _dropdownFocus = FocusNode(debugLabel: '_dropdownFocus');
    _instagramFocus = FocusNode(debugLabel: '_instagramFocus');
    _googleMapsFocus = FocusNode(debugLabel: '_googleMapsFocus');

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

    final child =
        BlocBuilder<CreateRecommendationCubit, CreateRecommendationState>(
      buildWhen: (previous, current) => previous.type != current.type,
      builder: (context, state) {
        return Column(
          children: [
            _dropdownSelection(context, state),
            const SizedBox(height: 16),
            if (state.type == SocialLinkType.instagram)
              _instagramSearch(context, state),
            if (state.type == SocialLinkType.googleMaps)
              _googleMapsSearch(context, state),
            const SizedBox(height: 32),
            controllers,
          ],
        );
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _cubit.socialLinksFormKey,
        child: child,
      ),
    );
  }

  Widget _dropdownSelection(
    BuildContext context,
    CreateRecommendationState state,
  ) {
    return DropdownButton(
      alignment: Alignment.bottomCenter,
      value: state.type,
      isExpanded: true,
      focusNode: _dropdownFocus,
      onChanged: (value) {
        _cubit.updateType(value!);
        if (value == SocialLinkType.instagram) {
          FocusScope.of(context).requestFocus(_instagramFocus);
        } else if (value == SocialLinkType.googleMaps) {
          FocusScope.of(context).requestFocus(_googleMapsFocus);
        }
      },
      items: [
        DropdownMenuItem(
          value: SocialLinkType.instagram,
          alignment: Alignment.center,
          child: Text(context.l10n.recommendationInstagramSourceType),
        ),
        DropdownMenuItem(
          value: SocialLinkType.googleMaps,
          alignment: Alignment.center,
          child: Text(context.l10n.recommendationGoogleMapsSourceType),
        ),
      ],
    );
  }

  Widget _instagramSearch(
    BuildContext context,
    CreateRecommendationState state,
  ) {
    return TextFormField(
      controller: _instagram,
      focusNode: _instagramFocus,
      onChanged: _cubit.updateInstagram,
      decoration: InputDecoration(
        label: Text(context.l10n.recommendationInstagramFieldLabel),
      ),
      validator: (value) {
        if (state.type != SocialLinkType.instagram) {
          return null;
        }
        if (value == null || value.isEmpty) {
          return context.l10n.recommendationInstagramFieldErrorMsg;
        }
        return null;
      },
      onFieldSubmitted: (_) => _cubit.submitSocialLinksForm(),
    );
  }

  Widget _googleMapsSearch(
    BuildContext context,
    CreateRecommendationState state,
  ) {
    return GoogleEstablishmentSearchFormField(
      focusNode: _googleMapsFocus,
      initialValue: state.establishment,
      fieldLabel: context.l10n.recommendationGoogleMapsFieldLabel,
      onSaved: (newValue) => _cubit.updateEstablishment(newValue),
      validator: (value) {
        if (state.type != SocialLinkType.googleMaps) {
          return null;
        }
        if (value == null) {
          return context.l10n.recommendationGoogleMapsFieldErrorMsg;
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    _instagram.dispose();

    _dropdownFocus.dispose();
    _instagramFocus.dispose();
    _googleMapsFocus.dispose();

    super.dispose();
  }
}
