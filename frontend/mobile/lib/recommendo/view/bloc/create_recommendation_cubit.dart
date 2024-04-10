import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/recommendo/service/model/social_links_model.dart';
import 'package:recommendo/recommendo/service/recommendations_service.dart';

part 'create_recommendation_state.dart';

class CreateRecommendationCubit extends Cubit<CreateRecommendationState> {
  final _basicInfoFormKey = GlobalKey<FormState>();
  final _socialLinksFormKey = GlobalKey<FormState>();
  final RecommendationService _service;

  GlobalKey<FormState> get basicInfoFormKey => _basicInfoFormKey;
  GlobalKey<FormState> get socialLinksFormKey => _socialLinksFormKey;

  CreateRecommendationCubit(this._service)
      : super(const StepperInitial(step: 0, reverseAnimation: false));

  void updateCity(String city) {
    emit(state.copyWith(city: city));
  }

  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void updateDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void updateInstagram(String instagram) {
    emit(state.copyWith(instagram: instagram));
  }

  void updateFacebook(String facebook) {
    emit(state.copyWith(facebook: facebook));
  }

  void updateWebsite(String website) {
    emit(state.copyWith(website: website));
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
    } else {
      emit(
        state.copyWith(snackbarError: 'At least one should be specified'),
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
    final links = SocialLinks(
      instagram: state.instagram,
      facebook: state.facebook,
      webSite: state.website,
    );
    final response = await _service.saveRecommendation(
      city: state.city,
      title: state.title,
      description: state.description,
      links: links,
    );
    if (response.error != null) {
      emit(
        state.copyWith(snackbarError: response.error!.msg, sending: false),
      );
    } else if (response.result!) {
      emit(
        state.copyWith(
          snackbarError: '',
          sending: false,
          city: '',
          title: '',
          description: '',
          instagram: '',
          facebook: '',
          website: '',
        ),
      );
    }
  }

  void dispose() {
    basicInfoFormKey.currentState?.reset();
    socialLinksFormKey.currentState?.reset();
  }
}