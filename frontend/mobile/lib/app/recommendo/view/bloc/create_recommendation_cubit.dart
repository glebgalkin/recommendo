import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/service/model/social_links_model.dart';
import 'package:recommendo/app/recommendo/service/recommendations_service.dart';

part 'create_recommendation_state.dart';

class CreateRecommendationCubit extends Cubit<CreateRecommendationState> {
  final _basicInfoFormKey = GlobalKey<FormState>();
  final _socialLinksFormKey = GlobalKey<FormState>();

  final _city = TextEditingController();
  final _title = TextEditingController();
  final _description = TextEditingController();

  final _instagram = TextEditingController();
  final _facebook = TextEditingController();
  final _website = TextEditingController();

  final RecommendationService _service;

  GlobalKey<FormState> get basicInfoFormKey => _basicInfoFormKey;
  GlobalKey<FormState> get socialLinksFormKey => _socialLinksFormKey;

  TextEditingController get city => _city;
  TextEditingController get title => _title;
  TextEditingController get description => _description;
  TextEditingController get instagram => _instagram;
  TextEditingController get facebook => _facebook;
  TextEditingController get website => _website;

  CreateRecommendationCubit(this._service)
      : super(const StepperInitial(step: 0, reverseAnimation: false));

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
    final links = SocialLinks(
      instagram: instagram.text,
      facebook: facebook.text,
      webSite: website.text,
    );
    final response = await _service.saveRecommendation(
      city: city.text,
      title: title.text,
      description: description.text,
      links: links,
    );
    if (response.error != null) {
      emit(
        state.copyWith(snackbarError: response.error!.msg, sending: false),
      );
    } else if (response.result!) {
      emit(
        state.copyWith(snackbarError: '', sending: false),
      );
    }
  }

  void dispose() {
    basicInfoFormKey.currentState?.reset();
    socialLinksFormKey.currentState?.reset();
    city.dispose();
    title.dispose();
    description.dispose();
    instagram.dispose();
    facebook.dispose();
    website.dispose();
  }
}
