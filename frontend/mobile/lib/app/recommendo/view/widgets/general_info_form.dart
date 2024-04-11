import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/create_recommendation_cubit.dart';
import 'package:recommendo/app/recommendo/view/widgets/wizard_buttons.dart';
import 'package:recommendo/common/custom_search_form_field.dart/github/github_search.dart';

class GeneralInfoForm extends StatefulWidget {
  const GeneralInfoForm({super.key});

  @override
  State<GeneralInfoForm> createState() => GeneralInfoFormState();
}

class GeneralInfoFormState extends State<GeneralInfoForm> {
  late final FocusNode cityFocus;
  late final FocusNode titleFocus;
  late final FocusNode descriptionFocus;
  late final CreateRecommendationCubit _cubit;

  @override
  void initState() {
    super.initState();
    cityFocus = FocusNode(debugLabel: 'city-focus');
    titleFocus = FocusNode(debugLabel: 'title-focus');
    descriptionFocus = FocusNode(debugLabel: 'description-focus');
    _cubit = context.read<CreateRecommendationCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final controllers = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GoForwardButton(
          onPressed: _cubit.sumbitGeneralInfoForm,
        ),
      ],
    );
    final children = [
      GithubSearchFormField(
        initialValue: _cubit.state.city,
        onSaved: (newValue) {
          if (newValue != null) {
            _cubit.saveCity(newValue);
            FocusScope.of(context).requestFocus(titleFocus);
          }
        },
        validator: (value) {
          if (value == null) {
            return "Can't be empty";
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: _cubit.title,
        focusNode: titleFocus,
        decoration: const InputDecoration(
          label: Text('Title'),
        ),
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(descriptionFocus);
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Can't be empty";
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
        focusNode: descriptionFocus,
        controller: _cubit.description,
        decoration: const InputDecoration(
          label: Text('Description: Optional'),
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
    cityFocus.dispose();
    titleFocus.dispose();
    descriptionFocus.dispose();
    super.dispose();
  }
}
