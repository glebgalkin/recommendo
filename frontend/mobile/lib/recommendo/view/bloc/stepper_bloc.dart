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
    on<MoveBack>(_onStepCancelled);
    on<SumbitGeneralInfoForm>(_onGeneralInfoForm);
    on<SubmitSocialLinks>(_onSocialLinksForm);
  }

  void _onGeneralInfoForm(
    SumbitGeneralInfoForm event,
    Emitter<StepperState> emit,
  ) {
    if (_basicInfoFormKey.currentState!.validate()) {
      _basicInfoFormKey.currentState!.save();
      emit(
        state.copyWith(
          step: 1,
          reverseAnimation: false,
          city: event.city,
          title: event.title,
          description: event.description,
        ),
      );
    } else {
      emit(
        state.copyWith(
          city: event.city,
          title: event.title,
          description: event.description,
        ),
      );
    }
  }

  void _onSocialLinksForm(
    SubmitSocialLinks event,
    Emitter<StepperState> emit,
  ) {
    if (_socialLinksFormKey.currentState!.validate()) {
      emit(
        state.copyWith(
          step: 2,
          reverseAnimation: false,
          instagram: event.instagram,
          facebook: event.facebook,
          website: event.website,
        ),
      );
    } else {
      emit(
        state.copyWith(
          instagram: event.instagram,
          facebook: event.facebook,
          website: event.website,
        ),
      );
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
