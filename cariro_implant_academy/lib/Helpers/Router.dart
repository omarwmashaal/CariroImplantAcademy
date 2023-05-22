import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/PatientMedicalController.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/Pages/Authentication/AuthenticationPage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/PatientsSearchPage.dart';
import 'package:cariro_implant_academy/Pages/UsersSearchPage.dart';
import 'package:cariro_implant_academy/Widgets/LargeScreen.dart';
import 'package:cariro_implant_academy/Widgets/SiteLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../Pages/CIA_Pages/Patient_MedicalInfo.dart';
import '../Pages/SharedPages/PatientSharedPages.dart';

class CIA_Router {
  static var shellNavigationKey = GlobalKey<NavigatorState>();
  static var rootNavigationKey = GlobalKey<NavigatorState>();
  static var routeConst_PatientInfo = "PatientInfo";

  static GoRouter routes = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
          name: "/",
          path: "/",
          builder: (context, state) {
            return Scaffold(body: AuthenticationPage());
          },
          routes: [
            ShellRoute(
              builder: (context, state, child) {
                return SiteLayout(
                    largeScreen: Scaffold(
                        body: CIA_LargeScreen(
                  child: child,
                )));
              },
              routes: [
                GoRoute(
                    path: PatientsSearchPage.routeName,
                    name: PatientsSearchPage.routeName,
                    pageBuilder: (context, state) {
                      return NoTransitionPage(
                        child: PatientsSearchPage(),
                      );
                    },
                    routes: [
                      GoRoute(
                        name: routeConst_PatientInfo,
                        path: "Patient/:id",
                        redirect: (context, state) {
                          if (siteController.getRole() == "secretary") return PatientInfo_SharedPage.getPath(state.pathParameters['id'].toString());
                          return PatientMedicalHistory.getPath(state.pathParameters['id'].toString());
                        },
                      ),
                      GoRoute(
                        path: PatientInfo_SharedPage.routePath,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                              child: PatientInfo_SharedPage(
                                patientID: int.parse(state.pathParameters['id'].toString()),
                                loadFunction: PatientAPI.GetPatientData,
                              ),);
                        },
                      ),
                      ShellRoute(
                          pageBuilder: (context, state, child) {
                            return NoTransitionPage(
                              child: PatientMedicalInfoPage(patientId: int.parse(state.pathParameters['id'].toString()), child: child),
                            );
                          },
                          routes: [
                            GoRoute(
                              name: PatientMedicalHistory.routeName,
                              path: PatientMedicalHistory.routePath,
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                  child: PatientMedicalHistory(
                                    patientId: int.parse(state.pathParameters['id'].toString()),
                                  ),
                                );
                              },
                            ),
                            GoRoute(
                              name: PatientDentalHistory.routeName,
                              path: PatientDentalHistory.routePath,
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                  child: PatientDentalHistory(
                                    patientId: int.parse(state.pathParameters['id'].toString()),
                                  ),
                                );
                              },
                            ),
                            GoRoute(
                              name: PatientDentalExamination.routeName,
                              path: PatientDentalExamination.routePath,
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                  child: PatientDentalExamination(
                                    patientId: int.parse(state.pathParameters['id'].toString()),
                                  ),
                                );
                              },
                            ),
                          ]),
                    ]),
                GoRoute(
                  path: "${UserSearchPage.routeName}",
                  name: UserSearchPage.routeName,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: UserSearchPage(
                      dataSource: ApplicationUserDataSource(type: UserRoles.Assistant),
                    ),
                  ),
                ),
              ],
            ),
          ]),
    ],
  );
}
