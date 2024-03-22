import 'package:cariro_implant_academy/Widgets/AppBarBloc.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';

import '../Constants/Controllers.dart';
import '../Pages/CIA_Pages/CashFlowPage.dart';
import '../Pages/Clinic_Pages/Clinic_CashFlowPage.dart';
import '../Pages/Clinic_Pages/Clinic_DoctorsSearchPage.dart';
import '../Pages/Clinic_Pages/Clinic_PatientsSearchPage.dart';
import '../Pages/Clinic_Pages/Clinic_StockPage.dart';
import '../Pages/LAB_Pages/LAB_CashFlowPage.dart';
import '../Pages/LAB_Pages/LAB_StockPage.dart';
import '../Widgets/AppBarBloc_States.dart';
import '../core/features/settings/presentation/pages/WebsiteSettingsPage.dart';
import '../features/labRequest/presentation/pages/LabRequestsSearchPage.dart';
import '../features/cashflow/presentation/pages/cashFlowIncomPage.dart';
import '../features/patient/presentation/pages/patientsSearchPage.dart';
import '../features/stock/presentation/pages/stockSearchPage.dart';
import '../features/user/domain/entities/enum.dart';
import '../features/user/presentation/pages/userSearchPage.dart';

class PagesController extends PageController {
  static PagesController instance = Get.find();
  static int index = 0;
  static int previousIndex = 0;

  PageView MainPageRoutes() {
   // String role = siteController.getRole()!;
    switch (siteController.getSite()) {
      case Website.CIA:
        {
          return PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pagesController,
            children: [
              Container(
                child: PatientsSearchPage(),
              ),
              Container(
                child: Center(
                  child: UserSearchPage(type: UserRoles.Assistant),
                ),
              ),
              Container(
                child: Center(child: UserSearchPage(type: UserRoles.Instructor)),
              ),
              Container(
                child: Center(child: UserSearchPage(type: UserRoles.Candidate)),
              ),
              Container(
                child: Center(
                  child: StockSearchPage(),
                ),
              ),
              Container(
                child: CashFlowsSearchPage(),
              ),
              Container(
                child: SettingsPage(),
              ),
            ],
          );
          break;
        }
      case Website.Lab:
        {
          if (siteController.getRole()!.contains("secretary"))
            return PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pagesController,
              children: [
                Container(child: Container() //LabRequestsSearchPage(),
                    ),
                Container(
                  child: Center(
                    child: UserSearchPage(type: UserRoles.OutSource),
                  ),
                ),
                Container(
                  child: Center(child: LAB_StockSearchPage()),
                ),
                LAB_CashFlowsSearchPage(),
              ],
            );
          else if (siteController.getRole()!.contains("technician")) {
            return PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pagesController,
              children: [
                //LabRequestsSearchPage(),
              ],
            );
          }
          return PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pagesController,
            children: [
              Container(child: Container() // LabRequestsSearchPage(),
                  ),
              Container(
                child: UserSearchPage(type: UserRoles.Technician),
              ),
              Container(
                child: Center(
                  child: UserSearchPage(type: UserRoles.OutSource),
                ),
              ),
              Container(
                child: Center(child: LAB_StockSearchPage()),
              ),
              LAB_CashFlowsSearchPage()
            ],
          );

          break;
        }
      case Website.Clinic:
        {
          return PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pagesController,
            children: [
              Container(
                child: Clinic_PatientsSearchPage(),
              ),
              Container(
                child: Clinic_DoctorsSearchPage(),
              ),
              Container(
                child: Clinic_StockPage(),
              ),
              Clinic_CashFlowPage()
            ],
          );
          break;
        }
      default:
        {
          return PageView(physics: NeverScrollableScrollPhysics(), controller: pagesController, children: []);
        }
    }
  }

  @override
  void jumpToPage(int page) {
    previousIndex = index;
    index = page;
    super.jumpToPage(page);
  }

  goBack() {
    //index--;
    index = previousIndex;
    super.jumpToPage(index);
  }

  static List<SidebarXItem> DrawerItems(BuildContext context, SidebarXController controller) {
    //String role = siteController.getRole()!;

    var bloc = BlocProvider.of<AppBarBloc>(context);

    var path = GoRouterState.of(context).fullPath!.split("/").last;

    switch (siteController.getSite()) {
      case Website.CIA:
        {
          if (path == PatientsSearchPage.routePath.split("/").last)
            bloc.emit(DrawerSetIndex(index: 0));
          else if (path == UserSearchPage.routePathAssistants.split("/").last)
            bloc.emit(DrawerSetIndex(index: 1));
          else if (path == UserSearchPage.routePathInstructors.split("/").last)
            bloc.emit(DrawerSetIndex(index: 2));
          else if (path == UserSearchPage.routePathCandidates.split("/").last)
            bloc.emit(DrawerSetIndex(index: 3));
          else if (path == StockSearchPage.routePath.split("/").last)
            bloc.emit(DrawerSetIndex(index: 4));
          else if (path == CashFlowIncomePage.routePath.split("/").last) bloc.emit(DrawerSetIndex(index: 5));

          return [
            SidebarXItem(
              label: 'atients',
              onTap: () {
                context.goNamed(PatientsSearchPage.getRouteName());
                controller.notifyListeners();
              },
              iconWidget: Container(
                  child: Tooltip(
                message: "Patients",
                child: Icon(IconDataSolid(
                  int.parse('0x00050'),
                )),
              )),
            ),
            SidebarXItem(
              label: 'ssistants',
              onTap: () {
                context.goNamed(UserSearchPage.getRouteNameAssistants(site:Website.CIA));
                controller.notifyListeners();
              },
              iconWidget: Container(
                  child: Tooltip(
                message: "Assistants",
                child: Icon(IconDataSolid(
                  int.parse('0x00041'),
                )),
              )),
            ),
            SidebarXItem(
              label: 'nstructors',
              onTap: () {
                context.goNamed(UserSearchPage.getRouteNameInstructors(site:Website.CIA));
                controller.notifyListeners();
              },
              iconWidget: Container(
                  child: Tooltip(
                message: "Instructors",
                child: Icon(IconDataSolid(
                  int.parse('0x00049'),
                )),
              )),
            ),
            SidebarXItem(
              label: 'andidates',
              onTap: () {
                context.goNamed(UserSearchPage.getRouteNameCandidates(site:Website.CIA));
                controller.notifyListeners();
              },
              iconWidget: Container(
                  child: Tooltip(
                message: "Candidates",
                child: Icon(IconDataSolid(
                  int.parse('0x00043'),
                )),
              )),
            ),
            SidebarXItem(
              label: 'Stock',
              onTap: () {
                context.goNamed(StockSearchPage.getRouteName(site:Website.CIA));
                controller.notifyListeners();
              },
              iconWidget: Container(child: Tooltip(message: "Stock", child: Icon(Icons.store))),
            ),
            SidebarXItem(
              label: 'Cash Flow',
              onTap: () {
                context.goNamed(CashFlowIncomePage.getRouteName(site:Website.CIA));
                controller.notifyListeners();
              },
              iconWidget: Container(child: Tooltip(message: "Cash Flow", child: Icon(Icons.attach_money))),
            ),
          ];
        }

      case Website.Clinic:
        {
          if (path == PatientsSearchPage.routePath.split("/").last)
            bloc.emit(DrawerSetIndex(index: 0));
          else if (path == UserSearchPage.routePathAssistants.split("/").last)
            bloc.emit(DrawerSetIndex(index: 1));
          else if (path == UserSearchPage.routePathInstructors.split("/").last)
            bloc.emit(DrawerSetIndex(index: 2));
          else if (path == StockSearchPage.routePath.split("/").last)
            bloc.emit(DrawerSetIndex(index: 3));
          else if (path == CashFlowIncomePage.routePath.split("/").last) bloc.emit(DrawerSetIndex(index: 4));

          return [
            SidebarXItem(
              label: 'atients',
              onTap: () {
                context.goNamed(PatientsSearchPage.getRouteName(site:Website.Clinic));
                controller.notifyListeners();
              },
              iconWidget: Container(
                  child: Tooltip(
                message: "Patients",
                child: Icon(IconDataSolid(
                  int.parse('0x00050'),
                )),
              )),
            ),
            SidebarXItem(
              label: 'ssistants',
              onTap: () {
                context.goNamed(UserSearchPage.getRouteNameAssistants(site:Website.Clinic));
                controller.notifyListeners();
              },
              iconWidget: Container(
                  child: Tooltip(
                message: "Assistants",
                child: Icon(IconDataSolid(
                  int.parse('0x00041'),
                )),
              )),
            ),
            SidebarXItem(
              label: 'octors',
              onTap: () {
                context.goNamed(UserSearchPage.getRouteNameInstructors(site:Website.Clinic));
                controller.notifyListeners();
              },
              iconWidget: Container(
                  child: Tooltip(
                message: "Doctors",
                child: Icon(IconDataSolid(
                  int.parse('0x00044'),
                )),
              )),
            ),
            SidebarXItem(
              label: 'Stock',
              onTap: () {
                context.goNamed(StockSearchPage.getRouteName(site: Website.Clinic));
                controller.notifyListeners();
              },
              iconWidget: Container(child: Tooltip(message: "Stock", child: Icon(Icons.store))),
            ),
            SidebarXItem(
              label: 'Cash Flow',
              onTap: () {
                context.goNamed(CashFlowIncomePage.getRouteName(site: Website.Clinic));
                controller.notifyListeners();
              },
              iconWidget: Container(child: Tooltip(message: "Cash Flow", child: Icon(Icons.attach_money))),
            ),
          ];
        }
      case Website.Lab:
        {
          if (siteController.getRole()!.contains( "technician")) {
            return [
              SidebarXItem(
                label: 'y Tasks',
                onTap: () {
                  context.goNamed(LabRequestsSearchPage.routeName);
                  controller.notifyListeners();
                },
                iconWidget: Container(
                    child: Tooltip(
                  message: "My Tasks",
                  child: Icon(IconDataSolid(
                    int.parse('0x0004D'),
                  )),
                )),
              ),
            ];
          }
          return [
            SidebarXItem(
                label: 'equests',
                onTap: () {
                  context.goNamed(LabRequestsSearchPage.routeName);
                  controller.notifyListeners();
                },
                iconWidget: Container(
                    child: Tooltip(
                  message: "Requests",
                  child: Icon(IconDataSolid(
                    int.parse('0x00052'),
                  )),
                ))),
            SidebarXItem(
                label: 'oderators',
                onTap: () {
                  context.goNamed(UserSearchPage.getRouteNameLabModerators(site:Website.Lab));
                  controller.notifyListeners();
                },
                iconWidget: Container(
                    child: Tooltip(
                  message: "Moderators",
                  child: Icon(IconDataSolid(
                    int.parse('0x0004D'),
                  )),
                ))),
            SidebarXItem(
                label: 'echnicians',
                onTap: () {
                  context.goNamed(UserSearchPage.getRouteNameTechnicians(site:Website.Lab));
                  controller.notifyListeners();
                },
                iconWidget: Container(
                    child: Tooltip(
                  message: "Technicians",
                  child: Icon(IconDataSolid(
                    int.parse('0x00054'),
                  )),
                ))),
            SidebarXItem(
                label: 'ustomers',
                onTap: () {
                  context.goNamed(UserSearchPage.getRouteNameCustomers(site:Website.Lab));
                  controller.notifyListeners();
                },
                iconWidget: Container(
                    child: Tooltip(
                  message: "Customers",
                  child: Icon(IconDataSolid(
                    int.parse('0x00043'),
                  )),
                ))),
            SidebarXItem(
              label: 'Stock',
              onTap: () {
                context.goNamed(StockSearchPage.getRouteName(site:Website.Lab));
                controller.notifyListeners();
              },
              iconWidget: Container(child: Tooltip(message: "Stock", child: Icon(Icons.store))),
            ),
            SidebarXItem(
              label: 'Cash Flow',
              onTap: () {
                context.goNamed(CashFlowIncomePage.getRouteName(site:Website.Lab));
                controller.notifyListeners();
              },
              iconWidget: Container(child: Tooltip(message: "Cash Flow", child: Icon(Icons.attach_money))),
            ),
          ];
        }

      default:
        {
          return [];
        }
    }
  }
}

class InternalPagesController extends PageController {
  static InternalPagesController instance = Get.find();
  late Object passedObject;
  static int index = 0;
  static int previousIndex = 0;

  setPassedObject(Object object) {
    passedObject = object;
  }

  @override
  @override
  void jumpToPage(int page) {
    previousIndex = index;
    index = page;
    super.jumpToPage(page);
  }

  goBack() {
    //index--;
    index = previousIndex;
    super.jumpToPage(index);
  }
}
