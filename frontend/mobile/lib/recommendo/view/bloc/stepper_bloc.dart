import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stepper_event.dart';
part 'stepper_state.dart';

class StepperBloc extends Bloc<StepperEvent, StepperState> {
  final _basicInfoFormKey = GlobalKey<FormState>();
  final _socialLinksFormKey = GlobalKey<FormState>();

  GlobalKey<FormState> get basicInfoFormKey => _basicInfoFormKey;
  GlobalKey<FormState> get socialLinksFormKey => _socialLinksFormKey;

  StepperBloc()
      : super(const StepperInitial(step: 0, reverseAnimation: false)) {
    on<MoveForward>(_onStepContinue);
    on<MoveBack>(_onStepCancelled);
  }

  void _onStepContinue(MoveForward event, Emitter<StepperState> emit) {
    if (state.step == 0 && _basicInfoFormKey.currentState!.validate()) {
      emit(state.copyWith(step: 1, reverseAnimation: true));
    }
    if (state.step == 1 && _socialLinksFormKey.currentState!.validate()) {
      emit(state.copyWith(step: 1, reverseAnimation: true));
    }
  }

  void _onStepCancelled(MoveBack event, Emitter<StepperState> emit) {
    if (state.step > 0) {
      emit(state.copyWith(step: state.step - 1, reverseAnimation: true));
    }
  }

  void dispose() {
    basicInfoFormKey.currentState?.reset();
    socialLinksFormKey.currentState?.reset();
  }
}
