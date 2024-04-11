part of 'create_recommendation_cubit.dart';

@immutable
class CreateRecommendationState extends Equatable {
  const CreateRecommendationState({
    required this.step,
    required this.reverseAnimation,
    required this.snackbarError,
    required this.sending,
  });

  final int step;
  final bool reverseAnimation;

  final String snackbarError;
  final bool sending;

  CreateRecommendationState copyWith({
    int? step,
    bool? reverseAnimation,
    String? snackbarError,
    bool? sending,
  }) {
    return CreateRecommendationState(
      step: step ?? this.step,
      reverseAnimation: reverseAnimation ?? this.reverseAnimation,
      snackbarError: snackbarError ?? this.snackbarError,
      sending: sending ?? this.sending,
    );
  }

  @override
  List<Object?> get props => [
        step,
        reverseAnimation,
        snackbarError,
        sending,
      ];
}

final class StepperInitial extends CreateRecommendationState {
  const StepperInitial({
    required super.step,
    required super.reverseAnimation,
  }) : super(
          snackbarError: '',
          sending: false,
        );
}
