import 'dart:convert';
import 'dart:typed_data';

import 'package:cariro_implant_academy/core/features/settings/presentation/pages/ClinicPriceSettingsPage.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/pages/LabItemsSettingsPage.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/pages/clinicTreeatmentPage.dart';
import 'package:cariro_implant_academy/features/patient/presentation/pages/todolistsSearchPage.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/presentation/pages/ComplicationsAfterProsthesisPage.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/presentation/pages/ComplicationsAfterSurgeryPage.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/paddings/pkcs7.dart';

import '../core/features/settings/presentation/pages/UserSettingsPage.dart';
import '../core/features/settings/presentation/pages/WebsiteSettingsPage.dart';
import '../features/cashflow/presentation/pages/cashFlowExpensesPage.dart';
import '../features/cashflow/presentation/pages/cashFlowIncomPage.dart';

import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedPatientSearchEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedTreatmentSearchEntity.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/pages/LabRequestsSearchPage.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc.dart';
import 'package:cariro_implant_academy/Widgets/MedicalSlidingBar.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/presentation/pages/medicalInfo_DentalExaminationPage.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/pages/nonSurgicalTreatmentPage.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/pages/prsotheticTreatmentPage.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/pages/treatmentPlanPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/Controllers.dart';
import '../Widgets/AppBarBloc_Events.dart';
import '../Widgets/SlidingTab.dart';
import '../core/injection_contianer.dart';
import '../features/cashflow/presentation/pages/cashFlowSummaryPage.dart';
import '../features/patient/presentation/pages/PatientAdvancedSearchPage.dart';
import '../features/patient/presentation/pages/complainsSearchPage.dart';
import '../features/patient/presentation/pages/createOrViewPatientPage.dart';
import '../features/patient/presentation/pages/patientProfileComplainsPage.dart';
import '../features/patient/presentation/pages/patientsSearchPage.dart';
import '../features/patient/presentation/pages/visitsPage.dart';
import '../features/patientsMedical/treatmentFeature/presentation/pages/surgicalTreatmentPage.dart';
import '../features/patientsMedical/dentalHistroy/presentaion/pages/medicalInfo_DentalHistoryPage.dart';
import '../features/patientsMedical/medicalExamination/presentation/pages/medicalInfo_MedicalHistoryPage.dart';
import '../features/stock/presentation/pages/stockLogsSearchPage.dart';
import '../features/stock/presentation/pages/stockSearchPage.dart';
import '../features/user/presentation/pages/candidateDetailsPage.dart';
import '../features/user/presentation/pages/viewUserProfile.dart';

class SiteController {
  //static SiteController instance = Get.find();
  AssetImage _siteLogo = AssetImage("assets/CIA_Logo3.png");
  List<String> _CIA_Roles = ["admin", "instructor", "secretary", "assistant"];
  List<String> _Lab_Roles = ["Admin", "technician", "Secretary"];
  List<String> _Clinic_Roles = ["Admin", "Secretary", "Doctor"];
  AdvancedPatientSearchEntity searchPatientQuery = AdvancedPatientSearchEntity();
  AdvancedTreatmentSearchEntity searchTreatmentQuery = AdvancedTreatmentSearchEntity(done: false);

  setAppBarWidget(
      {required BuildContext context,
      List<SlidingTabModel>? tabs,
      Function? onChange,
      Future<bool> Function()? popUp,
      double? width,
      double? height,
      SlidingTabModel? initalTab,
      double? fontSize}) async {
    if (tabs != null) {
      sl<AppBarBloc>().add(AppBarChangeAppBarEvent(
          newAppBar: Container(
        //  key: GlobalKey(),
        child: SlidingTab(
            //    key: GlobalKey(),
            tabs: tabs,
            weight: tabs.isNotEmpty && tabs.length > 3
                ? 600
                : width == null
                    ? 400
                    : width,
            height: height,
            fontSize: fontSize,
            onChange: ((value) async {
              if (popUp != null) {
                bool changePage = await popUp();
                if (!changePage) return;
              }
              //  title = tabs[value].title;
            })),
      )));

      //title.value = tabs[0];
      //await Future.delayed(Duration(microseconds: 1));
    } else {
      BlocProvider.of<AppBarBloc>(context).add(AppBarRemoveAppBarEvent());

      // appBarWidget = Container();
      //await Future.delayed(Duration(microseconds: 1));
    }
    //update();
  }

  setDynamicAppBar({required BuildContext context, Map<String, String>? pathQueries}) {
    var path = GoRouterState.of(context).fullPath!.split("/").last;
    print(path);
    Future.delayed(Duration(milliseconds: 0)).then((value) {
      if (siteController.getSite() == Website.CIA || siteController.getSite() == Website.Clinic) {
        if ((path == SettingsPage.routePath.split("/").last && getRole()!.contains("admin")) ||
            (path == UsersSettingsPage.routePath.split("/").last && getRole()!.contains("admin")) ||
            (path == ClinicPriceSettingsPage.routePath.split("/").last && getRole()!.contains("admin"))) {
          if (getSite() == Website.CIA) {
            siteController.setAppBarWidget(context: context, tabs: [
              SlidingTabModel(title: "Settings", compareName: SettingsPage.routePath.split("/").last, namedDirectory: SettingsPage.getRouteName()),
              SlidingTabModel(
                  title: "Users", compareName: UsersSettingsPage.routePath.split("/").last, namedDirectory: UsersSettingsPage.getRouteName()),
            ]);
          } else if (getSite() == Website.Clinic) {
            siteController.setAppBarWidget(context: context, tabs: [
              SlidingTabModel(title: "Settings", compareName: SettingsPage.routePath.split("/").last, namedDirectory: SettingsPage.getRouteName()),
              SlidingTabModel(title: "Prices", compareName: ClinicPriceSettingsPage.routePath, namedDirectory: ClinicPriceSettingsPage.routeName),
              SlidingTabModel(
                  title: "Users", compareName: UsersSettingsPage.routePath.split("/").last, namedDirectory: UsersSettingsPage.getRouteName()),
            ]);
          }
        } else if (path == CreateOrViewPatientPage.viewPatientRoutePath.split("/").last ||
            path == VisitsPage.routePathProfile.split("/").last ||
            path == PatientProfileComplainsPage.routePath.split("/").last)
          siteController.setAppBarWidget(context: context, tabs: [
            SlidingTabModel(
                title: "Patient Data",
                compareName: CreateOrViewPatientPage.viewPatientRoutePath.split("/").last,
                namedDirectory: CreateOrViewPatientPage.getViewRouteName(),
                pathParameters: pathQueries),
            SlidingTabModel(
                title: "Patient Visits",
                compareName: VisitsPage.routePathProfile.split("/").last,
                namedDirectory: VisitsPage.getProfileRouteName(),
                pathParameters: pathQueries),
            SlidingTabModel(
                title: "Complains",
                compareName: PatientProfileComplainsPage.routePath.split("/").last,
                namedDirectory: PatientProfileComplainsPage.getRouteName(),
                pathParameters: pathQueries),
          ]);
        else if (path == PatientsSearchPage.routePath.split("/").last ||
            path == PatientsSearchPage.routeMyPath.split("/").last ||
            path == ComplainsSearchPage.routePath.split("/").last ||
            path == ToDoListsSearchPage.routePath.split("/").last ||
            path == PatientAdvancedSearchPage.routePathPatients.split("/").last ||
            path == PatientAdvancedSearchPage.routePathProsthetic.split("/").last ||
            path == PatientAdvancedSearchPage.routePathTreatments.split("/").last ||
            path == VisitsPage.routePath.split("/").last) {
          if (getRole()!.contains("secretary")) {
            siteController.setAppBarWidget(context: context, tabs: [
              SlidingTabModel(
                  title: "Patient Data",
                  compareName: PatientsSearchPage.routePath.split("/").last,
                  namedDirectory: PatientsSearchPage.getRouteName()),
              SlidingTabModel(
                  title: "Patient Visits", compareName: VisitsPage.routePath.split("/").last, namedDirectory: VisitsPage.getSearchRouteName()),
              SlidingTabModel(
                  title: "Complains", compareName: ComplainsSearchPage.routePath.split("/").last, namedDirectory: ComplainsSearchPage.getRouteName()),
            ]);
          } else {
            siteController.setAppBarWidget(context: context, tabs: [
              SlidingTabModel(
                  title: "Patient Data",
                  compareName: PatientsSearchPage.routePath.split("/").last,
                  namedDirectory: PatientsSearchPage.getRouteName()),
              SlidingTabModel(
                  title: "My Patients",
                  compareName: PatientsSearchPage.routeMyPath.split("/").last,
                  namedDirectory: PatientsSearchPage.getMyRouteName()),
              SlidingTabModel(
                  title: "Patient Visits", compareName: VisitsPage.routePath.split("/").last, namedDirectory: VisitsPage.getSearchRouteName()),
              SlidingTabModel(
                  title: "Complains", compareName: ComplainsSearchPage.routePath.split("/").last, namedDirectory: ComplainsSearchPage.getRouteName()),
              SlidingTabModel(
                  title: "To Do Lists",
                  compareName: ToDoListsSearchPage.routePath.split("/").last,
                  namedDirectory: ToDoListsSearchPage.getRouteName()),
              path == PatientAdvancedSearchPage.routeNameTreatments
                  ? SlidingTabModel(title: "Advanced Search", namedDirectory: PatientAdvancedSearchPage.routeNameTreatments)
                  : path == PatientAdvancedSearchPage.routeNameProsthetic
                      ? SlidingTabModel(title: "Advanced Search", namedDirectory: PatientAdvancedSearchPage.routeNameProsthetic)
                      : SlidingTabModel(title: "Advanced Search", namedDirectory: PatientAdvancedSearchPage.routeNamePatients),
            ]);
          }
        } else if (path == ViewUserProfilePage.candidateRoutePath.split("/").last || path == ViewCandidateData.routePath.split("/").last)
          siteController.setAppBarWidget(context: context, tabs: [
            SlidingTabModel(
                title: "Profile",
                compareName: ViewUserProfilePage.candidateRoutePath.split("/").last,
                namedDirectory: ViewUserProfilePage.candidateRouteName,
                pathParameters: pathQueries),
            SlidingTabModel(
                title: "Data",
                compareName: ViewCandidateData.routePath.split("/").last,
                namedDirectory: ViewCandidateData.routeName,
                pathParameters: pathQueries),
          ]);
        else if (path == CashFlowIncomePage.routePath.split("/").last ||
            path == CashFlowExpensesPage.routePath.split("/").last ||
            path == CashFlowSummaryPage.routePath.split("/").last)
          siteController.setAppBarWidget(context: context, tabs: [
            SlidingTabModel(
                title: "Income", namedDirectory: CashFlowIncomePage.getRouteName(), compareName: CashFlowIncomePage.routePath.split("/").last),
            SlidingTabModel(
                title: "Expenses", namedDirectory: CashFlowExpensesPage.getRouteName(), compareName: CashFlowExpensesPage.routePath.split("/").last),
            SlidingTabModel(
                title: "Summary", namedDirectory: CashFlowSummaryPage.getRouteName(), compareName: CashFlowSummaryPage.routePath.split("/").last),
          ]);
        else if (path == StockSearchPage.routePath.split("/").last || path == StockLogsSearchPage.routePath.split("/").last)
          siteController.setAppBarWidget(context: context, tabs: [
            SlidingTabModel(title: "Stock", namedDirectory: StockSearchPage.getRouteName(), compareName: StockSearchPage.routePath.split("/").last),
            SlidingTabModel(
                title: "Logs", namedDirectory: StockLogsSearchPage.getRouteName(), compareName: StockLogsSearchPage.routePath.split("/").last),
          ]);
        else if (path == PatientMedicalHistory.routePath.split("/").last ||
            path == DentalExaminationPage.routePath.split("/").last ||
            path == ProstheticTreatmentPage.routePath.split("/").last ||
            path == DentalHistoryPage.routePath.split("/").last ||
            path == NonSurgicalTreatmentPage.routePath.split("/").last ||
            path == TreatmentPage.routePath.split("/").last ||
            path == SurgicalTreatmentPage.routePath.split("/").last ||
            path == ComplicationsAfterSurgeryPage.routePath.split("/").last ||
            path == ComplicationsAfterProsthesisPage.routePath.split("/").last ||
            path == ClinicTreatmentPage.routePath.split("/").last ||
            path == ClinicTreatmentPage.routePathPlan.split("/").last)
          setMedicalAppBar(id: int.parse(pathQueries!['id']!), context: context);
        else
          setAppBarWidget(context: context);
      } else if (siteController.getSite() == Website.Lab) {
        if ((path == SettingsPage.routePath.split("/").last && getRole()!.contains("admin")) ||
            (path == LabItemSettingsPage.routePath.split("/").last && getRole()!.contains("admin")) ||
            (path == UsersSettingsPage.routePath.split("/").last && getRole()!.contains("admin"))) {
          siteController.setAppBarWidget(context: context, tabs: [
            SlidingTabModel(title: "Settings", compareName: SettingsPage.routePath.split("/").last, namedDirectory: SettingsPage.getRouteName()),
            SlidingTabModel(title: "Lab Items", compareName: LabItemSettingsPage.routePath, namedDirectory: LabItemSettingsPage.routeName),
            SlidingTabModel(
                title: "Users", compareName: UsersSettingsPage.routePath.split("/").last, namedDirectory: UsersSettingsPage.getRouteName()),
          ]);
        } else if (path == LabRequestsSearchPage.routePath.split("/").last ||
            path == LabRequestsSearchPage.routeAllPath.split("/").last ||
            path == LabRequestsSearchPage.routeMyPath.split("/").last) {
          if (siteController.getRole()!.contains("technician")) {
            siteController.setAppBarWidget(context: context, tabs: [
              SlidingTabModel(
                  title: "Today's Request",
                  compareName: LabRequestsSearchPage.routePath.split("/").last,
                  namedDirectory: LabRequestsSearchPage.routeName),
              SlidingTabModel(
                  title: "All Requests",
                  compareName: LabRequestsSearchPage.routeAllPath.split("/").last,
                  namedDirectory: LabRequestsSearchPage.routeAllName),
              SlidingTabModel(
                  title: "My Requests",
                  compareName: LabRequestsSearchPage.routeMyPath.split("/").last,
                  namedDirectory: LabRequestsSearchPage.routeMyName),
            ]);
          } else {
            siteController.setAppBarWidget(context: context, tabs: [
              SlidingTabModel(
                  title: "Today's Request",
                  compareName: LabRequestsSearchPage.routePath.split("/").last,
                  namedDirectory: LabRequestsSearchPage.routeName),
              SlidingTabModel(
                  title: "All Requests",
                  compareName: LabRequestsSearchPage.routeAllPath.split("/").last,
                  namedDirectory: LabRequestsSearchPage.routeAllName),
            ]);
          }
        } else if (path == StockSearchPage.routePath.split("/").last || path == StockLogsSearchPage.routePath.split("/").last)
          siteController.setAppBarWidget(context: context, tabs: [
            SlidingTabModel(title: "Stock", namedDirectory: StockSearchPage.getRouteName(), compareName: StockSearchPage.routePath.split("/").last),
            SlidingTabModel(
                title: "Logs", namedDirectory: StockLogsSearchPage.getRouteName(), compareName: StockLogsSearchPage.routePath.split("/").last),
          ]);
        else if (path == CashFlowIncomePage.routePath.split("/").last ||
            path == CashFlowExpensesPage.routePath.split("/").last ||
            path == CashFlowSummaryPage.routePath.split("/").last)
          siteController.setAppBarWidget(context: context, tabs: [
            SlidingTabModel(
                title: "Income", namedDirectory: CashFlowIncomePage.getRouteName(), compareName: CashFlowIncomePage.routePath.split("/").last),
            SlidingTabModel(
                title: "Expenses", namedDirectory: CashFlowExpensesPage.getRouteName(), compareName: CashFlowExpensesPage.routePath.split("/").last),
            SlidingTabModel(
                title: "Summary", namedDirectory: CashFlowSummaryPage.getRouteName(), compareName: CashFlowSummaryPage.routePath.split("/").last),
          ]);
        else
          setAppBarWidget(context: context);
      } else
        setAppBarWidget(context: context);
    });
  }

  setMedicalAppBar({required int id, required BuildContext context}) async {
    var path = GoRouterState.of(context).fullPath!.split("/").last;
    List<MedicalSlidingModel> pages = [];
    if (getSite() == Website.CIA) {
      pages = [
        MedicalSlidingModel(
            name: "Medical History", onTap: () => context.goNamed(PatientMedicalHistory.getRouteName(), pathParameters: {"id": id.toString()})),
        MedicalSlidingModel(
            name: "Dental History", onTap: () => context.goNamed(DentalHistoryPage.getRouteName(), pathParameters: {"id": id.toString()})),
        MedicalSlidingModel(
            name: "Dental Examination", onTap: () => context.goNamed(DentalExaminationPage.getRouteName(), pathParameters: {"id": id.toString()})),
        MedicalSlidingModel(
            name: "Non Surgical Treatment",
            onTap: () => context.goNamed(NonSurgicalTreatmentPage.getRouteName(), pathParameters: {"id": id.toString()}),
            onSave: () async {
              //   if (!siteController.disableMedicalEdit.value) {
              //    await MedicalAPI.AddPatientNonSurgicalTreatment(id, nonSurgicalTreatment);
              //   await MedicalAPI.UpdatePatientDentalExamination(id, tempDentalExamination);
              // }
            }),
        MedicalSlidingModel(
            name: "Treatment Plan",
            onTap: () => context.goNamed(TreatmentPage.getRouteName(), pathParameters: {"id": id.toString()}),
            onSave: () async {
              //   if (!siteController.disableMedicalEdit.value) await MedicalAPI.UpdatePatientTreatmentPlan(id, treatmentPlanModel!.treatmentPlan!);
            }),
        MedicalSlidingModel(
            name: "Surgical Treatment",
            onTap: () => context.goNamed(SurgicalTreatmentPage.getRouteName(), pathParameters: {"id": id.toString()}),
            onSave: () async {
              // if (!siteController.disableMedicalEdit.value) await MedicalAPI.UpdatePatientSurgicalTreatment(id, surgicalTreatmentModel);
            }),
        MedicalSlidingModel(
            name: "Surgical Complications",
            onTap: () => context.goNamed(ComplicationsAfterSurgeryPage.getRouteName(), pathParameters: {"id": id.toString()}),
            onSave: () async {
              // if (!siteController.disableMedicalEdit.value) await MedicalAPI.UpdatePatientSurgicalTreatment(id, surgicalTreatmentModel);
            }),
        MedicalSlidingModel(
            name: "Prosthetic Treatment",
            onTap: () => context.goNamed(ProstheticTreatmentPage.routeName, pathParameters: {"id": id.toString()}),
            onSave: () {}),
        MedicalSlidingModel(
            name: "Prosthetic Complications",
            onTap: () => context.goNamed(ComplicationsAfterProsthesisPage.getRouteName(), pathParameters: {"id": id.toString()}),
            onSave: () async {
              // if (!siteController.disableMedicalEdit.value) await MedicalAPI.UpdatePatientSurgicalTreatment(id, surgicalTreatmentModel);
            }),
      ];
    } else if (getSite() == Website.Clinic) {
      pages = [
        MedicalSlidingModel(
            name: "Medical History", onTap: () => context.goNamed(PatientMedicalHistory.getRouteName(), pathParameters: {"id": id.toString()})),
        MedicalSlidingModel(
            name: "Dental History", onTap: () => context.goNamed(DentalHistoryPage.getRouteName(), pathParameters: {"id": id.toString()})),
        MedicalSlidingModel(
            name: "Dental Examination", onTap: () => context.goNamed(DentalExaminationPage.getRouteName(), pathParameters: {"id": id.toString()})),
        MedicalSlidingModel(
            name: "Clinic Treatments Plan",
            onTap: () => context.goNamed(ClinicTreatmentPage.routeNamePlan, pathParameters: {"id": id.toString()}),
            onSave: () async {
              //   if (!siteController.disableMedicalEdit.value) await MedicalAPI.UpdatePatientTreatmentPlan(id, treatmentPlanModel!.treatmentPlan!);
            }),
        MedicalSlidingModel(
            name: "Clinic Treatments",
            onTap: () => context.goNamed(ClinicTreatmentPage.routeName, pathParameters: {"id": id.toString()}),
            onSave: () async {
              //   if (!siteController.disableMedicalEdit.value) await MedicalAPI.UpdatePatientTreatmentPlan(id, treatmentPlanModel!.treatmentPlan!);
            }),
      ];
    }
    for (var element in pages) {
      if (element!.name!.removeAllWhitespace.toString().toLowerCase() == path.toLowerCase()) {
        element.isSelected = true;
        // title = element.name;
        break;
      }
    }
    var bar = MedicalSlidingBar(key: new GlobalKey(), pages: pages);

    sl<AppBarBloc>().add(AppBarChangeAppBarEvent(newAppBar: bar));
    //await Future.delayed(Duration(milliseconds: 1));
    //update();
  }

  Website getSite() => Website.values[sl<SharedPreferences>().getInt("Website") ?? 0];

  AssetImage getSiteLogo() => _siteLogo;

  AssetImage getSiteLogoBySite(Website site) {
    if (site == Website.CIA) {
      return AssetImage("assets/CIA_Logo3.png");
    } else if (site == Website.Lab)
      return AssetImage("assets/LAB_Logo.png");
    else
      return AssetImage("assets/Clinic_logo.png");
  }

  setSite(Website site) {
    switchTheme(site);
    sl<SharedPreferences>().setInt("Website", site.index);
    if (site == Website.CIA) {
      _siteLogo = AssetImage("assets/CIA_Logo3.png");
    } else if (site == Website.Lab)
      _siteLogo = AssetImage("assets/LAB_Logo.png");
    else
      _siteLogo = AssetImage("assets/Clinic_logo.png");
  }

  setRole(List<String> role) {
    sl<SharedPreferences>().setStringList("role", role);
  }

  setToken(String token) async {
    sl<SharedPreferences>().setString("token", token);
  }

  bool isLoggedIn() {
    return getRole() != null && getUserName() != null && getUserId() != null && getToken() != null;
  }

  clearCach() async {
    sl<SharedPreferences>().clear();
  }

  String? getToken() {
    return sl<SharedPreferences>().getString("token");
    var d = DateTime.now().toUtc().millisecondsSinceEpoch.toString();
    var token = encryptString("${sl<SharedPreferences>().getString("token")}omar${d}");
    return token;
    //  return sl<SharedPreferences>().getString("token");
  }

  String encryptString(String plainText) {
    final key = getHashSha256("owbm3297Enemy");
    final iv = Uint8List.fromList(List.filled(16, 0)); // Initialization vector for AES

    final cipher = PaddedBlockCipher("AES/CBC/PKCS7");
    final keyParam = KeyParameter(key);
    final params = ParametersWithIV(keyParam, iv);

    cipher.init(true, PaddedBlockCipherParameters(params, null));

    final encryptedBytes = cipher.process(utf8.encode(plainText));
    return base64.encode(encryptedBytes);
  }

  Uint8List getHashSha256(String text) {
    final sha256 = SHA256Digest();
    final bytes = utf8.encode(text);
    return Uint8List.fromList(sha256.process(bytes));
  }

  List<String>? getRole() => sl<SharedPreferences>().getStringList("role");

  int? getProfileImageId() => sl<SharedPreferences>().getInt("profileImageId");

  setProfileImageId(int id) => sl<SharedPreferences>().setInt("profileImageId", id);

  List<String> getDefaultRoles() {
    if (getSite() == Website.CIA) {
      return _CIA_Roles;
    } else if (getSite() == Website.Lab)
      return _Lab_Roles;
    else
      return _Clinic_Roles;
  }

  String? getUserName() => sl<SharedPreferences>().getString("userName");

  int? getUserId() => sl<SharedPreferences>().getInt("userid");

  String? getUserPhoneNumber() => sl<SharedPreferences>().getString("phoneNumber");
}
