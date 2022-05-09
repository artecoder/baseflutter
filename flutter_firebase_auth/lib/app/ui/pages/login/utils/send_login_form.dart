import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth/app/domain/responses/sign-in-response.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/progress_dialogs.dart';
import 'package:flutter_firebase_auth/app/ui/routes/routes.dart';

import '../../../global_widgets/dialogs/dialogs.dart';
import '../login_page.dart' show loginProvider;
import 'package:flutter_meedu/router.dart' as router;

Future<void> sendLoginForm(BuildContext context) async {
  final controller = loginProvider.read;
  final isValidForm = controller.formKey.currentState!.validate();
  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
      late String content;
      switch (response.error) {
        case SignInError.networkRequestFailed:
          content = "Exite un problema con la red";
          break;

        case SignInError.tooManyRequest:
          content = "Tranquilo! demasiados intentos";
          break;
        case SignInError.userNotFound:
          content = "Usuario no existe";
          break;
        case SignInError.userDisabled:
          content = "Usuario bloqueado";
          break;
        case SignInError.wrongPassword:
          content = "Contraseña incorrecta";
          break;
        case SignInError.tooManyRequest:
          content = "Ha exedido el número de intentos";
          break;
        case SignInError.unknown:
        default:
          content = "Ni idea que pasó";
          break;
      }
      Dialogs.alert(
        context,
        title: "Inicio de sesión",
        content: content,
      );
    } else {
      router.pushReplacementNamed(Routes.HOME);
    }
  }
}
