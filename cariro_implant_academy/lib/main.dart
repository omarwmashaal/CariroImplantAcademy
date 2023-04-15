import 'dart:html' as html;

import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/NavigationController.dart';
import 'package:cariro_implant_academy/Controllers/PagesController.dart';
import 'package:cariro_implant_academy/Controllers/SiteController.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Pages/Authentication/AuthenticationPage.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/MedicalSlidingBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'API/TempPatientAPI.dart';
import 'Controllers/RolesController.dart';
import 'Pages/CIA_Pages/Patient_ViewPatientPage.dart';
import 'Widgets/CIA_PopUp.dart';

void main() {
  html.window.onUnload.listen((event) async {
    print('Reloaded');
  });
  Get.put(NavigationController());
  Get.put(PagesController());
  Get.put(TabsController());
  Get.put(InternalPagesController());
  Get.put(RolesController());
  Get.put(SiteController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'easy_sidemenu Demo',
      theme: ThemeData(
          primaryColor: Colors.red,
          accentColor: Color_Accent,
          primarySwatch: Colors.lightGreen),
      home: const MyHomePage(title: 'easy_sidemenu Demo'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController page = PageController();

  @override
  Widget build(BuildContext context) {
    siteController.setToken(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjFkYTEyZGViLTBlOGMtNGQzMC05NDQxLTNiNDRhNDViMGNlMSIsInJvbGUiOiJhZG1pbiIsIm5iZiI6MTY4MTE1NjQ1MywiZXhwIjoxNjgxNzYxMjUzLCJpYXQiOjE2ODExNTY0NTN9.wHIpjqueWWN8xL5dm7FlcrShwIRjUfJKiNaB4yxdkZg");
    siteController.setRole("admin");
    siteController.setUser(ApplicationUserModel(name: "Admin"));
    return Scaffold(
      body: AuthenticationPage(),
      //body: DashBoardPage(),

      backgroundColor: Color_Background,
    );
  }

  @override
  void initState() {
  //  TempPatientAPI.GetMedicalExamination(5);
  }
}
