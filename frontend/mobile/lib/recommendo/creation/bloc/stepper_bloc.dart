// ignore_for_file: sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stepper_event.dart';
part 'stepper_state.dart';

class StepperBloc extends Bloc<StepperEvent, StepperState> {
  final int maxSteps;
  final TextEditingController cityText;
  final TextEditingController titleText;
  final TextEditingController descriptionText;
  final TextEditingController socialLinks;

  StepperBloc({
    required this.maxSteps,
    required this.cityText,
    required this.titleText,
    required this.descriptionText,
    required this.socialLinks,
  }) : super(const StepperInitial(step: 0, reverseAnimation: false)) {
    print('CREATED');
    on<StepContinue>(_onStepContinue);
    on<StepCancelled>(_onStepCancelled);
  }

  void _onStepContinue(StepContinue event, Emitter<StepperState> emit) {
    emit(state.copyWith(step: state.step + 1, reverseAnimation: false));
  }

  void _onStepCancelled(StepCancelled event, Emitter<StepperState> emit) {
    emit(state.copyWith(step: state.step - 1, reverseAnimation: true));
  }

  void dispose() {
    print('DISPOSED');
    cityText.dispose();
    titleText.dispose();
    descriptionText.dispose();
    socialLinks.dispose();
  }
}
