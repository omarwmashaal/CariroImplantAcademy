import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/Auth_NavigationController.dart';
import 'package:cariro_implant_academy/Controllers/SiteController.dart';
import 'package:cariro_implant_academy/Helpers/Router.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Pages/Authentication/LoginPage.dart';
import 'package:cariro_implant_academy/Pages/Authentication/RegsiterPage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/PatientsSearchPage.dart';
import 'package:cariro_implant_academy/Pages/LAB_Pages/LAB_LabRequestsSearch.dart';
import 'package:cariro_implant_academy/Routes/Routes.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../API/AuthenticationAPI.dart';
import '../../Widgets/LargeScreen.dart';
import '../../Widgets/SiteLayout.dart';
import '../../features/patient/presentation/presentation/patientsSearchPage.dart';

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
        child: LoginPage(
          onLogin: (email, password) async {
            //context.go("/"+PatientsSearchPage.routeName);

            var login = await AuthenticationAPI.Login(email, password);
            if (login.statusCode == 200) {
              if(siteController.getSite()==Website.CIA)
                context.goNamed(PatientsSearchPage.routeName);
              else if(siteController.getSite()==Website.Lab)
                context.goNamed(LabTodaysRequestsSearch.routeName);
              if(siteController.getSite()==Website.Clinic)
                context.go("/CIA/Patients");
            } else {
              ShowSnackBar(context,
                  isSuccess: false,
                  title: "Login Failed",
                  message: login.errorMessage!);
            }
          },
          onRegister: () =>
              setState(() => CurrentPage = RegisterPageRoute),
        ));
  }
}
