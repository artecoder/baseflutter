import 'package:firebase_auth/firebase_auth.dart';

class SignInResponse {
  final SignInError? error;
  final User? user;

  SignInResponse(this.error, this.user);
}

enum SignInError {
  networkRequestFailed,
  userNotFound,
  userDisabled,
  wrongPassword,
  tooManyRequest,
  unknown,
}
SignInError stringToSignInError(String code) {
  switch (code) {
    case "user-disabled":
      return SignInError.userDisabled;
    case "user-not-found":
      return SignInError.userNotFound;
    case "wrong-password":
      return SignInError.wrongPassword;
    case "too-many-request":
      return SignInError.tooManyRequest;
    case "network-request-failed":
      return SignInError.networkRequestFailed;
    default:
      return SignInError.unknown;
  }
}
