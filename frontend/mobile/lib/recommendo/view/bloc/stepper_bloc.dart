import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/recommendo/service/model/social_links_model.dart';
import 'package:recommendo/recommendo/service/recommendations_service.dart';

part 'stepper_event.dart';
part 'stepper_state.dart';

class StepperBloc extends Bloc<StepperEvent, StepperState> {
  final _basicInfoFormKey = GlobalKey<FormState>();
  final _socialLinksFormKey = GlobalKey<FormState>();
  final RecommendationService _service;

  GlobalKey<FormState> get basicInfoFormKey => _basicInfoFormKey;
  GlobalKey<FormState> get socialLinksFormKey => _socialLinksFormKey;

  StepperBloc(this._service)
      : super(const StepperInitial(step: 0, reverseAnimation: false)) {
    on<GoBack>(_onStepCancelled);
    on<SumbitGeneralInfoForm>(_onGeneralInfoForm);
    on<SubmitSocialLinks>(_onSocialLinksForm);
    on<SubmitRecommendation>(_onSubmitRecommendation);
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

  void _onStepCancelled(GoBack event, Emitter<StepperState> emit) {
    if (state.step > 0) {
      emit(state.copyWith(step: state.step - 1, reverseAnimation: true));
    }
  }

  Future<void> _onSubmitRecommendation(
    SubmitRecommendation event,
    Emitter<StepperState> emit,
  ) async {
    final links = SocialLinks(
      instagram: state.instagram,
      facebook: state.facebook,
      webSite: state.website,
    );
    debugPrint('SENDING');
    final response = await _service.saveRecommendation(
      city: state.city,
      title: state.title,
      description: state.description,
      links: links,
    );
    if (response.error != null) {
    } else if (response.result!) {}
  }

  void dispose() {
    basicInfoFormKey.currentState?.reset();
    socialLinksFormKey.currentState?.reset();
  }
}
