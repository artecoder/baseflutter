import 'package:flutter/widgets.dart' show FormState, GlobalKey;
import 'package:flutter_firebase_auth/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_firebase_auth/app/domain/responses/sign-in-response.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class LoginController extends SimpleNotifier {
  String _email = '', _password = '';
  final _authRepository = Get.i.find<AuthenticationRepository>();
  final GlobalKey<FormState> formKey = GlobalKey();
  void onEmailChanged(String text) {
    _email = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<SignInResponse> submit() {
    return _authRepository.signInWithEmailAndPassword(_email, _password);
  }
}
