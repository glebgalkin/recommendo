part of 'create_recommendation_cubit.dart';

@immutable
class CreateRecommendationState extends Equatable {
  const CreateRecommendationState({
    required this.step,
    required this.reverseAnimation,
    required this.city,
    required this.title,
    required this.description,
    required this.instagram,
    required this.facebook,
    required this.website,
    required this.snackbarError,
    required this.sending,
  });

  final int step;
  final bool reverseAnimation;

  final String city;
  final String title;
  final String description;

  final String instagram;
  final String facebook;
  final String website;

  final String snackbarError;
  final bool sending;

  CreateRecommendationState copyWith({
    int? step,
    bool? reverseAnimation,
    String? city,
    String? title,
    String? description,
    String? instagram,
    String? facebook,
    String? website,
    String? snackbarError,
    bool? sending,
  }) {
    return CreateRecommendationState(
      step: step ?? this.step,
      reverseAnimation: reverseAnimation ?? this.reverseAnimation,
      city: city ?? this.city,
      title: title ?? this.title,
      description: description ?? this.description,
      instagram: instagram ?? this.instagram,
      facebook: facebook ?? this.facebook,
      website: website ?? this.website,
      snackbarError: snackbarError ?? this.snackbarError,
      sending: sending ?? this.sending,
    );
  }

  @override
  List<Object?> get props => [
        step,
        city,
        title,
        description,
        instagram,
        facebook,
        website,
        snackbarError,
        sending,
      ];
}

final class StepperInitial extends CreateRecommendationState {
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
          snackbarError: '',
          sending: false,
        );
}
