import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/create_recommendation_cubit.dart';
import 'package:recommendo/app/recommendo/view/widgets/creating_page_widgets/wizard_buttons.dart';
import 'package:recommendo/common/custom_search_form_field.dart/google_city_search_form_field.dart';
import 'package:recommendo/l10n/l10n.dart';

class GeneralInfoForm extends StatefulWidget {
  const GeneralInfoForm({super.key});

  @override
  State<GeneralInfoForm> createState() => GeneralInfoFormState();
}

class GeneralInfoFormState extends State<GeneralInfoForm> {
  late final TextEditingController _title;
  late final TextEditingController _description;

  late final FocusNode _cityFocus;
  late final FocusNode _titleFocus;
  late final FocusNode _descriptionFocus;

  late final CreateRecommendationCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CreateRecommendationCubit>();

    _title = TextEditingController(text: _cubit.state.title);
    _description = TextEditingController(text: _cubit.state.description);

    _cityFocus = FocusNode(debugLabel: 'city-focus');
    _titleFocus = FocusNode(debugLabel: 'title-focus');
    _descriptionFocus = FocusNode(debugLabel: 'description-focus');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final controllers = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GoForwardButton(
          onPressed: _cubit.sumbitGeneralInfoForm,
        ),
      ],
    );
    final children = [
      GoogleCitySearchFormField(
        focusNode: _cityFocus,
        fieldLabel: l10n.searchCityLabel,
        initialValue: _cubit.state.city,
        onSaved: (newValue) {
          _cubit.updateCity(newValue);
          if (newValue != null) {
            FocusScope.of(context).requestFocus(_titleFocus);
          } else {
            FocusScope.of(context).unfocus();
          }
        },
        validator: (value) {
          if (value == null) {
            return l10n.searchCityErrorMsg;
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: _title,
        focusNode: _titleFocus,
        onChanged: _cubit.updateTitle,
        decoration: InputDecoration(
          label: Text(l10n.recommendationTitleLabel),
        ),
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(_descriptionFocus),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return l10n.recommendationTitleErrorMsg;
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
        focusNode: _descriptionFocus,
        controller: _description,
        onChanged: _cubit.updateDescription,
        decoration: InputDecoration(
          label: Text(l10n.recommendationDescriptionLabel),
        ),
        onFieldSubmitted: (_) {
          _cubit.sumbitGeneralInfoForm();
        },
      ),
      const SizedBox(height: 32),
      controllers,
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _cubit.basicInfoFormKey,
        child: Column(
          children: children,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();

    _cityFocus.dispose();
    _titleFocus.dispose();
    _descriptionFocus.dispose();

    super.dispose();
  }
}