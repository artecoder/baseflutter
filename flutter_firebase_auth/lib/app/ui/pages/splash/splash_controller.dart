import 'package:flutter_firebase_auth/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_firebase_auth/app/ui/routes/routes.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class SplashController extends SimpleNotifier {
  final _authRepository = Get.i.find<AuthenticationRepository>();
  String? _routeName;
  String? get routeName => _routeName;
  SplashController() {
    _init();
  }

  void _init() async {
    final user = await _authRepository.user;
    _routeName = user != null ? Routes.HOME : Routes.LOGIN;
    notify();
  }

  @override
  void dispose() {
    print("dispose splash");
    super.dispose();
  }
}
