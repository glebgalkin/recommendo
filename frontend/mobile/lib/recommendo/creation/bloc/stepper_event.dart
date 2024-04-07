// ignore_for_file: sort_constructors_first

part of 'stepper_bloc.dart';

@immutable
sealed class StepperEvent {
  const StepperEvent();
}

class StepTapped extends StepperEvent {
  final int step;

  const StepTapped(this.step);

  @override
  String toString() => 'StepTapped { step: $step }';
}

class StepCancelled extends StepperEvent {
  @override
  String toString() => 'StepCancelled';
}

class StepContinue extends StepperEvent {
  @override
  String toString() => 'StepContinue';
}
