import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/create_recommendation_cubit.dart';
import 'package:recommendo/app/recommendo/view/widgets/wizard_buttons.dart';
import 'package:recommendo/common/custom_search_form_field.dart/city_search_form_field.dart';

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
    final controllers = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GoForwardButton(
          onPressed: _cubit.sumbitGeneralInfoForm,
        ),
      ],
    );
    final children = [
      SearchCityFormField(
        initialValue: _cubit.state.city,
        onSaved: (newValue) {
          _cubit.saveCity(newValue);
          if (newValue != null) {
            FocusScope.of(context).requestFocus(_titleFocus);
          } else {
            FocusScope.of(context).unfocus();
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
        controller: _title,
        focusNode: _titleFocus,
        onChanged: _cubit.updateTitle,
        decoration: const InputDecoration(
          label: Text('Title'),
        ),
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_descriptionFocus);
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
        focusNode: _descriptionFocus,
        controller: _description,
        onChanged: _cubit.updateDescription,
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
    _title.dispose();
    _description.dispose();

    _cityFocus.dispose();
    _titleFocus.dispose();
    _descriptionFocus.dispose();

    super.dispose();
  }
}
