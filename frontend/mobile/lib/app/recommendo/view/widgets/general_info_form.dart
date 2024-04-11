import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_places_autocomplete_widgets/address_autocomplete_widgets.dart';
import 'package:recommendo/app/recommendo/view/bloc/create_recommendation_cubit.dart';
import 'package:recommendo/app/recommendo/view/widgets/wizard_buttons.dart';

class GeneralInfoForm extends StatefulWidget {
  const GeneralInfoForm({super.key});

  @override
  State<GeneralInfoForm> createState() => GeneralInfoFormState();
}

class GeneralInfoFormState extends State<GeneralInfoForm> {
  late final FocusNode cityFocus;
  late final FocusNode titleFocus;
  late final FocusNode descriptionFocus;

  @override
  void initState() {
    super.initState();
    cityFocus = FocusNode(debugLabel: 'city-focus');
    titleFocus = FocusNode(debugLabel: 'title-focus');
    descriptionFocus = FocusNode(debugLabel: 'description-focus');
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateRecommendationCubit>();
    final controllers = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GoForwardButton(
          onPressed: cubit.sumbitGeneralInfoForm,
        ),
      ],
    );
    final children = [
      AddressAutocompleteTextFormField(
        mapsApiKey: const String.fromEnvironment('MAPS_API_KEY'),
        controller: cubit.city,
        focusNode: cityFocus,
        decoration: const InputDecoration(
          label: Text('City'),
        ),
        onSuggestionClick: (place) {
          cubit.city.text =
              '${place.city}, ${place.stateShort}, ${place.country}';
          FocusScope.of(context).requestFocus(titleFocus);
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
        controller: cubit.title,
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
        controller: cubit.description,
        decoration: const InputDecoration(
          label: Text('Description: Optional'),
        ),
        onFieldSubmitted: (_) {
          cubit.sumbitGeneralInfoForm();
        },
      ),
      const SizedBox(height: 32),
      controllers,
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: cubit.basicInfoFormKey,
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
