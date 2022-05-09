import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth/app/domain/inputs/sign_up.dart';
import 'package:flutter_firebase_auth/app/domain/repositories/sign_up_repository.dart';
import 'package:flutter_firebase_auth/app/domain/responses/sign-up-response.dart';
import 'package:flutter_firebase_auth/app/ui/pages/register/controller/register_state.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class RegisterController extends StateNotifier<RegisterState> {
  RegisterController() : super(RegisterState.InitialState);
  final _signUpRepository = Get.i.find<SignUpRepository>();
  GlobalKey<FormState> formKey = GlobalKey();
  Future<SignUpResponse> submit() {
    return _signUpRepository.register(SignUpData(
      name: state.name,
      lastname: state.lastname,
      email: state.email,
      password: state.vPassword,
    ));
  }

  void onNameChanged(String text) {
    state = state.copyWith(name: text);
  }

  void onLastNameChanged(String text) {
    state = state.copyWith(lastname: text);
  }

  void onEmailChanged(String text) {
    state = state.copyWith(email: text);
  }

  void onPasswordChanged(String text) {
    state = state.copyWith(password: text);
  }

  void onVPasswordChanged(String text) {
    state = state.copyWith(vPassword: text);
  }
}
