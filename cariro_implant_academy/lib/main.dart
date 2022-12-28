import 'dart:html' as html;

import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Controllers/NavigationController.dart';
import 'package:cariro_implant_academy/Controllers/PagesController.dart';
import 'package:cariro_implant_academy/Controllers/SiteController.dart';
import 'package:cariro_implant_academy/Pages/Authentication/AuthenticationPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Controllers/RolesController.dart';

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
    return Scaffold(
      body: AuthenticationPage(),
      //body: DashBoardPage(),

      backgroundColor: Color_Background,
    );
  }
}
