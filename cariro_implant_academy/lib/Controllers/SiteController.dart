import 'dart:html';

import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/DTOs/AdvancedPatientSearchDTO.dart';
import 'package:cariro_implant_academy/Models/DTOs/AdvancedTreatmentSearchDTO.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Models/NotificationModel.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/PatientAdvancedSearchPage.dart';
import 'package:cariro_implant_academy/Pages/LAB_Pages/LAB_LabRequestsSearch.dart';
import 'package:cariro_implant_academy/Pages/SharedPages/CashFlowSharedPage.dart';
import 'package:cariro_implant_academy/Pages/SharedPages/PatientSharedPages.dart';
import 'package:cariro_implant_academy/Pages/SharedPages/StocksSharedPage.dart';
import 'package:cariro_implant_academy/Widgets/MedicalSlidingBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/MedicalAPI.dart';
import '../Constants/Controllers.dart';
import '../Pages/CIA_Pages/CIA_MyProfilePage.dart';
import '../Pages/CIA_Pages/CIA_SettingsPage.dart';
import '../Pages/CIA_Pages/PatientVisits.dart';
import '../Pages/CIA_Pages/Patient_MedicalInfo.dart';
import '../Pages/CIA_Pages/PatientsSearchPage.dart';
import '../Pages/CIA_Pages/ViewUserPage.dart';
import '../Pages/LAB_Pages/LAB_MyTasks.dart';
import '../Pages/UsersSearchPage.dart';
import '../Widgets/SlidingTab.dart';

class SiteController extends GetxController {
  static SiteController instance = Get.find();
  Website _site = Website.CIA;
  AssetImage _siteLogo = AssetImage("assets/CIA_Logo3.png");
  RxString _currentRole = "".obs;
  List<String> _CIA_Roles = ["admin", "instructor", "secretary", "assistant"];
  List<String> _Lab_Roles = ["Admin", "technician", "Secretary"];
  List<String> _Clinic_Roles = ["Admin", "Secretary", "Doctor"];
  RxBool disableMedicalEdit = true.obs;
  ApplicationUserModel _applicationUser = ApplicationUserModel();
  Rx<bool> newNotification = false.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  ApplicationUserModel getUser() => _applicationUser;

  setUser(ApplicationUserModel user) => _applicationUser = user;

  Widget appBarWidget = Container();
  String selectedTitle = "";
  String title = "";
  List<String> searchPatientColumn = [];
  AdvancedPatientSearchDTO searchPatientQuery = AdvancedPatientSearchDTO();
  AdvancedTreatmentSearchDTO searchTreatmentQuery = AdvancedTreatmentSearchDTO(done: false);

  setAppBarWidget(
      {List<SlidingTabModel>? tabs,
      Function? onChange,
      Future<bool> Function()? popUp,
      double? width,
      double? height,
      SlidingTabModel? initalTab,
      double? fontSize}) async {
    if (tabs != null) {
      appBarWidget = GetBuilder<SiteController>(
          builder: (siteController) => Container(
                key: GlobalKey(),
                child: SlidingTab(
                    key: GlobalKey(),
                    tabs: tabs,
                    weight: tabs.isNotEmpty&&tabs.length>3?600: width == null ? 400 : width,
                    height: height,
                    fontSize: fontSize,
                    onChange: ((value) async {
                      if (popUp != null) {
                        bool changePage = await popUp();
                        if (!changePage) return;
                      }
                      title = tabs[value].title;
                    })),
              ));

      //title.value = tabs[0];
      await Future.delayed(Duration(microseconds: 1));

    } else {
      appBarWidget = Container();
      await Future.delayed(Duration(microseconds: 1));
    }
    update();
  }

  setAppBarSelectedTitle(String title) async {
    selectedTitle = title;
    await Future.delayed(Duration(microseconds: 1));
    update();
  }

  setDynamicAppBar({required BuildContext context, Map<String, String>? pathQueries}) {
    var path = GoRouter.of(context).location.split("/").last;
    if(siteController.getSite()==Website.CIA)
      {
        if ((path == SettingsPage.routeName && getRole() == "admin") || (path == UsersSettingsPage.routeName && getRole() == "admin"))
          siteController.setAppBarWidget(tabs: [
            SlidingTabModel(title: "Settings", namedDirectory: SettingsPage.routeName),
            SlidingTabModel(title: "Users", namedDirectory: UsersSettingsPage.routeName),
          ]);
        else if (path == PatientInfo_SharedPage.viewPatientRouteName || path == PatientVisits_SharedPage.routeName || path == PatientComplains.routeName)
          siteController.setAppBarWidget(tabs: [
            SlidingTabModel(title: "Patient Data", namedDirectory: PatientInfo_SharedPage.viewPatientRouteName, pathParameters: pathQueries),
            SlidingTabModel(title: "Patient Visits", namedDirectory: PatientVisits_SharedPage.routeName, pathParameters: pathQueries),
            SlidingTabModel(title: "Complains", namedDirectory: PatientComplains.routeName, pathParameters: pathQueries),
          ]);
        else if (path == PatientsSearchPage.routeName || path == PatientsSearchPage.myPatientsRouteName || path == PatientsComplainsPage.routeName || path ==PatientAdvancedSearchPage.routeName || path ==PatientAdvancedSearchPage.routeNameTreatments || path ==PatientVisits.routeName ) {
          if (getRole() == "secretary")
            siteController.setAppBarWidget(tabs: [
              SlidingTabModel(title: "Patient Data", namedDirectory: PatientsSearchPage.routeName),
              SlidingTabModel(title: "Patient Visits", namedDirectory: PatientVisits.routeName),
              SlidingTabModel(title: "Complains", namedDirectory: PatientsComplainsPage.routeName),
            ]);
          else
            siteController.setAppBarWidget(tabs: [
              SlidingTabModel(title: "Patient Data", namedDirectory: PatientsSearchPage.routeName),
              SlidingTabModel(title: "My Patients", namedDirectory: PatientsSearchPage.myPatientsRouteName),
              SlidingTabModel(title: "Patient Visits", namedDirectory: PatientVisits.routeName),
              SlidingTabModel(title: "Complains", namedDirectory: PatientsComplainsPage.routeName),
              path ==PatientAdvancedSearchPage.routeNameTreatments?
              SlidingTabModel(title: "Advanced Search", namedDirectory: PatientAdvancedSearchPage.routeNameTreatments ):
              SlidingTabModel(title: "Advanced Search", namedDirectory: PatientAdvancedSearchPage.routeName )


              ,
            ]);
        } else if (path == ViewUserData.candidateRouteName || path == ViewCandidateData.routeName)
          siteController.setAppBarWidget(tabs: [
            SlidingTabModel(title: "Profile", namedDirectory: ViewUserData.candidateRouteName, pathParameters: pathQueries),
            SlidingTabModel(title: "Data", namedDirectory: ViewCandidateData.routeName, pathParameters: pathQueries),
          ]);
        else if (path == CashFlowIncomeSharedPage.routeName || path == CashFlowExpensesSharedPage.routeName || path == CashFlowSummarySharedPage.routeName)
          siteController.setAppBarWidget(tabs: [
            SlidingTabModel(title: "Income", namedDirectory: CashFlowIncomeSharedPage.routeCIAname,compareName:CashFlowIncomeSharedPage.routeName),
            SlidingTabModel(title: "Expenses", namedDirectory: CashFlowExpensesSharedPage.routeCIAname,compareName:CashFlowExpensesSharedPage.routeName),
            SlidingTabModel(title: "Summary", namedDirectory: CashFlowSummarySharedPage.routeCIAname,compareName:CashFlowSummarySharedPage.routeName),
          ]);
        else if (path == StockListSharedPage.routeName || path == StockLogsSharedPage.routeName)
          siteController.setAppBarWidget(tabs: [
            SlidingTabModel(title: "Stock", namedDirectory: StockListSharedPage.routeCIAname,compareName:StockListSharedPage.routeName),
            SlidingTabModel(title: "Logs", namedDirectory: StockLogsSharedPage.routeCIAname,compareName:StockLogsSharedPage.routeName),
          ]);
        else if (path == PatientMedicalHistory.routeName ||
            path == PatientDentalExamination.routeName ||
            path == PatientProstheticTreatment.routeName ||
            path == PatientDentalHistory.routeName ||
            path == PatientNonSurgicalTreatment.routeName ||
            path == PatientTreatmentPlan.routeName ||
            path == PatientSurgicalTreatment.routeName)
          setMedicalAppBar(id: int.parse(pathQueries!['id']!), context: context);
        else
          setAppBarWidget();
      }
    else if(siteController.getSite()==Website.Lab)
      {
        if (path == LabTodaysRequestsSearch.routeName  || path == LabAllRequestsSearch.routeName ||path == LabAllRequestsSearch.routeMyName )
          {
            if(siteController.getRole()=="technician")
              {
                siteController.setAppBarWidget(tabs: [
                  SlidingTabModel(title: "Today's Request", namedDirectory: LabTodaysRequestsSearch.routeName),
                  SlidingTabModel(title: "All Requests", namedDirectory: LabAllRequestsSearch.routeName),
                  SlidingTabModel(title: "My Requests", namedDirectory: LabAllRequestsSearch.routeMyName),
                ]);
              }
            else
              {
                siteController.setAppBarWidget(tabs: [
                  SlidingTabModel(title: "Today's Request", namedDirectory: LabTodaysRequestsSearch.routeName),
                  SlidingTabModel(title: "All Requests", namedDirectory: LabAllRequestsSearch.routeName),
                ]);
              }
          }
        else if (path == StockListSharedPage.routeName || path == StockLogsSharedPage.routeName)
          siteController.setAppBarWidget(tabs: [
            SlidingTabModel(title: "Stock", namedDirectory: StockListSharedPage.routeLABname,compareName:StockListSharedPage.routeName ),
            SlidingTabModel(title: "Logs", namedDirectory: StockLogsSharedPage.routeLABname,compareName:StockLogsSharedPage.routeName ),
          ]);
        else if (path == CashFlowIncomeSharedPage.routeName || path == CashFlowExpensesSharedPage.routeName || path == CashFlowSummarySharedPage.routeName)
          siteController.setAppBarWidget(tabs: [
            SlidingTabModel(title: "Income", namedDirectory: CashFlowIncomeSharedPage.routeLABname,compareName:CashFlowIncomeSharedPage.routeName ),
            SlidingTabModel(title: "Expenses", namedDirectory: CashFlowExpensesSharedPage.routeLABname,compareName:CashFlowExpensesSharedPage.routeName ),
            SlidingTabModel(title: "Summary", namedDirectory: CashFlowSummarySharedPage.routeLABname,compareName:CashFlowSummarySharedPage.routeName ),
          ]);
        else
          setAppBarWidget();

      }
    else
      setAppBarWidget();
  }

  setMedicalAppBar({required int id, required BuildContext context}) async {
    var path = GoRouter.of(context).location.split("/").last;
    var pages = [
      MedicalSlidingModel(name: "Medical History", onTap: () => context.goNamed(PatientMedicalHistory.routeName, pathParameters: {"id": id.toString()})),
      MedicalSlidingModel(name: "Dental History", onTap: () => context.goNamed(PatientDentalHistory.routeName, pathParameters: {"id": id.toString()})),
      MedicalSlidingModel(name: "Dental Examination", onTap: () => context.goNamed(PatientDentalExamination.routeName, pathParameters: {"id": id.toString()})),
      MedicalSlidingModel(
          name: "Non Surgical Treatment",
          onTap: () => context.goNamed(PatientNonSurgicalTreatment.routeName, pathParameters: {"id": id.toString()}),
          onSave: () async {
            if(!siteController.disableMedicalEdit.value) {
              await MedicalAPI.AddPatientNonSurgicalTreatment(id, nonSurgicalTreatment);
              await MedicalAPI.UpdatePatientDentalExamination(id, tempDentalExamination);
            }
          }),
      MedicalSlidingModel(
          name: "Treatment Plan",
          onTap: () => context.goNamed(PatientTreatmentPlan.routeName, pathParameters: {"id": id.toString()}),
          onSave: () async {
            if(!siteController.disableMedicalEdit.value)
            await MedicalAPI.UpdatePatientTreatmentPlan(id, treatmentPlanModel!.treatmentPlan!);
          }),
      MedicalSlidingModel(
          name: "Surgical Treatment",
          onTap: () => context.goNamed(PatientSurgicalTreatment.routeName, pathParameters: {"id": id.toString()}),
          onSave: () async {
            if(!siteController.disableMedicalEdit.value)
            await MedicalAPI.UpdatePatientSurgicalTreatment(id, surgicalTreatmentModel);
          }),
      MedicalSlidingModel(
          name: "Prosthetic Treatment",
          onTap: () => context.goNamed(PatientProstheticTreatment.routeName, pathParameters: {"id": id.toString()}),
          onSave: () {

          }),
      MedicalSlidingModel(
          name: "Photos and CBCTs",
          onSave: () {

          }),
    ];
    for (var element in pages) {
      if (element!.name!.removeAllWhitespace.toString().toLowerCase() == path.toLowerCase()) {
        element.isSelected = true;
         title = element.name;
        break;
      }
    }
    var bar = MedicalSlidingBar(key: new GlobalKey(), pages: pages);

    appBarWidget = bar;
    await Future.delayed(Duration(milliseconds: 1));
    update();
  }

  Website getSite() => _site;

  AssetImage getSiteLogo() => _siteLogo;

  AssetImage getSiteLogoBySite(Website site) {
    if (site == Website.CIA)
      return AssetImage("assets/CIA_Logo3.png");
    else if (site == Website.Lab)
      return AssetImage("assets/LAB_Logo.png");
    else
      return AssetImage("assets/Clinic_logo.png");
  }

  setSite(Website site) {
    switchTheme(site);
    _site = site;
    if (site == Website.CIA)
      _siteLogo = AssetImage("assets/CIA_Logo3.png");
    else if (site == Website.Lab)
      _siteLogo = AssetImage("assets/LAB_Logo.png");
    else
      _siteLogo = AssetImage("assets/Clinic_logo.png");
  }

  setRole(String role) {
    _currentRole.value = role;
  }

  setToken(String token) async{
    var pref = await SharedPreferences.getInstance();
    pref.setString("token", token);
  }
  removeToken()async{
    var pref = await SharedPreferences.getInstance();
    pref.remove("token");
  }
  Future<String> getToken() async{
    var pref = await  SharedPreferences.getInstance();
    return Future.value(pref.getString("token")??"");
  }

  String getRole() => _currentRole.value;

  List<String> getRoles() {
    if (_site == "CIA")
      return _CIA_Roles;
    else if (_site == "LAB")
      return _Lab_Roles;
    else
      return _Clinic_Roles;
  }
}
