import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:sanalira_test/cores/firebase_services/authentication_service.dart';
import 'package:sanalira_test/cores/firebase_services/firestore_service.dart';
import 'package:sanalira_test/models/firebase_models/user_local.dart';
part 'register_page_view_model.g.dart';

class RegisterPageViewModel = _RegisterPageViewModelBase
    with _$RegisterPageViewModel;

abstract class _RegisterPageViewModelBase with Store {
  @observable
  bool isLoadingLogin = false;

  loginButtonClicked(
    GlobalKey<FormState> formKey,
    String? email,
    String? name,
    String? surname,
    String? phoneNumber,
    bool isChecked,
  ) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      isLoadingLogin = true;
      AuthenticationService _authenticationService = AuthenticationService();

      if (!isChecked) {
        isLoadingLogin = false;
        return;
      }

      try {
        UserLocal? user = await _authenticationService.createUserWithEmail(
            email!, "Enes0311");
        if (user != null) {
          await FirestoreService().createUser(
            id: user.id,
            email: user.email,
            name: name,
            surname: surname,
            phoneNumber: phoneNumber,
          );
        }
        isLoadingLogin = false;
      } catch (ex) {
        isLoadingLogin = false;
      }
    }
  }
}
