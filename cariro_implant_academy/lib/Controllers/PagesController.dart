
import 'package:cariro_implant_academy/Helpers/Router.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/CIA_SettingsPage.dart';
import 'package:cariro_implant_academy/Pages/SharedPages/CashFlowSharedPage.dart';
import 'package:cariro_implant_academy/Pages/SharedPages/StocksSharedPage.dart';
import 'package:cariro_implant_academy/Pages/UsersSearchPage.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';

import '../Constants/Controllers.dart';
import '../Pages/CIA_Pages/CIA_MyProfilePage.dart';
import '../Pages/CIA_Pages/Candidates_SearchPage.dart';
import '../Pages/CIA_Pages/CashFlowPage.dart';
import '../Pages/CIA_Pages/StockPage.dart';
import '../Pages/Clinic_Pages/Clinic_CashFlowPage.dart';
import '../Pages/Clinic_Pages/Clinic_DoctorsSearchPage.dart';
import '../Pages/Clinic_Pages/Clinic_PatientsSearchPage.dart';
import '../Pages/Clinic_Pages/Clinic_StockPage.dart';
import '../Pages/LAB_Pages/LAB_CashFlowPage.dart';
import '../Pages/LAB_Pages/LAB_MyTasks.dart';
import '../Pages/LAB_Pages/LAB_StockPage.dart';
import '../Pages/LAB_Pages/LAB_LabRequestsSearch.dart';
import '../core/features/settings/pages/presentation/WebsiteSettingsPage.dart';
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
    String role = siteController.getRole()!;
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
                  child: UserSearchPage(type:UserRoles.Assistant),
                ),
              ),
              Container(
                child: Center(child: UserSearchPage(type:UserRoles.Instructor)),
              ),
              Container(
                child: Center(child: UserSearchPage(type:UserRoles.Candidate)),
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
          if (role == "Secretary")
            return PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pagesController,
              children: [
                Container(
                  child: Container()//LabRequestsSearchPage(),
                ),
                Container(
                  child: Center(
                    child: UserSearchPage(type:UserRoles.OutSource),
                  ),
                ),
                Container(
                  child: Center(child: LAB_StockSearchPage()),
                ),
                LAB_CashFlowsSearchPage(),
              ],
            );
          else if (role == "technician") {
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
              Container(
                child:Container()// LabRequestsSearchPage(),
              ),
              Container(
                child: UserSearchPage(type:UserRoles.Technician),
              ),
              Container(
                child: Center(
                  child: UserSearchPage(type:UserRoles.OutSource),
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

  static List<SidebarXItem> DrawerItems(BuildContext context,SidebarXController controller) {
    String role = siteController.getRole()!;

    switch (siteController.getSite()) {
      case Website.CIA:
        {
          return [
            SidebarXItem(
              label: 'atients',
              onTap: () {
                context.goNamed(PatientsSearchPage.routeName);
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
                context.goNamed(UserSearchPage.assistantsRouteName);
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

                context.goNamed(UserSearchPage.instructorsRouteName);
                controller.notifyListeners();             },
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

                context.goNamed(UserSearchPage.candidatesRouteName);
                controller.notifyListeners();           },
              iconWidget: Container(
                  child:Tooltip(
                    message: "Candidates",
                    child: Icon(IconDataSolid(
                int.parse('0x00043'),
              )),
                  )),
            ),
            SidebarXItem(
              label: 'Stock',
              onTap: () {
                context.goNamed(StockSearchPage.routeCIAname);
                controller.notifyListeners();
              },
              iconWidget: Container(
                  child: Tooltip(
                      message: "Stock",child: Icon(Icons.store))),
            ),
            SidebarXItem(
              label: 'Cash Flow',
              onTap: () {
                context.goNamed(CashFlowIncomePage.routeCIAname);
                controller.notifyListeners();
              },
              iconWidget: Container(
                  child: Tooltip(
                      message: "Cash Flow",child: Icon(Icons.attach_money))),
            ),
          ];
        }
      case Website.Lab:
        {
          if (role == "technician") {
            return [
              SidebarXItem(
                label: 'y Tasks',
                onTap: () {
                  context.goNamed(LabTodaysRequestsSearch.routeName);
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
                  context.goNamed(LabTodaysRequestsSearch.routeName);
                  controller.notifyListeners();
                },
                iconWidget: Container(
                    child:Tooltip(
                      message: "Requests",
                      child: Icon(IconDataSolid(
                        int.parse('0x00052'),
                      )),
                    ))),
            SidebarXItem(
                label: 'oderators',
                onTap: () {
                  context.goNamed(UserSearchPage.labModeratorsRouteName);
                  controller.notifyListeners();
                },

                iconWidget: Container(
                    child:Tooltip(
                      message: "Moderators",
                      child: Icon(IconDataSolid(
                        int.parse('0x0004D'),
                      )),
                    ))),
            SidebarXItem(
                label: 'echnicians',
                onTap: () {
                  context.goNamed(UserSearchPage.techniciansRouteName);
                  controller.notifyListeners();
                },

                iconWidget: Container(
                    child:Tooltip(
                      message: "Technicians",
                      child: Icon(IconDataSolid(
                        int.parse('0x00054'),
                      )),
                    ))),
            SidebarXItem(
                label: 'ustomers',
                onTap: () {
                  context.goNamed(UserSearchPage.outSourceRouteName);
                  controller.notifyListeners();
                },
                iconWidget: Container(
                    child:Tooltip(
                      message: "Customers",
                      child: Icon(IconDataSolid(
                        int.parse('0x00043'),
                      )),
                    ))),
            SidebarXItem(
                label: 'Stock',
                onTap: () {
                  context.goNamed(StockSearchPage.routeLABname);
                  controller.notifyListeners();
                },
              iconWidget: Container(
                  child: Tooltip(
                      message: "Stock",child: Icon(Icons.store))),),
            SidebarXItem(
                label: 'Cash Flow',
                onTap: () {
                  context.goNamed(CashFlowIncomePage.routeLABname);
                  controller.notifyListeners();
                },
              iconWidget: Container(
                  child: Tooltip(
                      message: "Cash Flow",child: Icon(Icons.attach_money))),),
          ];
        }
      case Website.Clinic:
        {
          return [
            /* SideMenuItem(

              label: 'Patients',
              onTap: () {
                pagesController.jumpToPage(0);
              },
            ),
            SideMenuItem(

              label: 'Doctors',
              onTap: () {
                pagesController.jumpToPage(1);
              },
            ),
            SideMenuItem(

              label: 'Stock',
              onTap: () {
                pagesController.jumpToPage(2);
              },
            ),
            SideMenuItem(

              label: 'Cash Flow',
              onTap: () {
                pagesController.jumpToPage(3);
              },
            ),
          */
          ];
          break;
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
