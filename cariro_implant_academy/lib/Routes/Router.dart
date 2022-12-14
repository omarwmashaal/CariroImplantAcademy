import 'package:cariro_implant_academy/Pages/Authentication/LoginPage.dart';
import 'package:cariro_implant_academy/Routes/Routes.dart';
import 'package:flutter/material.dart';

import '../Pages/Authentication/RegsiterPage.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  /*switch (settings.name) {
    case LoginPageRoute:
      return _getPageRoute(LoginPage());
    case RegisterPageRoute:
      return _getPageRoute(RegisterPage());
    default:
      return _getPageRoute(LoginPage());
  }*/ return _getPageRoute(Container()) ;
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
