import 'package:flutter/widgets.dart' show BuildContext, Container, Widget;
import 'package:flutter_firebase_auth/app/ui/pages/home/home_page.dart';
import 'package:flutter_firebase_auth/app/ui/pages/register/register_page.dart';
import 'package:flutter_firebase_auth/app/ui/pages/reset_password/reset_password_page.dart';
import 'package:flutter_firebase_auth/app/ui/pages/splash/splash_page.dart';
import 'package:flutter_firebase_auth/app/ui/routes/routes.dart';

import '../pages/login/login_page.dart';

Map<String, Widget Function(BuildContext)> get AppRoutes => {
      Routes.SPLASH: (_) => const SplashPage(),
      Routes.LOGIN: (_) => const LoginPage(),
      Routes.HOME: (_) => const HomePage(),
      Routes.REGISTER: (_) => const RegisterPage(),
      Routes.RESET_PASSWORD: (_) => const ResetPasswordPage(),
    };
