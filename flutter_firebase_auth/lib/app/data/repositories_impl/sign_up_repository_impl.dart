import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_auth/app/domain/inputs/sign_up.dart';
import 'package:flutter_firebase_auth/app/domain/repositories/sign_up_repository.dart';
import 'package:flutter_firebase_auth/app/domain/responses/sign-up-response.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final FirebaseAuth _auth;

  SignUpRepositoryImpl(this._auth);

  @override
  Future<SignUpResponse> register(SignUpData data) async {
    try {
      final UserCredential = await _auth.createUserWithEmailAndPassword(
          email: data.email, password: data.password);
      await UserCredential.user!
          .updateDisplayName("${data.name} ${data.lastname}");
      return SignUpResponse(UserCredential.user!, null);
    } on FirebaseAuthException catch (e) {
      return SignUpResponse(null, parseStringToSignUpError(e.code));
    }
  }
}
