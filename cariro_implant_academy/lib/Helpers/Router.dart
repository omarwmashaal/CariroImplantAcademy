import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/PatientMedicalController.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/Pages/Authentication/AuthenticationPage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/PatientAdvancedSearchPage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/PatientsSearchPage.dart';
import 'package:cariro_implant_academy/Pages/SharedPages/CashFlowSharedPage.dart';
import 'package:cariro_implant_academy/Pages/SharedPages/StocksSharedPage.dart';
import 'package:cariro_implant_academy/Pages/UsersSearchPage.dart';
import 'package:cariro_implant_academy/Widgets/LargeScreen.dart';
import 'package:cariro_implant_academy/Widgets/SiteLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../Pages/CIA_Pages/CIA_MyProfilePage.dart';
import '../Pages/CIA_Pages/CIA_SettingsPage.dart';
import '../Pages/CIA_Pages/Patient_MedicalInfo.dart';
import '../Pages/CIA_Pages/ViewUserPage.dart';
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
            GoRoute(
              name: "CIA",
              path: "CIA",
              builder: (context, state) {
                return Scaffold(body: AuthenticationPage());
              },
                redirect: (context, state) {
                  if(siteController.getToken()=="")
                    {
                     // return "/";
                    }
                },
              routes: [
                ShellRoute(
                  builder: (context, state, child) {
                    print("Before app bar");
                    siteController.setDynamicAppBar(context: context, pathQueries: state.pathParameters);
                    ("after app bar");
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
                          print("search router");
                          return NoTransitionPage(
                            child: PatientsSearchPage(),
                          );
                        },
                        routes: [
                          GoRoute(
                            name: PatientInfo_SharedPage.addPatientRouteName,
                            path: PatientInfo_SharedPage.addPatientRoutePath,
                            pageBuilder: (context, state) {
                              return NoTransitionPage(
                                  child: PatientInfo_SharedPage(
                                    patientID: 0,
                                  ));
                            },
                          ),
                        ]),
                    GoRoute(
                      path: PatientsSearchPage.myPatientsRouteName,
                      name: PatientsSearchPage.myPatientsRouteName,
                      pageBuilder: (context, state) {
                        print("search router");
                        return NoTransitionPage(
                          child: PatientsSearchPage(myPatients: true),
                        );
                      },
                    ),
                    GoRoute(
                      path: PatientsComplainsPage.routeName,
                      name: PatientsComplainsPage.routeName,
                      pageBuilder: (context, state) {
                        print("search router");
                        return NoTransitionPage(
                          child: PatientsComplainsPage(),
                        );
                      },
                    ),
                    GoRoute(
                      path: PatientAdvancedSearchPage.routePath,
                      name: PatientAdvancedSearchPage.routeName,
                      pageBuilder: (context, state) {
                        return NoTransitionPage(
                          child: PatientAdvancedSearchPage(),
                        );
                      },
                    ),
                    GoRoute(
                      path: PatientAdvancedSearchPage.routeNameTreatmentsPath,
                      name: PatientAdvancedSearchPage.routeNameTreatments,
                      pageBuilder: (context, state) {
                        return NoTransitionPage(
                          child: PatientAdvancedSearchPage(treatments: true,),
                        );
                      },
                    ),
                    GoRoute(
                      name: routeConst_PatientInfo,
                      path: "CIA/Patients/:id",
                      redirect: (context, state) {
                        if (siteController.getRole() == "secretary") return PatientInfo_SharedPage.getPathViewPatient(state.pathParameters['id'].toString());
                        return PatientMedicalHistory.getPath(state.pathParameters['id'].toString());
                      },
                    ),
                    GoRoute(
                      path: PatientInfo_SharedPage.viewPatientRoutePath,
                      name: PatientInfo_SharedPage.viewPatientRouteName,
                      pageBuilder: (context, state) {
                        return NoTransitionPage(
                          child: PatientInfo_SharedPage(
                            patientID: int.parse(state.pathParameters['id'].toString()),
                            loadFunction: PatientAPI.GetPatientData,
                          ),
                        );
                      },
                    ),
                    GoRoute(
                      path: PatientVisits_SharedPage.routePath,
                      name: PatientVisits_SharedPage.routeName,
                      pageBuilder: (context, state) {
                        return NoTransitionPage(
                          child: PatientVisits_SharedPage(
                            patientID: int.parse(state.pathParameters['id'].toString()),
                          ),
                        );
                      },
                    ),
                    GoRoute(
                      path: PatientComplains.routePath,
                      name: PatientComplains.routeName,
                      pageBuilder: (context, state) {
                        return NoTransitionPage(
                          child: PatientComplains(
                            patientId: int.parse(state.pathParameters['id'].toString()),
                          ),
                        );
                      },
                    ),
                    GoRoute(
                      path: UserSearchPage.assistantsRouteName,
                      name: UserSearchPage.assistantsRouteName,
                      pageBuilder: (context, state) => NoTransitionPage(
                        child: UserSearchPage(
                          dataSource: ApplicationUserDataSource(type: UserRoles.Assistant),
                        ),
                      ),
                    ),
                    GoRoute(
                      path: UserSearchPage.instructorsRouteName,
                      name: UserSearchPage.instructorsRouteName,
                      pageBuilder: (context, state) => NoTransitionPage(
                        child: UserSearchPage(
                          dataSource: ApplicationUserDataSource(type: UserRoles.Instructor),
                        ),
                      ),
                    ),
                    GoRoute(
                      path: UserSearchPage.candidatesRouteName,
                      name: UserSearchPage.candidatesRouteName,
                      pageBuilder: (context, state) => NoTransitionPage(
                        child: UserSearchPage(
                          dataSource: ApplicationUserDataSource(type: UserRoles.Candidate),
                        ),
                      ),
                    ),
                    GoRoute(
                      path: ViewUserData.routePath,
                      name: ViewUserData.routeName,
                      pageBuilder: (context, state) => NoTransitionPage(
                        child: ViewUserData(
                          userId: int.parse(state.pathParameters['id']!),

                        ),
                      ),
                    ),
                    GoRoute(
                      path: ViewUserData.candidateRoutePath,
                      name: ViewUserData.candidateRouteName,
                      pageBuilder: (context, state) => NoTransitionPage(
                        child: ViewUserData(
                          userId: int.parse(state.pathParameters['id']!),

                        ),
                      ),
                    ),GoRoute(
                      path: ViewCandidateData.routePath,
                      name: ViewCandidateData.routeName,
                      pageBuilder: (context, state) => NoTransitionPage(
                        child: ViewCandidateData(
                          userId: int.parse(state.pathParameters['id']!),

                        ),
                      ),
                    ),
                    GoRoute(
                      path: StockListSharedPage.routeName,
                      name: StockListSharedPage.routeName,
                      pageBuilder: (context, state) => NoTransitionPage(
                        child: StockListSharedPage(
                        ),
                      ),
                    ),
                    GoRoute(
                      path: StockLogsSharedPage.routeName,
                      name: StockLogsSharedPage.routeName,
                      pageBuilder: (context, state) => NoTransitionPage(
                        child: StockLogsSharedPage(
                        ),
                      ),
                    ),
                    GoRoute(
                      path: CashFlowIncomeSharedPage.routeName,
                      name: CashFlowIncomeSharedPage.routeName,
                      pageBuilder: (context, state) => NoTransitionPage(
                        child: CashFlowIncomeSharedPage(
                        ),
                      ),
                    ),
                    GoRoute(
                      path: CashFlowExpensesSharedPage.routeName,
                      name: CashFlowExpensesSharedPage.routeName,
                      pageBuilder: (context, state) => NoTransitionPage(
                        child: CashFlowExpensesSharedPage(
                        ),
                      ),
                    ),
                    GoRoute(
                      path: CashFlowSummarySharedPage.routeName,
                      name: CashFlowSummarySharedPage.routeName,
                      pageBuilder: (context, state) => NoTransitionPage(
                        child: CashFlowSummarySharedPage(
                        ),
                      ),
                    ),
                    GoRoute(
                      path: SettingsPage.routePath,
                      name: SettingsPage.routeName,
                      pageBuilder: (context, state) {
                        return NoTransitionPage(
                          child: SettingsPage(),
                        );
                      },
                    ),
                    GoRoute(
                      path: CIA_MyProfilePage.routePath,
                      name: CIA_MyProfilePage.routeName,
                      pageBuilder: (context, state) {
                        return NoTransitionPage(
                          child: CIA_MyProfilePage(),
                        );
                      },
                    ),
                    GoRoute(
                      path: UsersSettingsPage.routePath,
                      name: UsersSettingsPage.routeName,
                      pageBuilder: (context, state) {
                        return NoTransitionPage(
                          child: UsersSettingsPage(),
                        );
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
                              print("medical router");
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
                          GoRoute(
                            name: PatientNonSurgicalTreatment.routeName,
                            path: PatientNonSurgicalTreatment.routePath,
                            pageBuilder: (context, state) {
                              return NoTransitionPage(
                                child: PatientNonSurgicalTreatment(
                                  patientId: int.parse(state.pathParameters['id'].toString()),
                                ),
                              );
                            },
                          ),
                          GoRoute(
                            name: PatientTreatmentPlan.routeName,
                            path: PatientTreatmentPlan.routePath,
                            pageBuilder: (context, state) {
                              return NoTransitionPage(
                                child: PatientTreatmentPlan(
                                  patientId: int.parse(state.pathParameters['id'].toString()),
                                ),
                              );
                            },
                          ),
                          GoRoute(
                            name: PatientSurgicalTreatment.routeName,
                            path: PatientSurgicalTreatment.routePath,
                            pageBuilder: (context, state) {
                              return NoTransitionPage(
                                child: PatientSurgicalTreatment(
                                  patientId: int.parse(state.pathParameters['id'].toString()),
                                ),
                              );
                            },
                          ),
                          GoRoute(
                            name: PatientProstheticTreatment.routeName,
                            path: PatientProstheticTreatment.routePath,
                            pageBuilder: (context, state) {
                              return NoTransitionPage(
                                child: PatientProstheticTreatment(
                                  patientId: int.parse(state.pathParameters['id'].toString()),
                                ),
                              );
                            },
                          ),
                        ]),
                  ],
                )
              ]
            ),
          ]),
    ],
  );
}
