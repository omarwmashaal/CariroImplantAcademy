import 'package:cariro_implant_academy/Controllers/Auth_NavigationController.dart';
import 'package:cariro_implant_academy/Controllers/SiteController.dart';
import 'package:cariro_implant_academy/Helpers/Router.dart';
import 'package:cariro_implant_academy/Pages/Authentication/LoginPage.dart';
import 'package:cariro_implant_academy/Pages/Authentication/RegsiterPage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/PatientsSearchPage.dart';
import 'package:cariro_implant_academy/Routes/Routes.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

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
                  //context.go("/"+PatientsSearchPage.routeName);
                  context.go("/Patients");
                  var login = await AuthenticationAPI.Login(email, password);
                  if (login.statusCode == 200) {
                    //context.go("Patsients");
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
