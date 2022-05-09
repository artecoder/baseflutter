import 'package:firebase_auth/firebase_auth.dart';

class SignUpResponse {
  final User? user;
  final SignUpError? error;

  SignUpResponse(this.user, this.error);
}

SignUpError parseStringToSignUpError(String text) {
  switch (text) {
    case "too-many-requests":
      return SignUpError.tooManyRequest;
    case "email-already-in-use":
      return SignUpError.emailAlreadyInUse;
    case "weak-password":
      return SignUpError.weakPassword;
    case "network-request-failed":
      return SignUpError.networkRequestFailed;
    default:
      return SignUpError.unknown;
  }
}

enum SignUpError {
  emailAlreadyInUse,
  weakPassword,
  unknown,
  tooManyRequest,
  networkRequestFailed,
}
