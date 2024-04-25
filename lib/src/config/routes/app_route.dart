import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_gallery/src/core/utils/app_strings.dart';
import 'package:my_gallery/src/features/home/presentation/screens/home_screen.dart';
import 'package:my_gallery/src/features/login/presentation/screens/login_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginScreen = '/loginScreen';
  static const String homeScreen = '/homeScreen';
}

class AppRoutes {
  static Route? onGeneratRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: ((context) => LoginScreen()));
      case Routes.homeScreen:
        return MaterialPageRoute(builder: ((context) => HomeScreen()));

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text(AppStrings.noRouteFound),
              ),
            )));
  }
}
