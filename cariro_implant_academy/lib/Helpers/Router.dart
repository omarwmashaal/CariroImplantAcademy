import 'package:cariro_implant_academy/API/AuthenticationAPI.dart';
import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/PatientMedicalController.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/core/features/authentication/domain/usecases/loginUseCase.dart';
import 'package:cariro_implant_academy/core/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:cariro_implant_academy/core/features/authentication/presentation/bloc/authentication_blocStates.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/pages/ClinicPriceSettingsPage.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/pages/LabItemsSettingsPage.dart';
import 'package:cariro_implant_academy/core/routing/routingBloc.dart';

//import 'package:cariro_implant_academy/Pages/Authentication/AuthenticationPage.dart';
import 'package:cariro_implant_academy/features/patient/presentation/pages/PatientAdvancedSearchPage.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/pages/LabRequestsSearchPage.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/pages/LAB_ViewRequest.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/pages/LAB_ViewTask.dart';
import 'package:cariro_implant_academy/Pages/SharedPages/CashFlowSharedPage.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/pages/LapCreateNewRequestPage.dart';
import 'package:cariro_implant_academy/Pages/SharedPages/StocksSharedPage.dart';
import 'package:cariro_implant_academy/Pages/UsersSearchPage.dart';
import 'package:cariro_implant_academy/SignalR/SignalR.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/LargeScreen.dart';
import 'package:cariro_implant_academy/Widgets/SiteLayout.dart';
import 'package:cariro_implant_academy/features/patient/presentation/pages/createOrViewPatientPage.dart';
import 'package:cariro_implant_academy/features/patient/presentation/widgets/advancedSearchPatientFiltersWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/CIA_Pages/CIA_MyProfilePage.dart';
import '../Pages/CIA_Pages/CIA_SettingsPage.dart';
import '../Pages/CIA_Pages/ViewUserPage.dart';
import '../Pages/LAB_Pages/LAB_MyTasks.dart';
import '../core/features/notification/presentation/pages/NotificationsPage.dart';
import 'package:logging/logging.dart';

import '../core/features/settings/presentation/pages/UserSettingsPage.dart';
import '../core/features/settings/presentation/pages/WebsiteSettingsPage.dart';
import '../core/injection_contianer.dart';
import '../features/cashflow/presentation/pages/cashFlowExpensesPage.dart';
import '../features/cashflow/presentation/pages/cashFlowIncomPage.dart';
import '../features/cashflow/presentation/pages/cashFlowSummaryPage.dart';
import '../features/clinicTreatments/presentation/pages/clinicTreeatmentPage.dart';
import '../features/patient/presentation/pages/complainsSearchPage.dart';
import '../features/patient/presentation/pages/patientProfileComplainsPage.dart';
import '../features/patient/presentation/pages/visitsPage.dart';
import '../features/patient/presentation/widgets/advancedSearchTreatmentFiltersWidget.dart';
import '../features/patientsMedical/complications/presentation/pages/ComplicationsAfterProsthesisPage.dart';
import '../features/patientsMedical/complications/presentation/pages/ComplicationsAfterSurgeryPage.dart';
import '../features/patientsMedical/dentalExamination/presentation/pages/medicalInfo_DentalExaminationPage.dart';
import '../features/patientsMedical/nonSurgicalTreatment/presentation/pages/nonSurgicalTreatmentPage.dart';
import '../features/patientsMedical/prosthetic/presentation/pages/prsotheticTreatmentPage.dart';
import '../features/patientsMedical/treatmentFeature/presentation/pages/surgicalTreatmentPage.dart';
import '../features/patientsMedical/treatmentFeature/presentation/pages/treatmentPlanPage.dart';
import '../features/stock/presentation/pages/stockLogsSearchPage.dart';
import '../features/stock/presentation/pages/stockSearchPage.dart';
import '../features/user/domain/entities/enum.dart';
import '../features/user/presentation/pages/candidateDetailsPage.dart';
import '../features/user/presentation/pages/userSearchPage.dart';
import '../features/user/presentation/pages/viewUserProfile.dart';
import '../core/features/authentication/presentation/pages/authentication_page.dart';
import '../features/patient/presentation/pages/patientsSearchPage.dart';
import '../presentation/patientsMedical/pages/medicalInfoShellPage.dart';
import '../features/patientsMedical/dentalHistroy/presentaion/pages/medicalInfo_DentalHistoryPage.dart';
import '../features/patientsMedical/medicalExamination/presentation/pages/medicalInfo_MedicalHistoryPage.dart';

class CIA_Router {
  static var shellNavigationKey = GlobalKey<NavigatorState>();
  static var rootNavigationKey = GlobalKey<NavigatorState>();
  static var routeConst_LabView = "GoToLabRequest";
  var tt = "aso";
  static GoRouter routes = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: "/",
    redirect: (context, state) {
      print(state);
    },
    routes: [
      GoRoute(
          name: "/",
          path: "/",
          builder: (context, state) {
            dialogHelper.clear();
            return Scaffold(body: AuthenticationPage());
          },
          //todo: fix this

          redirect: (context, state) async {
            if (!siteController.isLoggedIn()) {
              return "/";
            }

            /*if(
            state.fullPath!.contains(ViewUserProfilePage.routePath)
           )
             {
               if (state.fullPath!.contains("/Clinic")) {
                 siteController.setSite(Website.Clinic);
               }
               else if (state.fullPath!.contains("/Lab")) {
                 siteController.setSite(Website.Lab);
               }

               var site = siteController.getSite().name;
               var newlocation = state.fullPath!.replaceAll("CIA/", "$site/").replaceAll("Clinic/", "$site/").replaceAll("Lab/", "$site/");

               print("my location" + state.fullPath!);
               print("my location Edited" + newlocation);

               return newlocation;
             }*/
          },
          routes: [
            GoRoute(
                name: "CIA",
                path: "CIA",
                builder: (context, state) {
                  siteController.setSite(Website.CIA);
                  return Scaffold(body: AuthenticationPage());
                },
                //todo: fix this

                routes: [
                  ShellRoute(
                    builder: (context, state, child) {
                      siteController.setDynamicAppBar(context: context, pathQueries: state.pathParameters);
                      if (siteController.getUserId() != null) sl<SignalR>().connect();
                      return SiteLayout(
                          largeScreen: Scaffold(
                              body: CIA_LargeScreen(
                        child: child,
                      )));
                    },
                    routes: [
                      GoRoute(
                          name: PatientsSearchPage.getRouteName(site: Website.CIA),
                          path: PatientsSearchPage.routePath,
                          pageBuilder: (context, state) {
                            return NoTransitionPage(
                              child: PatientsSearchPage(),
                            );
                          },
                          routes: [
                            GoRoute(
                              name: CreateOrViewPatientPage.getAddRouteName(site: Website.CIA),
                              path: CreateOrViewPatientPage.addPatientRoutePath,
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                    child:  CreateOrViewPatientPage(
                                  patientID: 0,
                                ));
                              },
                            ),
                            GoRoute(
                              path: CreateOrViewPatientPage.viewPatientRoutePath,
                              name: CreateOrViewPatientPage.getViewRouteName(site: Website.CIA),
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                  child: CreateOrViewPatientPage(
                                    patientID: int.parse(state.pathParameters['id'].toString()),
                                  ),
                                );
                              },
                            ),
                            GoRoute(
                              path: VisitsPage.routePathProfile,
                              name: VisitsPage.getProfileRouteName(site: Website.CIA),
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                  child: VisitsPage(
                                    patientId: int.parse(state.pathParameters['id'].toString()),
                                  ),
                                );
                              },
                            ),
                            GoRoute(
                              path: PatientProfileComplainsPage.routePath,
                              name: PatientProfileComplainsPage.getRouteName(site: Website.CIA),
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                  child: PatientProfileComplainsPage(
                                    patientId: int.parse(state.pathParameters['id'].toString()),
                                  ),
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
                                    ], child: MedicalInfoShellPage(patientId: int.parse(state.pathParameters['id'].toString()), child: child)),
                                  );
                                },
                                routes: [
                                  GoRoute(
                                    name: PatientMedicalHistory.getRouteName(site: Website.CIA),
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
                                    name: DentalHistoryPage.getRouteName(site: Website.CIA),
                                    path: DentalHistoryPage.routePath,
                                    pageBuilder: (context, state) {
                                      return NoTransitionPage(
                                        child: _Authorize(
                                          allowedRoles: [
                                            UserRoles.Instructor,
                                            UserRoles.Assistant,
                                            UserRoles.Admin,
                                          ],
                                          child: DentalHistoryPage(
                                            patientId: int.parse(state.pathParameters['id'].toString()),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  GoRoute(
                                    name: DentalExaminationPage.getRouteName(site: Website.CIA),
                                    path: DentalExaminationPage.routePath,
                                    pageBuilder: (context, state) {
                                      return NoTransitionPage(
                                        child: _Authorize(
                                          allowedRoles: [
                                            UserRoles.Instructor,
                                            UserRoles.Assistant,
                                            UserRoles.Admin,
                                          ],
                                          child: DentalExaminationPage(
                                            patientId: int.parse(state.pathParameters['id'].toString()),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  GoRoute(
                                    name: NonSurgicalTreatmentPage.getRouteName(site: Website.CIA),
                                    path: NonSurgicalTreatmentPage.routePath,
                                    pageBuilder: (context, state) {
                                      return NoTransitionPage(
                                        child: _Authorize(
                                          allowedRoles: [
                                            UserRoles.Instructor,
                                            UserRoles.Assistant,
                                            UserRoles.Admin,
                                          ],
                                          child: NonSurgicalTreatmentPage(
                                            patientId: int.parse(state.pathParameters['id'].toString()),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  GoRoute(
                                    name: TreatmentPage.getRouteName(site: Website.CIA),
                                    path: TreatmentPage.routePath,
                                    pageBuilder: (context, state) {
                                      return NoTransitionPage(
                                        child: _Authorize(
                                          allowedRoles: [
                                            UserRoles.Instructor,
                                            UserRoles.Assistant,
                                            UserRoles.Admin,
                                          ],
                                          child: new TreatmentPage(
                                            key: GlobalKey(),
                                            patientId: int.parse(state.pathParameters['id'].toString()),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  GoRoute(
                                    name: SurgicalTreatmentPage.getRouteName(site: Website.CIA),
                                    path: SurgicalTreatmentPage.routePath,
                                    pageBuilder: (context, state) {
                                      return NoTransitionPage(
                                        child: _Authorize(
                                          allowedRoles: [
                                            UserRoles.Instructor,
                                            UserRoles.Assistant,
                                            UserRoles.Admin,
                                          ],
                                          child: new SurgicalTreatmentPage(
                                            key: GlobalKey(),
                                            patientId: int.parse(state.pathParameters['id'].toString()),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  GoRoute(
                                    name: ComplicationsAfterSurgeryPage.getRouteName(site: Website.CIA),
                                    path: ComplicationsAfterSurgeryPage.routePath,
                                    pageBuilder: (context, state) {
                                      return NoTransitionPage(
                                        child: _Authorize(
                                          allowedRoles: [
                                            UserRoles.Instructor,
                                            UserRoles.Assistant,
                                            UserRoles.Admin,
                                          ],
                                          child: new ComplicationsAfterSurgeryPage(
                                            key: GlobalKey(),
                                            patientId: int.parse(state.pathParameters['id'].toString()),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  GoRoute(
                                    name: ComplicationsAfterProsthesisPage.getRouteName(site: Website.CIA),
                                    path: ComplicationsAfterProsthesisPage.routePath,
                                    pageBuilder: (context, state) {
                                      return NoTransitionPage(
                                        child: _Authorize(
                                          allowedRoles: [
                                            UserRoles.Instructor,
                                            UserRoles.Assistant,
                                            UserRoles.Admin,
                                          ],
                                          child: new ComplicationsAfterProsthesisPage(
                                            key: GlobalKey(),
                                            patientId: int.parse(state.pathParameters['id'].toString()),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  GoRoute(
                                    name: ProstheticTreatmentPage.routeName,
                                    path: ProstheticTreatmentPage.routePath,
                                    pageBuilder: (context, state) {
                                      return NoTransitionPage(
                                        child: _Authorize(
                                          allowedRoles: [
                                            UserRoles.Instructor,
                                            UserRoles.Assistant,
                                            UserRoles.Admin,
                                          ],
                                          child: ProstheticTreatmentPage(
                                            patientId: int.parse(state.pathParameters['id'].toString()),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ]),
                          ]),
                      GoRoute(
                        name: PatientsSearchPage.getMyRouteName(site: Website.CIA),
                        path: PatientsSearchPage.routeMyPath,
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
                        name: VisitsPage.getSearchRouteName(site: Website.CIA),
                        path: VisitsPage.routePath,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: VisitsPage(),
                          );
                        },
                      ),
                      GoRoute(
                        path: ComplainsSearchPage.routePath,
                        name: ComplainsSearchPage.getRouteName(site: Website.CIA),
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: ComplainsSearchPage(),
                          );
                        },
                      ),
                      GoRoute(
                        path: PatientAdvancedSearchPage.routePathPatients,
                        name: PatientAdvancedSearchPage.routeNamePatients,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: _Authorize(
                                allowedRoles: [
                                  UserRoles.Instructor,
                                  UserRoles.Assistant,
                                  UserRoles.Admin,
                                ],
                                child: PatientAdvancedSearchPage(
                                  advancedSearchType: AdvancedSearchEnum.Patient,
                                )),
                          );
                        },
                      ),
                      GoRoute(
                        path: PatientAdvancedSearchPage.routePathTreatments,
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
                                advancedSearchType: AdvancedSearchEnum.Treatments,
                              ),
                            ),
                          );
                        },
                      ),
                      GoRoute(
                        path: PatientAdvancedSearchPage.routePathProsthetic,
                        name: PatientAdvancedSearchPage.routeNameProsthetic,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: _Authorize(
                              allowedRoles: [
                                UserRoles.Instructor,
                                UserRoles.Assistant,
                                UserRoles.Admin,
                              ],
                              child: PatientAdvancedSearchPage(
                                advancedSearchType: AdvancedSearchEnum.Prosthetic,
                              ),
                            ),
                          );
                        },
                      ),
                      GoRoute(
                        path: "Patients/:id",
                        redirect: (context, state) => context.namedLocation(CreateOrViewPatientPage.getViewRouteName()),
                      ),
                      GoRoute(
                          path: "Users",
                          builder: (context, state) => Container(),
                          //redirect: (context, state) => context.namedLocation(UserSearchPage.getRouteNameAssistants(site: Website.CIA)),
                          routes: [
                            GoRoute(
                              path: UserSearchPage.routePathAssistants,
                              name: UserSearchPage.getRouteNameAssistants(site: Website.CIA),
                              pageBuilder: (context, state) => NoTransitionPage(
                                child: UserSearchPage(
                                  key: GlobalKey(),
                                  type: UserRoles.Assistant,
                                ),
                              ),
                            ),
                            GoRoute(
                              path: UserSearchPage.routePathInstructors,
                              name: UserSearchPage.getRouteNameInstructors(site: Website.CIA),
                              pageBuilder: (context, state) => NoTransitionPage(
                                child: UserSearchPage(
                                  key: GlobalKey(),
                                  type: UserRoles.Instructor,
                                ),
                              ),
                            ),
                            GoRoute(
                              path: UserSearchPage.routePathCandidates,
                              name: UserSearchPage.getRouteNameCandidates(site: Website.CIA),
                              pageBuilder: (context, state) => NoTransitionPage(
                                child: UserSearchPage(
                                  key: GlobalKey(),
                                  type: UserRoles.Candidate,
                                ),
                              ),
                            ),
                          ]),
                      GoRoute(
                        path: ViewUserProfilePage.routePath,
                        name: ViewUserProfilePage.getRouteName(site: Website.CIA),
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: ViewUserProfilePage(
                            userId: int.parse(state.pathParameters['id']!),
                          ),
                        ),
                      ),
                      GoRoute(
                        path: ViewUserProfilePage.candidateRoutePath,
                        name: ViewUserProfilePage.candidateRouteName,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: ViewUserProfilePage(
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
                        path: StockSearchPage.routePath,
                        name: StockSearchPage.getRouteName(site: Website.CIA),
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: StockSearchPage(),
                        ),
                      ),
                      GoRoute(
                        path: StockLogsSearchPage.routePath,
                        name: StockLogsSearchPage.getRouteName(site: Website.CIA),
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: StockLogsSearchPage(),
                        ),
                      ),
                      GoRoute(
                        path: CashFlowIncomePage.routePath,
                        name: CashFlowIncomePage.getRouteName(site: Website.CIA),
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: CashFlowIncomePage(),
                        ),
                      ),
                      GoRoute(
                        path: CashFlowExpensesPage.routePath,
                        name: CashFlowExpensesPage.getRouteName(site: Website.CIA),
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: CashFlowExpensesPage(),
                        ),
                      ),
                      GoRoute(
                        path: CashFlowSummaryPage.routePath,
                        name: CashFlowSummaryPage.getRouteName(site: Website.CIA),
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: CashFlowSummaryPage(),
                        ),
                      ),
                      GoRoute(
                        path: SettingsPage.routePath,
                        name: SettingsPage.getRouteName(site: Website.CIA),
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
                        name: UsersSettingsPage.getRouteName(site: Website.CIA),
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
                      GoRoute(
                        path: LAB_ViewRequestPage.routeCIAPath,
                        name: LAB_ViewRequestPage.routeCIAName,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: LAB_ViewRequestPage(
                              id: int.parse(state.pathParameters['id']!),
                            ),
                          );
                        },
                      ),
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
                /* redirect: (context, state) async {
                  var res = await AuthenticationAPI.VerifyToken();
                  if (
                  await siteController.getToken() == "" ||
                      !(
                          siteController.getRole()=="admin"||
                              siteController.getRole()=="secretary"||
                              siteController.getRole()=="technician"||
                              siteController.getRole()=="labmoderator"
                      )

                  ) {
                    return "/";
                  }
                },*/
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
                        path: UsersSettingsPage.routePath,
                        name: UsersSettingsPage.getRouteName(site: Website.Lab),
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: _Authorize(allowedRoles: [
                              UserRoles.Admin,
                            ], child: UsersSettingsPage()),
                          );
                        },
                      ),
                      GoRoute(
                        path: SettingsPage.routePath,
                        name: SettingsPage.getRouteName(site: Website.Lab),
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: SettingsPage(),
                          );
                        },
                      ),
                      GoRoute(
                        path: LabItemSettingsPage.routePath,
                        name: LabItemSettingsPage.routeName,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: LabItemSettingsPage(),
                          );
                        },
                      ),
                      GoRoute(
                        path: LabRequestsSearchPage.routePath,
                        name: LabRequestsSearchPage.routeName,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: LabRequestsSearchPage(),
                          );
                        },
                      ),
                      GoRoute(
                        path: LabRequestsSearchPage.routeAllPath,
                        name: LabRequestsSearchPage.routeAllName,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: LabRequestsSearchPage(all: true),
                          );
                        },
                      ),
                      GoRoute(
                        path: LabRequestsSearchPage.routeMyPath,
                        name: LabRequestsSearchPage.routeMyName,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: LabRequestsSearchPage(myRequests: true),
                          );
                        },
                      ),
                      GoRoute(
                        path: LabCreateNewRequestPage.routePath,
                        name: LabCreateNewRequestPage.routeName,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: LabCreateNewRequestPage(),
                          );
                        },
                      ),
                      GoRoute(
                        path: ViewUserProfilePage.routePath,
                        name: ViewUserProfilePage.getRouteName(site: Website.Lab),
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: ViewUserProfilePage(
                            userId: int.parse(state.pathParameters['id']!),
                          ),
                        ),
                      ),
                      GoRoute(
                          path: "Requests/:id",
                          name: routeConst_LabView,
                          redirect: (context, state) {
                            if (siteController.getSite() == Website.CIA)
                              return "/CIA/ViewLabRequest/${state.pathParameters['id']}";
                            else if (siteController.getRole()!.contains("technician") || siteController.getRole()!.contains("labmoderator"))
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
                      GoRoute(path: "Users", builder: (context, state) => Container(), routes: [
                        GoRoute(
                          path: UserSearchPage.routePathTechnicians,
                          name: UserSearchPage.getRouteNameTechnicians(site: Website.Lab),
                          pageBuilder: (context, state) => NoTransitionPage(
                            child: _Authorize(
                              allowedRoles: [UserRoles.Admin, UserRoles.Secretary, UserRoles.LabModerator],
                              child: UserSearchPage(
                                key: GlobalKey(),
                                type: UserRoles.Technician,
                              ),
                            ),
                          ),
                        ),
                        GoRoute(
                          path: UserSearchPage.routePathLabModerators,
                          name: UserSearchPage.getRouteNameLabModerators(site: Website.Lab),
                          pageBuilder: (context, state) => NoTransitionPage(
                            child: _Authorize(
                              allowedRoles: [UserRoles.Admin, UserRoles.Secretary, UserRoles.LabModerator],
                              child: UserSearchPage(
                                key: GlobalKey(),
                                type: UserRoles.LabModerator,
                              ),
                            ),
                          ),
                        ),
                        GoRoute(
                          path: UserSearchPage.routePathOutsource,
                          name: UserSearchPage.getRouteNameCustomers(site: Website.Lab),
                          pageBuilder: (context, state) => NoTransitionPage(
                            child: UserSearchPage(
                              key: GlobalKey(),
                              type: UserRoles.OutSource,
                            ),
                          ),
                        ),
                      ]),
                      GoRoute(
                        path: StockSearchPage.routePath,
                        name: StockSearchPage.getRouteName(site: Website.Lab),
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: StockSearchPage(),
                        ),
                      ),
                      GoRoute(
                        path: StockLogsSearchPage.routePath,
                        name: StockLogsSearchPage.getRouteName(site: Website.Lab),
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: StockLogsSearchPage(),
                        ),
                      ),
                      GoRoute(
                        path: CashFlowIncomePage.routePath,
                        name: CashFlowIncomePage.getRouteName(site: Website.Lab),
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: CashFlowIncomePage(),
                        ),
                      ),
                      GoRoute(
                        path: CashFlowExpensesPage.routePath,
                        name: CashFlowExpensesPage.getRouteName(site: Website.Lab),
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: CashFlowExpensesPage(),
                        ),
                      ),
                      GoRoute(
                        path: CashFlowSummaryPage.routePath,
                        name: CashFlowSummaryPage.getRouteName(site: Website.Lab),
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: CashFlowSummaryPage(),
                        ),
                      ),
                    ],
                  )
                ]),
            GoRoute(
                name: "Clinic",
                path: "Clinic",
                builder: (context, state) {
                  siteController.setSite(Website.Clinic);
                  return Scaffold(body: AuthenticationPage());
                },
                //todo: fix this

                routes: [
                  ShellRoute(
                    builder: (context, state, child) {
                      siteController.setDynamicAppBar(context: context, pathQueries: state.pathParameters);
                      if (siteController.getUserId() != null) sl<SignalR>().connect();
                      return SiteLayout(
                          largeScreen: Scaffold(
                              body: CIA_LargeScreen(
                        child: child,
                      )));
                    },
                    routes: [
                      GoRoute(
                        path: ViewUserProfilePage.routePath,
                        name: ViewUserProfilePage.getRouteName(site: Website.Clinic),
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: ViewUserProfilePage(
                            userId: int.parse(state.pathParameters['id']!),
                          ),
                        ),
                      ),
                      GoRoute(
                          name: PatientsSearchPage.getRouteName(site: Website.Clinic),
                          path: PatientsSearchPage.routePath,
                          pageBuilder: (context, state) {
                            return NoTransitionPage(
                              child: PatientsSearchPage(),
                            );
                          },
                          routes: [
                            GoRoute(
                              name: CreateOrViewPatientPage.getAddRouteName(site: Website.Clinic),
                              path: CreateOrViewPatientPage.addPatientRoutePath,
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                    child: CreateOrViewPatientPage(
                                  patientID: 0,
                                ));
                              },
                            ),
                            GoRoute(
                              name: CreateOrViewPatientPage.getViewRouteName(site: Website.Clinic),
                              path: CreateOrViewPatientPage.viewPatientRoutePath,
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                  child: CreateOrViewPatientPage(
                                    patientID: int.parse(state.pathParameters['id'].toString()),
                                  ),
                                );
                              },
                            ),
                            GoRoute(
                              path: VisitsPage.routePathProfile,
                              name: VisitsPage.getProfileRouteName(site: Website.Clinic),
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                  child: VisitsPage(
                                    patientId: int.parse(state.pathParameters['id'].toString()),
                                  ),
                                );
                              },
                            ),
                            GoRoute(
                              path: PatientProfileComplainsPage.routePath,
                              name: PatientProfileComplainsPage.getRouteName(site: Website.Clinic),
                              pageBuilder: (context, state) {
                                return NoTransitionPage(
                                  child: PatientProfileComplainsPage(
                                    patientId: int.parse(state.pathParameters['id'].toString()),
                                  ),
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
                                    ], child: MedicalInfoShellPage(patientId: int.parse(state.pathParameters['id'].toString()), child: child)),
                                  );
                                },
                                routes: [
                                  GoRoute(
                                    name: PatientMedicalHistory.getRouteName(site: Website.Clinic),
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
                                    name: ClinicTreatmentPage.routeName,
                                    path: ClinicTreatmentPage.routePath,
                                    pageBuilder: (context, state) {
                                      return NoTransitionPage(
                                        child: _Authorize(
                                          allowedRoles: [
                                            UserRoles.Instructor,
                                            UserRoles.Assistant,
                                            UserRoles.Admin,
                                          ],
                                          child: ClinicTreatmentPage(
                                            patientId: int.parse(state.pathParameters['id'].toString()),
                                            plan: false,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  GoRoute(
                                    name: ClinicTreatmentPage.routeNamePlan,
                                    path: ClinicTreatmentPage.routePathPlan,
                                    pageBuilder: (context, state) {
                                      return NoTransitionPage(
                                        child: _Authorize(
                                          allowedRoles: [
                                            UserRoles.Instructor,
                                            UserRoles.Assistant,
                                            UserRoles.Admin,
                                          ],
                                          child: ClinicTreatmentPage(
                                            patientId: int.parse(state.pathParameters['id'].toString()),
                                            plan: true,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  GoRoute(
                                    name: DentalHistoryPage.getRouteName(site: Website.Clinic),
                                    path: DentalHistoryPage.routePath,
                                    pageBuilder: (context, state) {
                                      return NoTransitionPage(
                                        child: _Authorize(
                                          allowedRoles: [
                                            UserRoles.Instructor,
                                            UserRoles.Assistant,
                                            UserRoles.Admin,
                                          ],
                                          child: DentalHistoryPage(
                                            patientId: int.parse(state.pathParameters['id'].toString()),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  GoRoute(
                                    name: DentalExaminationPage.getRouteName(site: Website.Clinic),
                                    path: DentalExaminationPage.routePath,
                                    pageBuilder: (context, state) {
                                      return NoTransitionPage(
                                        child: _Authorize(
                                          allowedRoles: [
                                            UserRoles.Instructor,
                                            UserRoles.Assistant,
                                            UserRoles.Admin,
                                          ],
                                          child: DentalExaminationPage(
                                            patientId: int.parse(state.pathParameters['id'].toString()),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  GoRoute(
                                    name: NonSurgicalTreatmentPage.getRouteName(site: Website.Clinic),
                                    path: NonSurgicalTreatmentPage.routePath,
                                    pageBuilder: (context, state) {
                                      return NoTransitionPage(
                                        child: _Authorize(
                                          allowedRoles: [
                                            UserRoles.Instructor,
                                            UserRoles.Assistant,
                                            UserRoles.Admin,
                                          ],
                                          child: NonSurgicalTreatmentPage(
                                            patientId: int.parse(state.pathParameters['id'].toString()),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ]),
                          ]),
                      GoRoute(
                        name: PatientsSearchPage.getMyRouteName(site: Website.Clinic),
                        path: PatientsSearchPage.routeMyPath,
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
                        path: VisitsPage.routePath,
                        name: VisitsPage.getSearchRouteName(site: Website.Clinic),
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: VisitsPage(),
                          );
                        },
                      ),
                      GoRoute(
                        name: ComplainsSearchPage.getRouteName(site: Website.Clinic),
                        path: ComplainsSearchPage.routePath,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: ComplainsSearchPage(),
                          );
                        },
                      ),
                      GoRoute(
                        path: PatientAdvancedSearchPage.routePathPatients,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: _Authorize(
                                allowedRoles: [
                                  UserRoles.Instructor,
                                  UserRoles.Assistant,
                                  UserRoles.Admin,
                                ],
                                child: PatientAdvancedSearchPage(
                                  advancedSearchType: AdvancedSearchEnum.Patient,
                                )),
                          );
                        },
                      ),
                      GoRoute(
                        path: PatientAdvancedSearchPage.routePathTreatments,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: _Authorize(
                              allowedRoles: [
                                UserRoles.Instructor,
                                UserRoles.Assistant,
                                UserRoles.Admin,
                              ],
                              child: PatientAdvancedSearchPage(
                                advancedSearchType: AdvancedSearchEnum.Treatments,
                              ),
                            ),
                          );
                        },
                      ),
                      GoRoute(
                        path: PatientAdvancedSearchPage.routePathProsthetic,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: _Authorize(
                              allowedRoles: [
                                UserRoles.Instructor,
                                UserRoles.Assistant,
                                UserRoles.Admin,
                              ],
                              child: PatientAdvancedSearchPage(
                                advancedSearchType: AdvancedSearchEnum.Prosthetic,
                              ),
                            ),
                          );
                        },
                      ),
                      GoRoute(
                        path: "Clinic/Patients/:id",
                        redirect: (context, state) => context.namedLocation(CreateOrViewPatientPage.getViewRouteName()),
                      ),
                      GoRoute(path: "Users", builder: (context, state) => Container(), routes: [
                        GoRoute(
                          path: UserSearchPage.routePathAssistants,
                          name: UserSearchPage.getRouteNameAssistants(site: Website.Clinic),
                          pageBuilder: (context, state) => NoTransitionPage(
                            child: UserSearchPage(
                              key: GlobalKey(),
                              type: UserRoles.Assistant,
                            ),
                          ),
                        ),
                        GoRoute(
                          path: UserSearchPage.routePathInstructors,
                          name: UserSearchPage.getRouteNameInstructors(site: Website.Clinic),
                          pageBuilder: (context, state) => NoTransitionPage(
                            child: UserSearchPage(
                              key: GlobalKey(),
                              type: UserRoles.Instructor,
                            ),
                          ),
                        ),
                        GoRoute(
                          path: UserSearchPage.routePathCandidates,
                          name: UserSearchPage.getRouteNameCandidates(site: Website.Clinic),
                          pageBuilder: (context, state) => NoTransitionPage(
                            child: UserSearchPage(
                              key: GlobalKey(),
                              type: UserRoles.Candidate,
                            ),
                          ),
                        ),
                      ]),
                      GoRoute(
                        path: ViewUserProfilePage.routePath,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: ViewUserProfilePage(
                            userId: int.parse(state.pathParameters['id']!),
                          ),
                        ),
                      ),
                      GoRoute(
                        path: ViewUserProfilePage.candidateRoutePath,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: ViewUserProfilePage(
                            userId: int.parse(state.pathParameters['id']!),
                          ),
                        ),
                      ),
                      GoRoute(
                        path: ViewCandidateData.routePath,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: ViewCandidateData(
                            userId: int.parse(state.pathParameters['id']!),
                          ),
                        ),
                      ),
                      GoRoute(
                        name: StockSearchPage.getRouteName(site: Website.Clinic),
                        path: StockSearchPage.routePath,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: StockSearchPage(),
                        ),
                      ),
                      GoRoute(
                        name: StockLogsSearchPage.getRouteName(site: Website.Clinic),
                        path: StockLogsSearchPage.routePath,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: StockLogsSearchPage(),
                        ),
                      ),
                      GoRoute(
                        name: CashFlowIncomePage.getRouteName(site: Website.Clinic),
                        path: CashFlowIncomePage.routePath,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: CashFlowIncomePage(),
                        ),
                      ),
                      GoRoute(
                        name: CashFlowExpensesPage.getRouteName(site: Website.Clinic),
                        path: CashFlowExpensesPage.routePath,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: CashFlowExpensesPage(),
                        ),
                      ),
                      GoRoute(
                        name: CashFlowSummaryPage.getRouteName(site: Website.Clinic),
                        path: CashFlowSummaryPage.routePath,
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: CashFlowSummaryPage(),
                        ),
                      ),
                      GoRoute(
                        name: SettingsPage.getRouteName(site: Website.Clinic),
                        path: SettingsPage.routePath,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: _Authorize(allowedRoles: [
                              UserRoles.Admin,
                            ], child: SettingsPage()),
                          );
                        },
                      ),
                      GoRoute(
                        path: ClinicPriceSettingsPage.routePath,
                        name: ClinicPriceSettingsPage.routeName,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: _Authorize(allowedRoles: [
                              UserRoles.Admin,
                            ], child: ClinicPriceSettingsPage()),
                          );
                        },
                      ),
                      GoRoute(
                        path: CIA_MyProfilePage.routePath,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: CIA_MyProfilePage(),
                          );
                        },
                      ),
                      GoRoute(
                        name: UsersSettingsPage.getRouteName(site: Website.Clinic),
                        path: UsersSettingsPage.routePath,
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
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: NotificationsPage(),
                          );
                        },
                      ),
                      GoRoute(
                        path: LAB_ViewRequestPage.routeCIAPath,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: LAB_ViewRequestPage(
                              id: int.parse(state.pathParameters['id']!),
                            ),
                          );
                        },
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
  late AuthenticationBloc authenticationBloc;

  @override
  Widget build(BuildContext context) {
    authenticationBloc = sl<AuthenticationBloc>();
    authenticationBloc.logInEvent(LoginParams());
    List<String> roles = allowedRoles.map((e) => e.name.toLowerCase()).toList();
    //Logger.root.log(Level.INFO, "Called verify from main routing redirect");
    return BlocConsumer<AuthenticationBloc, Authentication_blocState>(
      bloc: authenticationBloc,
      listener: (context, state) {
        // if (state is ErrorState) context.go("/");

        if (state is LoggingInState)
          CustomLoader.show(context);
        else
          CustomLoader.hide();
      },
      buildWhen: (previous, current) => current is LoggedIn,
      builder: (context, state) {
        if (state is LoggedIn) {
          if (siteController.getRole()!.contains("admin") || siteController.getRole()!.any((element) => roles.contains(element)))
            return child;
          else
            return BigErrorPageWidget(message: "Sorry you don't have access to this page");
        }
        return Container();
      },
    );
  }
}
