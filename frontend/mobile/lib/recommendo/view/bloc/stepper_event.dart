part of 'stepper_bloc.dart';

@immutable
sealed class StepperEvent {
  const StepperEvent();
}

class GoBack extends StepperEvent {
  const GoBack();
}

class SumbitGeneralInfoForm extends StepperEvent {
  final String city;
  final String title;
  final String description;

  const SumbitGeneralInfoForm({
    required this.city,
    required this.title,
    required this.description,
  });
}

class SubmitSocialLinks extends StepperEvent {
  final String instagram;
  final String facebook;
  final String website;

  const SubmitSocialLinks({
    required this.instagram,
    required this.facebook,
    required this.website,
  });
}

class SubmitRecommendation extends StepperEvent {
  const SubmitRecommendation();
}
