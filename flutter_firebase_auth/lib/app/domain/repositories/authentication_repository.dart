import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_auth/app/domain/responses/reset-password-response.dart';
import 'package:flutter_firebase_auth/app/domain/responses/sign-in-response.dart';

abstract class AuthenticationRepository {
  Future<User?> get user;
  Future<void> signOut();
  Future<SignInResponse> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<ResetPasswordResponse> sendResetPasswordLink(String email);
}
