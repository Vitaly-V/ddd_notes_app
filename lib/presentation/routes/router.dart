import 'package:auto_route/auto_route_annotations.dart';

import '../sign_in/sign_in_screen.dart';
import '../splash/splash_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute<MaterialRoute<dynamic>>>[
    MaterialRoute<MaterialRoute<dynamic>>(page: SplashScreen, initial: true),
    MaterialRoute<MaterialRoute<dynamic>>(page: SignInScreen),
  ],
  generateNavigationHelperExtension: true,
)
class $Router {}
