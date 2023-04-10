import 'package:cariro_implant_academy/Controllers/Auth_NavigationController.dart';
import 'package:cariro_implant_academy/Pages/Authentication/LoginPage.dart';
import 'package:cariro_implant_academy/Pages/Authentication/RegsiterPage.dart';
import 'package:cariro_implant_academy/Routes/Routes.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../API/AuthenticationAPI.dart';
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
                onLogin: (email, password) async {
                  var login = await AuthenticationAPI.Login(email, password);
                  if (login.statusCode == 200) {
                    Get.off(
                        SiteLayout(
                          largeScreen: CIA_LargeScreen(),
                        ),
                        duration: Duration(seconds: 0));
                  } else {
                    ShowSnackBar(
                        isSuccess: false,
                        title: "Login Failed",
                        message: login.errorMessage!);
                  }
                },
                onRegister: () =>
                    setState(() => CurrentPage = RegisterPageRoute),
              )
            : RegisterPage((value) => setState(() => CurrentPage = value)));
  }
}
