import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/custom_input_file.dart';
import 'package:flutter_firebase_auth/app/ui/pages/login/controller/login_controller.dart';
import 'package:flutter_firebase_auth/app/ui/pages/login/utils/send_login_form.dart';
import 'package:flutter_firebase_auth/app/ui/routes/routes.dart';
import 'package:flutter_firebase_auth/app/utils/email_validator.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_meedu/state.dart';

final loginProvider = SimpleProvider(
  (_) => LoginController(),
);

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProviderListener<LoginController>(
      provider: loginProvider,
      builder: (_, controller) {
        return Scaffold(
            body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
                color: Colors.transparent,
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomInputField(
                          label: "Email",
                          onChanged: controller.onEmailChanged,
                          inputType: TextInputType.emailAddress,
                          validator: (text) {
                            if (isValidEmail(text!)) {
                              return null;
                            } else {
                              return "Correo inválido";
                            }
                          }),
                      const SizedBox(height: 20),
                      CustomInputField(
                          label: "Contraseña",
                          inputType: TextInputType.visiblePassword,
                          isPassword: true,
                          onChanged: controller.onPasswordChanged,
                          validator: (text) {
                            if (text!.trim().length >= 6) {
                              return null;
                            } else {
                              return "Contraseña incorrecta";
                            }
                          }),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () => sendLoginForm(context),
                              child: const Text("Iniciar sesión")),
                          Padding(padding: EdgeInsets.all(10)),
                          ElevatedButton(
                              onPressed: () =>
                                  router.pushNamed(Routes.REGISTER),
                              child: const Text("Registrarse")),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                          onPressed: () =>
                              router.pushNamed(Routes.RESET_PASSWORD),
                          child: const Text(
                            "¿Olvidó su contraseña?",
                          )),
                    ],
                  ),
                )),
          ),
        ));
      },
    );
  }
}
