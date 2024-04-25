import 'package:flutter/widgets.dart';

extension AppNavigator on BuildContext {
  pushNamed(String routeName, {Map<String, String>? arguments}) {
    Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  pushAndRemoveNamed(String routeName) {
    Navigator.pushNamedAndRemoveUntil(this, routeName, (route) => false);
  }

  pop() {
    Navigator.pop(this);
  }
}
