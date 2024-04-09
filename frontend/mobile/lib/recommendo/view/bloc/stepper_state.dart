part of 'stepper_bloc.dart';

@immutable
class StepperState {
  const StepperState({
    required this.step,
    required this.reverseAnimation,
    required this.city,
    required this.title,
    required this.description,
    required this.instagram,
    required this.facebook,
    required this.website,
  });

  final int step;
  final bool reverseAnimation;

  final String city;
  final String title;
  final String description;

  final String instagram;
  final String facebook;
  final String website;

  StepperState copyWith({
    int? step,
    bool? reverseAnimation,
    String? city,
    String? title,
    String? description,
    String? instagram,
    String? facebook,
    String? website,
  }) {
    return StepperState(
      step: step ?? this.step,
      reverseAnimation: reverseAnimation ?? this.reverseAnimation,
      city: city ?? this.city,
      title: title ?? this.title,
      description: description ?? this.description,
      instagram: instagram ?? this.instagram,
      facebook: facebook ?? this.facebook,
      website: website ?? this.website,
    );
  }
}

final class StepperInitial extends StepperState {
  const StepperInitial({
    required super.step,
    required super.reverseAnimation,
  }) : super(
          city: '',
          title: '',
          description: '',
          instagram: '',
          facebook: '',
          website: '',
        );
}
