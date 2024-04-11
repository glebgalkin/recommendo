part of 'create_recommendation_cubit.dart';

@immutable
class CreateRecommendationState extends Equatable {
  const CreateRecommendationState({
    required this.step,
    required this.reverseAnimation,
    required this.city,
    required this.snackbarError,
    required this.sending,
  });

  final int step;
  final bool reverseAnimation;

  final GithubSearchResultItem? city;

  final String snackbarError;
  final bool sending;

  CreateRecommendationState copyWith({
    int? step,
    bool? reverseAnimation,
    GithubSearchResultItem? city,
    String? snackbarError,
    bool? sending,
  }) {
    return CreateRecommendationState(
      step: step ?? this.step,
      reverseAnimation: reverseAnimation ?? this.reverseAnimation,
      city: city ?? this.city,
      snackbarError: snackbarError ?? this.snackbarError,
      sending: sending ?? this.sending,
    );
  }

  @override
  List<Object?> get props => [
        step,
        reverseAnimation,
        city,
        snackbarError,
        sending,
      ];
}

final class StepperInitial extends CreateRecommendationState {
  const StepperInitial({
    required super.step,
    required super.reverseAnimation,
  }) : super(
          city: null,
          snackbarError: '',
          sending: false,
        );
}
