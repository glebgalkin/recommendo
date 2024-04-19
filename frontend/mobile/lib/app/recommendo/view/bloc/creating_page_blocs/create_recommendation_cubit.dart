import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/service/recommendations_service.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/place_result.dart';

part 'create_recommendation_state.dart';

class CreateRecommendationCubit extends Cubit<CreateRecommendationState> {
  final _basicInfoFormKey = GlobalKey<FormState>();
  final _socialLinksFormKey = GlobalKey<FormState>();

  final RecommendationService _service;

  GlobalKey<FormState> get basicInfoFormKey => _basicInfoFormKey;
  GlobalKey<FormState> get socialLinksFormKey => _socialLinksFormKey;

  CreateRecommendationCubit(this._service) : super(_initialState);

  void updateCity(PlaceResult? city) {
    if (city == null) {
      emit(state.clearCity());
    } else {
      emit(state.copyWith(city: city));
    }
  }

  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void updateDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void updateType(SocialLinkType type) {
    emit(state.copyWith(type: type));
  }

  void updateInstagram(String instagram) {
    emit(state.copyWith(instagram: instagram));
  }

  void updateEstablishment(PlaceResult? establishment) {
    if (establishment == null) {
      emit(state.clearEstablishment());
    } else {
      emit(state.copyWith(establishment: establishment));
    }
  }

  void sumbitGeneralInfoForm() {
    if (_basicInfoFormKey.currentState!.validate()) {
      emit(
        state.copyWith(step: 1, reverseAnimation: false),
      );
    }
  }

  void submitSocialLinksForm() {
    if (_socialLinksFormKey.currentState!.validate()) {
      emit(
        state.copyWith(step: 2, reverseAnimation: false),
      );
    }
  }

  void goBack() {
    if (state.step > 0) {
      emit(state.copyWith(step: state.step - 1, reverseAnimation: true));
    }
  }

  Future<void> submitRecommendation() async {
    emit(
      state.copyWith(snackbarError: '', sending: true),
    );
    final response = await _service.saveRecommendation(
      city: state.city!,
      title: state.title,
      description: state.description,
      link: state.instagram,
    );
    if (response.error != null) {
      emit(
        state.copyWith(snackbarError: response.error!.msg, sending: false),
      );
    } else if (response.result!) {
      emit(
        state.copyWith(snackbarError: '', sending: false, close: true),
      );
    }
  }

  void dispose() {
    basicInfoFormKey.currentState?.reset();
    socialLinksFormKey.currentState?.reset();
  }
}