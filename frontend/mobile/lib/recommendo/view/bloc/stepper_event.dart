// ignore_for_file: sort_constructors_first

part of 'stepper_bloc.dart';

@immutable
sealed class StepperEvent {
  const StepperEvent();
}

class MoveBack extends StepperEvent {}

class MoveForward extends StepperEvent {}
