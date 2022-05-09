import 'package:flutter_firebase_auth/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_firebase_auth/app/domain/responses/reset-password-response.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class ResetPasswordController extends SimpleNotifier {
  String _email = "";
  String get email => _email;
  final _authenticationRepository = Get.i.find<AuthenticationRepository>();
  void onChangeEmail(String text) {
    _email = text;
  }

  Future<ResetPasswordResponse> submit() {
    return _authenticationRepository.sendResetPasswordLink(email);
  }
}
