import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stepper_event.dart';
part 'stepper_state.dart';

class StepperBloc extends Bloc<StepperEvent, StepperState> {
  StepperBloc()
      : super(const StepperInitial(step: 0, reverseAnimation: false)) {
    on<MoveForward>(_onStepContinue);
    on<MoveBack>(_onStepCancelled);
  }

  void _onStepContinue(MoveForward event, Emitter<StepperState> emit) {
    if (state.step < 2) {
      emit(state.copyWith(step: state.step + 1, reverseAnimation: false));
    }
  }

  void _onStepCancelled(MoveBack event, Emitter<StepperState> emit) {
    if (state.step > 0) {
      emit(state.copyWith(step: state.step - 1, reverseAnimation: true));
    }
  }

  void dispose() {}
}
