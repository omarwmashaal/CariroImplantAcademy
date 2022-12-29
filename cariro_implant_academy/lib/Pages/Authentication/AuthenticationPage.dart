import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/Auth_NavigationController.dart';
import 'package:cariro_implant_academy/Pages/Authentication/LoginPage.dart';
import 'package:cariro_implant_academy/Pages/Authentication/RegsiterPage.dart';
import 'package:cariro_implant_academy/Routes/Routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Widgets/LargeScreen.dart';
import '../../Widgets/SiteLayout.dart';

class AuthenticationPage extends StatefulWidget {
  AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  String CurrentPage = LoginPageRoute;

  Auth_NavigationController auth_navigationController =
      Get.put(Auth_NavigationController());

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CurrentPage == LoginPageRoute
            ? LoginPage(
                onLogin: () {
                  if (siteController.getSite() == "CIA")
                    Get.off(
                        SiteLayout(
                          largeScreen: CIA_LargeScreen(),
                        ),
                        duration: Duration(seconds: 0));
                  else {
                    Get.off(
                        SiteLayout(
                          largeScreen: CIA_LargeScreen(),
                        ),
                        duration: Duration(seconds: 0));
                  }
                },
                onRegister: () =>
                    setState(() => CurrentPage = RegisterPageRoute),
              )
            : RegisterPage((value) => setState(() => CurrentPage = value)));
  }
}
