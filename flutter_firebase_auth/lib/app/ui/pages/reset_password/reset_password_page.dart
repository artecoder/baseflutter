import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/domain/responses/reset-password-response.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/custom_input_file.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/dialogs/progress_dialogs.dart';
import 'package:flutter_firebase_auth/app/ui/pages/reset_password/controller/reset_password_controller.dart';
import 'package:flutter_firebase_auth/app/utils/email_validator.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/state.dart';

final resetPasswordProvider = SimpleProvider(
  (_) => ResetPasswordController(),
);

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<ResetPasswordController>(
        provider: resetPasswordProvider,
        builder: (_, controller) => Scaffold(
              appBar: AppBar(),
              body: SafeArea(
                  child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomInputField(
                        label: "Email",
                        onChanged: controller.onChangeEmail,
                        inputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () => _submin(context),
                        child: const Text("Solicitar"),
                      )
                    ],
                  ),
                ),
              )),
            ));
  }

  void _submin(BuildContext context) async {
    final controller = resetPasswordProvider.read;
    if (isValidEmail(controller.email)) {
      ProgressDialog.show(context);
      final response = await controller.submit();
      Navigator.pop(context);
      if (response == ResetPasswordResponse.ok) {
        Dialogs.alert(
          context,
          title: "Reinicio password",
          content: "Se ha enviado un correo para reiniciar la contraseña",
        );
      } else {
        String errorMessage = "";
        switch (response) {
          case ResetPasswordResponse.networkRequestFailed:
            errorMessage = "Falla de red";
            break;
          case ResetPasswordResponse.userDisabled:
            errorMessage = "Usuario bloqueado";
            break;
          case ResetPasswordResponse.userNotFound:
            errorMessage = "Usuario no encontrado";
            break;
          case ResetPasswordResponse.tooManyRequest:
            errorMessage = "Demasiadas solicitudes";
            break;
          case ResetPasswordResponse.unknown:
            errorMessage = "No se que pasó";
            break;
        }
        Dialogs.alert(
          context,
          title: "Reinicio password",
          content: errorMessage,
        );
      }
    } else {
      Dialogs.alert(
        context,
        content: "Email inválido",
      );
    }
  }
}
