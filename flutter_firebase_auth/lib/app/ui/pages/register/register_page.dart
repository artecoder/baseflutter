import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/app/ui/global_widgets/custom_input_file.dart';
import 'package:flutter_firebase_auth/app/ui/pages/register/controller/register_controller.dart';
import 'package:flutter_firebase_auth/app/ui/pages/register/controller/register_state.dart';
import 'package:flutter_firebase_auth/app/ui/pages/register/utils/send_register_form.dart';
import 'package:flutter_firebase_auth/app/utils/email_validator.dart';
import 'package:flutter_firebase_auth/app/utils/name_validator.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/state.dart';

final registerProvider = StateProvider<RegisterController, RegisterState>(
  (_) => RegisterController(),
);

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProviderListener<RegisterController>(
      provider: registerProvider,
      builder: (_, controller) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(),
            body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Form(
                      key: controller.formKey,
                      child: ListView(
                          padding: const EdgeInsets.all(15),
                          children: [
                            CustomInputField(
                              label: "Nombre",
                              onChanged: controller.onNameChanged,
                              validator: (text) {
                                return isValidName(text!)
                                    ? null
                                    : "Nombre inválido";
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomInputField(
                              label: "Apellido",
                              onChanged: controller.onLastNameChanged,
                              validator: (text) {
                                return isValidName(text!)
                                    ? null
                                    : "Apellido inválido";
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomInputField(
                              label: "Email",
                              inputType: TextInputType.emailAddress,
                              onChanged: controller.onEmailChanged,
                              validator: (text) {
                                return isValidEmail(text!)
                                    ? null
                                    : "Correo inválido";
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomInputField(
                              label: "Contraseña",
                              onChanged: controller.onPasswordChanged,
                              isPassword: true,
                              validator: (text) {
                                if (text!.trim().length >= 6) {
                                  return null;
                                }
                                return "La contraseña debe tener al menos 6 caracteres";
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Consumer(builder: (_, watch, __) {
                              watch(
                                registerProvider.select((_) => _.password),
                              );
                              return CustomInputField(
                                label: "Verificar contraseña",
                                onChanged: controller.onVPasswordChanged,
                                isPassword: true,
                                validator: (text) {
                                  if (controller.state.password != text) {
                                    return "La contraseña y su verificación no coincide";
                                  }
                                  if (text!.trim().length >= 6) {
                                    return null;
                                  }
                                  return "La contraseña debe tener al menos 6 caracteres";
                                },
                              );
                            }),
                            const SizedBox(height: 10),
                            CupertinoButton(
                              child: const Text("Registrar"),
                              color: Colors.blue,
                              onPressed: () => sendRegisterForm(context),
                            ),
                          ]),
                    ))));
      },
    );
  }
}
