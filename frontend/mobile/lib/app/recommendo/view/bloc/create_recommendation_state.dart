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
    required this.close,
  });

  final int step;
  final bool reverseAnimation;

  final CityResult? city;
  final String title;
  final String description;
  final String instagram;
  final String facebook;
  final String website;

  final String snackbarError;
  final bool sending;

  final bool close;

  CreateRecommendationState copyWith({
    int? step,
    bool? reverseAnimation,
    CityResult? city,
    String? title,
    String? description,
    String? instagram,
    String? facebook,
    String? website,
    String? snackbarError,
    bool? sending,
    bool? close,
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
      close: close ?? this.close,
    );
  }

  CreateRecommendationState clearCity() {
    return CreateRecommendationState(
      step: step,
      reverseAnimation: reverseAnimation,
      city: null,
      title: title,
      description: description,
      instagram: instagram,
      facebook: facebook,
      website: website,
      snackbarError: snackbarError,
      sending: sending,
      close: close,
    );
  }

  @override
  List<Object?> get props => [
        step,
        reverseAnimation,
        city,
        title,
        description,
        instagram,
        facebook,
        website,
        snackbarError,
        sending,
        close,
      ];
}

const _initialState = CreateRecommendationState(
  step: 0,
  reverseAnimation: false,
  city: null,
  title: '',
  description: '',
  instagram: '',
  facebook: '',
  website: '',
  snackbarError: '',
  sending: false,
  close: false,
);
