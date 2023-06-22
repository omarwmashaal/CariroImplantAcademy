import 'package:cariro_implant_academy/API/AuthenticationAPI.dart';
import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/PatientMedicalController.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/Pages/Authentication/AuthenticationPage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/PatientAdvancedSearchPage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/PatientsSearchPage.dart';
import 'package:cariro_implant_academy/Pages/LAB_Pages/LAB_LabRequestsSearch.dart';
import 'package:cariro_implant_academy/Pages/LAB_Pages/LAB_ViewRequest.dart';
import 'package:cariro_implant_academy/Pages/LAB_Pages/LAB_ViewTask.dart';
import 'package:cariro_implant_academy/Pages/SharedPages/CashFlowSharedPage.dart';
import 'package:cariro_implant_academy/Pages/SharedPages/LapCreateNewRequestSharedPage.dart';
import 'package:cariro_implant_academy/Pages/SharedPages/StocksSharedPage.dart';
import 'package:cariro_implant_academy/Pages/UsersSearchPage.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/LargeScreen.dart';
import 'package:cariro_implant_academy/Widgets/SiteLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/CIA_Pages/CIA_MyProfilePage.dart';
import '../Pages/CIA_Pages/CIA_SettingsPage.dart';
import '../Pages/CIA_Pages/PatientVisits.dart';
import '../Pages/CIA_Pages/Patient_MedicalInfo.dart';
import '../Pages/CIA_Pages/ViewUserPage.dart';
import '../Pages/LAB_Pages/LAB_MyTasks.dart';
import '../Pages/NotificationsPage.dart';
import '../Pages/SharedPages/PatientSharedPages.dart';

class CIA_Router {
  static var shellNavigationKey = GlobalKey<NavigatorState>();
  static var rootNavigationKey = GlobalKey<NavigatorState>();
  static var routeConst_PatientInfo = "PatientInfo";
  static var routeConst_LabView = "GoToLabRequest";

  static GoRouter routes = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
          name: "/",
          path: "/",
          builder: (context, state) {
            return Scaffold(body: AuthenticationPage());
          },
          redirect: (context, state) async {
            if (await siteController.getToken() == "") {
              return "/";
            }
          },
          routes: [
            GoRoute(
                name: "CIA",
                path: "CIA",
                builder: (context, state) {
                  siteController.setSite(Website.CIA);
                  return Scaffold(body: AuthenticationPage());
                },
                redirect: (context, state) async {
                  var res = await AuthenticationAPI.VerifyToken();
                  if (
                  await siteController.getToken() == "" ||
                      !(
                          siteController.getRole()=="admin"||
                          siteController.getRole()=="secretary"||
                          siteController.getRole()=="instructor"||
                          siteController.getRole()=="assistant"
                      )

                  ) {
                    return "/";
                  }
                },
                routes: [
                  ShellRoute(
                    builder: (context, state, child) {
                      siteController.setDynamicAppBar(context: context, pathQueries: state.pathParameters);
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
                          return NoTransitionPage(
                            child: _Authorize(
                              allowedRoles: [
                                UserRoles.Instructor,
                                UserRoles.Assistant,
                                UserRoles.Admin,
                              ],
                              child: PatientsSearchPage(myPatients: true),
                            ),
                          );
                        },
                      ),
                       GoRoute(
                        path: PatientVisits.routeName,
                        name: PatientVisits.routePath,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: PatientVisits(),
                          );
                        },
                      ),

                      GoRoute(
                        path: PatientsComplainsPage.routeName,
                        name: PatientsComplainsPage.routeName,
                        pageBuilder: (context, state) {
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
                            child: _Authorize(allowedRoles: [
                              UserRoles.Instructor,
                              UserRoles.Assistant,
                              UserRoles.Admin,
                            ], child: PatientAdvancedSearchPage()),
                          );
                        },
                      ),
                      GoRoute(
                        path: PatientAdvancedSearchPage.routeNameTreatmentsPath,
                        name: PatientAdvancedSearchPage.routeNameTreatments,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: _Authorize(
                              allowedRoles: [
                                UserRoles.Instructor,
                                UserRoles.Assistant,
                                UserRoles.Admin,
                              ],
                              child: PatientAdvancedSearchPage(
                                treatments: true,
                              ),
                            ),
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
                      ),
                      GoRoute(
                        path: ViewCandidateData.routePath,
                        name: ViewCandidateData.routeName,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: ViewCandidateData(
                            userId: int.parse(state.pathParameters['id']!),
                          ),
                        ),
                      ),
                      GoRoute(
                        path: StockListSharedPage.routePath,
                        name: StockListSharedPage.routeCIAname,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: StockListSharedPage(),
                        ),
                      ),
                      GoRoute(
                        path: StockLogsSharedPage.routePath,
                        name: StockLogsSharedPage.routeCIAname,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: StockLogsSharedPage(),
                        ),
                      ),
                      GoRoute(
                        path: CashFlowIncomeSharedPage.routePath,
                        name: CashFlowIncomeSharedPage.routeCIAname,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: CashFlowIncomeSharedPage(),
                        ),
                      ),
                      GoRoute(
                        path: CashFlowExpensesSharedPage.routePath,
                        name: CashFlowExpensesSharedPage.routeCIAname,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: CashFlowExpensesSharedPage(),
                        ),
                      ),
                      GoRoute(
                        path: CashFlowSummarySharedPage.routePath,
                        name: CashFlowSummarySharedPage.routeCIAname,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: CashFlowSummarySharedPage(),
                        ),
                      ),
                      GoRoute(
                        path: SettingsPage.routePath,
                        name: SettingsPage.routeName,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: _Authorize(allowedRoles: [
                              UserRoles.Admin,
                            ], child: SettingsPage()),
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
                            child: _Authorize(allowedRoles: [
                              UserRoles.Admin,
                            ], child: UsersSettingsPage()),
                          );
                        },
                      ),
                      GoRoute(
                        path: NotificationsPage.routePath,
                        name: NotificationsPage.routeName,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: NotificationsPage(),
                          );
                        },
                      ),
                      ShellRoute(
                          pageBuilder: (context, state, child) {
                            return NoTransitionPage(
                              child: _Authorize(allowedRoles: [
                                UserRoles.Instructor,
                                UserRoles.Assistant,
                                UserRoles.Admin,
                              ], child: PatientMedicalInfoPage(patientId: int.parse(state.pathParameters['id'].toString()), child: child)),
                            );
                          },
                          routes: [
                            GoRoute(
                              name: PatientMedicalHistory.routeName,
                              path: PatientMedicalHistory.routePath,
                              pageBuilder: (context, state) {

                                return NoTransitionPage(
                                  child: _Authorize(
                                    allowedRoles: [
                                      UserRoles.Instructor,
                                      UserRoles.Assistant,
                                      UserRoles.Admin,
                                    ],
                                    child: PatientMedicalHistory(
                                      patientId: int.parse(state.pathParameters['id'].toString()),
                                    ),
                                  ),
                                );
                              },
                            ),
                            GoRoute(
                              name: PatientDentalHistory.routeName,
                              path: PatientDentalHistory.routePath,
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                  child: _Authorize(
                                    allowedRoles: [
                                      UserRoles.Instructor,
                                      UserRoles.Assistant,
                                      UserRoles.Admin,
                                    ],
                                    child: PatientDentalHistory(
                                      patientId: int.parse(state.pathParameters['id'].toString()),
                                    ),
                                  ),
                                );
                              },
                            ),
                            GoRoute(
                              name: PatientDentalExamination.routeName,
                              path: PatientDentalExamination.routePath,
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                  child: _Authorize(
                                    allowedRoles: [
                                      UserRoles.Instructor,
                                      UserRoles.Assistant,
                                      UserRoles.Admin,
                                    ],
                                    child: PatientDentalExamination(
                                      patientId: int.parse(state.pathParameters['id'].toString()),
                                    ),
                                  ),
                                );
                              },
                            ),
                            GoRoute(
                              name: PatientNonSurgicalTreatment.routeName,
                              path: PatientNonSurgicalTreatment.routePath,
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                  child: _Authorize(
                                    allowedRoles: [
                                      UserRoles.Instructor,
                                      UserRoles.Assistant,
                                      UserRoles.Admin,
                                    ],
                                    child: PatientNonSurgicalTreatment(
                                      patientId: int.parse(state.pathParameters['id'].toString()),
                                    ),
                                  ),
                                );
                              },
                            ),
                            GoRoute(
                              name: PatientTreatmentPlan.routeName,
                              path: PatientTreatmentPlan.routePath,
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                  child: _Authorize(
                                    allowedRoles: [
                                      UserRoles.Instructor,
                                      UserRoles.Assistant,
                                      UserRoles.Admin,
                                    ],
                                    child: PatientTreatmentPlan(
                                      patientId: int.parse(state.pathParameters['id'].toString()),
                                    ),
                                  ),
                                );
                              },
                            ),
                            GoRoute(
                              name: PatientSurgicalTreatment.routeName,
                              path: PatientSurgicalTreatment.routePath,
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                  child: _Authorize(
                                    allowedRoles: [
                                      UserRoles.Instructor,
                                      UserRoles.Assistant,
                                      UserRoles.Admin,
                                    ],
                                    child: PatientSurgicalTreatment(
                                      patientId: int.parse(state.pathParameters['id'].toString()),
                                    ),
                                  ),
                                );
                              },
                            ),
                            GoRoute(
                              name: PatientProstheticTreatment.routeName,
                              path: PatientProstheticTreatment.routePath,
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                  child: _Authorize(
                                    allowedRoles: [
                                      UserRoles.Instructor,
                                      UserRoles.Assistant,
                                      UserRoles.Admin,
                                    ],
                                    child: PatientProstheticTreatment(
                                      patientId: int.parse(state.pathParameters['id'].toString()),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ]),
                    ],
                  )
                ]),
            GoRoute(
                name: "LAB",
                path: "LAB",
                builder: (context, state) {
                  siteController.setSite(Website.Lab);
                  return Scaffold(body: AuthenticationPage());
                },
                redirect: (context, state) async {
                  var res = await AuthenticationAPI.VerifyToken();
                  if (
                  await siteController.getToken() == "" ||
                      !(
                          siteController.getRole()=="admin"||
                              siteController.getRole()=="secretary"||
                              siteController.getRole()=="technician"
                      )

                  ) {
                    return "/";
                  }
                },
                routes: [
                  ShellRoute(
                    builder: (context, state, child) {
                      siteController.setDynamicAppBar(context: context, pathQueries: state.pathParameters);
                      return SiteLayout(
                          largeScreen: Scaffold(
                              body: CIA_LargeScreen(
                        child: child,
                      )));
                    },
                    routes: [
                      GoRoute(
                        path: LabTodaysRequestsSearch.routePath,
                        name: LabTodaysRequestsSearch.routeName,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: LabTodaysRequestsSearch(),
                          );
                        },
                      ),
                      GoRoute(
                        path: LabAllRequestsSearch.routePath,
                        name: LabAllRequestsSearch.routeName,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: LabAllRequestsSearch(),
                          );
                        },
                      ),
                      GoRoute(
                        path: LabAllRequestsSearch.routeMyPath,
                        name: LabAllRequestsSearch.routeMyName,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: LabAllRequestsSearch(myRequests: true),
                          );
                        },
                      ),
                      GoRoute(
                        path: LabCreateNewRequestSharedPage.routePath,
                        name: LabCreateNewRequestSharedPage.routeName,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: LabCreateNewRequestSharedPage(),
                          );
                        },
                      ),
                      GoRoute(
                          path: "Requests/:id",
                          name: routeConst_LabView,
                          redirect: (context, state) {
                            if (siteController.getRole() == "technician")
                              return "/LAB/Requests/${state.pathParameters['id']}/${LAB_ViewTaskPage.routePath}";
                            else
                              return "/LAB/Requests/${state.pathParameters['id']}/${LAB_ViewRequestPage.routePath}";
                          },
                          routes: [
                            GoRoute(
                              path: LAB_ViewRequestPage.routePath,
                              name: LAB_ViewRequestPage.routeName,
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                  child: LAB_ViewRequestPage(
                                    id: int.parse(state.pathParameters['id']!),
                                  ),
                                );
                              },
                            ),
                            GoRoute(
                              path: LAB_ViewTaskPage.routePath,
                              name: LAB_ViewTaskPage.routeName,
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                  child: LAB_ViewTaskPage(
                                    id: int.parse(state.pathParameters['id']!),
                                  ),
                                );
                              },
                            ),
                          ]),
                      GoRoute(
                        path: UserSearchPage.techniciansRouteName,
                        name: UserSearchPage.techniciansRouteName,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: _Authorize(
                            allowedRoles: [UserRoles.Admin,UserRoles.Secretary],
                            child: UserSearchPage(
                              dataSource: ApplicationUserDataSource(type: UserRoles.Technician),
                            ),
                          ),
                        ),
                      ),
                      GoRoute(
                        path: UserSearchPage.outSourceRouteName,
                        name: UserSearchPage.outSourceRouteName,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: UserSearchPage(
                            dataSource: ApplicationUserDataSource(type: UserRoles.OutSource),
                          ),
                        ),
                      ),
                      GoRoute(
                        path: StockListSharedPage.routePath,
                        name: StockListSharedPage.routeLABname,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: StockListSharedPage(),
                        ),
                      ),
                      GoRoute(
                        path: StockLogsSharedPage.routePath,
                        name: StockLogsSharedPage.routeLABname,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: StockLogsSharedPage(),
                        ),
                      ),
                      GoRoute(
                        path: CashFlowIncomeSharedPage.routePath,
                        name: CashFlowIncomeSharedPage.routeLABname,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: CashFlowIncomeSharedPage(),
                        ),
                      ),
                      GoRoute(
                        path: CashFlowExpensesSharedPage.routePath,
                        name: CashFlowExpensesSharedPage.routeLABname,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: CashFlowExpensesSharedPage(),
                        ),
                      ),
                      GoRoute(
                        path: CashFlowSummarySharedPage.routePath,
                        name: CashFlowSummarySharedPage.routeLABname,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: CashFlowSummarySharedPage(),
                        ),
                      ),
                    ],
                  )
                ]),
          ]),
    ],
  );
}

class _Authorize extends StatelessWidget {
  _Authorize({Key? key, required this.child, required this.allowedRoles}) : super(key: key);
  Widget child;
  List<UserRoles> allowedRoles;

  @override
  Widget build(BuildContext context) {
    List<String> roles = allowedRoles.map((e) => e.name.toLowerCase()).toList();
    return FutureBuilder(
      future: AuthenticationAPI.VerifyToken(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (siteController.getRole()=="admin"|| roles.contains(siteController.getRole()))
            return child;
          else {
            return Center(
              child: Text(
                "Sorry you don't have access to this page",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 100,
                  color: Colors.grey
                ),
              ),
            );
          }
        } else
          return Container();
      },
    );
  }
}
