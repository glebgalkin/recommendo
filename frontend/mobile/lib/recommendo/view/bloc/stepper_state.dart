part of 'stepper_bloc.dart';

@immutable
class StepperState {
  const StepperState({
    required this.step,
    required this.reverseAnimation,
  });

  final int step;
  final bool reverseAnimation;

  StepperState copyWith({int? step, bool? reverseAnimation}) {
    return StepperState(
      step: step ?? this.step,
      reverseAnimation: reverseAnimation ?? this.reverseAnimation,
    );
  }
}

final class StepperInitial extends StepperState {
  const StepperInitial({
    required super.step,
    required super.reverseAnimation,
  });
}
