import 'package:flutter_firebase_auth/app/domain/inputs/sign_up.dart';
import 'package:flutter_firebase_auth/app/domain/responses/sign-up-response.dart';

abstract class SignUpRepository {
  Future<SignUpResponse> register(SignUpData data);
}
