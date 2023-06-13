import 'dart:html' as html;

import 'package:cariro_implant_academy/API/LoadinAPI.dart';
import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/API/SettingsAPI.dart';
import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/NavigationController.dart';
import 'package:cariro_implant_academy/Controllers/PagesController.dart';
import 'package:cariro_implant_academy/Controllers/PatientMedicalController.dart';
import 'package:cariro_implant_academy/Controllers/SiteController.dart';
import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/CashFlow.dart';
import 'package:cariro_implant_academy/Models/CashFlowSummaryModel.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/NonSurgicalTreatment.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/Models/StockModel.dart';
import 'package:cariro_implant_academy/Models/VisitsModel.dart';
import 'package:cariro_implant_academy/Pages/Authentication/AuthenticationPage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/CIA_SettingsPage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Patient_MedicalInfo.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/ViewUserPage.dart';
import 'package:cariro_implant_academy/Pages/LAB_Pages/LAB_ViewRequest.dart';
import 'package:cariro_implant_academy/Pages/UsersSearchPage.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/MedicalSlidingBar.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'API/TempPatientAPI.dart';
import 'Controllers/RolesController.dart';
import 'Helpers/Router.dart';
import 'Models/Enum.dart';
import 'Pages/CIA_Pages/CashFlowPage.dart';
import 'Pages/CIA_Pages/Patient_ViewPatientPage.dart';
import 'Pages/CIA_Pages/PatientsSearchPage.dart';
import 'Pages/LAB_Pages/LAB_LabRequestsSearch.dart';
import 'Pages/SharedPages/CashFlowSharedPage.dart';
import 'Pages/SharedPages/LapCreateNewRequestSharedPage.dart';
import 'Pages/SharedPages/PatientSharedPages.dart';
import 'Pages/SharedPages/StocksSharedPage.dart';
import 'SignalR/Config.dart';
import 'Widgets/CIA_PopUp.dart';
import 'Widgets/CIA_TeethTreatmentWidget.dart';
import 'Widgets/LargeScreen.dart';
import 'Widgets/SiteLayout.dart';

void main() async{
  html.window.onUnload.listen((event) async {
  });
  Get.put(NavigationController());
  Get.put(PagesController());
  Get.put(InternalPagesController());
  Get.put(RolesController());
  Get.put(SiteController());


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future(() async=> {

    });
    return MaterialApp.router(
      title: 'CIA',
      theme: ThemeData(primaryColor: Colors.red, accentColor: Color_Accent, primarySwatch: Colors.lightGreen),
      debugShowCheckedModeBanner: false,
      //routeInformationParser:CIA_Router.routes.routeInformationParser ,
      // routerDelegate: CIA_Router.routes.routerDelegate,
      routerConfig: CIA_Router.routes,
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
  void initState() {


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        //body: DashBoardPage(),

        backgroundColor: Color_Background,
        body: AuthenticationPage());
  }
}
