import 'dart:html' as html;

import 'package:cariro_implant_academy/API/LoadinAPI.dart';
import 'package:cariro_implant_academy/API/PatientAPI.dart';
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
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/Models/StockModel.dart';
import 'package:cariro_implant_academy/Models/VisitsModel.dart';
import 'package:cariro_implant_academy/Pages/Authentication/AuthenticationPage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/CIA_SettingsPage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Patient_MedicalInfo.dart';
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
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'API/TempPatientAPI.dart';
import 'Controllers/RolesController.dart';
import 'Pages/CIA_Pages/Patient_ViewPatientPage.dart';
import 'Pages/LAB_Pages/LAB_TodayLabRequestsPage.dart';
import 'Pages/SharedPages/CashFlowSharedPage.dart';
import 'Pages/SharedPages/StocksSharedPage.dart';
import 'Widgets/CIA_PopUp.dart';
import 'Widgets/CIA_TeethSurgicalTreatmentWidget.dart';
import 'Widgets/CIA_TeethTreatmentWidget.dart';

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
"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6ImJkZjA2YzE5LWRlZDYtNGUyNC1hMDUyLTVjYTAxN2RjNjU0NCIsInJvbGUiOiJhZG1pbiIsIm5iZiI6MTY4MjU1MDM4NywiZXhwIjoxNjgzMTU1MTg3LCJpYXQiOjE2ODI1NTAzODd9.Sqa-EAUde5PIHjlWhM5Uo0BByopmNQd9tFOzDgPeckI"    );
    siteController.setRole("admin");
    siteController.setUser(ApplicationUserModel(name: "A1",idInt: 1));
    patientID = 2;
    MasterController = PatientMedicalController(PatientInfoModel(id: 2));
    StockDataSource dataSource1 = StockDataSource();
    StockLogsDataSource dataSource2 =StockLogsDataSource() ;
    return Scaffold(

      //body: DashBoardPage(),

      backgroundColor: Color_Background,
      body:LabRequestsSearchPage()
    );
  }

}
