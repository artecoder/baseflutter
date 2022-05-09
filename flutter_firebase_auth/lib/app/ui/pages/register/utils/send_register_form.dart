import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_auth/app/domain/responses/sign-up-response.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/progress_dialogs.dart';
import 'package:flutter_firebase_auth/app/ui/routes/routes.dart';
import '../register_page.dart' show registerProvider;
import 'package:flutter_meedu/router.dart' as router;

Future<void> sendRegisterForm(BuildContext context) async {
  final controller = registerProvider.read;
  final isValidForm = controller.formKey.currentState!.validate();
  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
      late String content = "";
      switch (response.error) {
        case SignUpError.emailAlreadyInUse:
          content = "Email ya se encuentra en uso";
          break;
        case SignUpError.tooManyRequest:
          content = "Tranquilo! demasiados intentos";
          break;
        case SignUpError.weakPassword:
          content = "Contraseña muy debil";
          break;
        case SignUpError.networkRequestFailed:
          content = "Problemas de red";
          break;
        case SignUpError.unknown:
        default:
          content = "Algo pasó y no sabemos que fue";
          break;
      }
      Dialogs.alert(
        context,
        title: "Oops",
        content: content,
      );
    } else {
      router.pushNamedAndRemoveUntil(
        Routes.HOME,
      );
    }
  } else {
    Dialogs.alert(
      context,
      title: "Error",
      content: "Revisa los campos ingresados",
    );
  }
}
