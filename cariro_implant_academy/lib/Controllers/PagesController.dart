import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/CIA_SettingsPage.dart';
import 'package:cariro_implant_academy/Pages/UsersSearchPage.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sidebarx/sidebarx.dart';

import '../Constants/Controllers.dart';
import '../Pages/CIA_Pages/CIA_MyProfilePage.dart';
import '../Pages/CIA_Pages/Candidates_SearchPage.dart';
import '../Pages/CIA_Pages/CashFlowPage.dart';
import '../Pages/CIA_Pages/PatientsSearchPage.dart';
import '../Pages/CIA_Pages/StockPage.dart';
import '../Pages/Clinic_Pages/Clinic_CashFlowPage.dart';
import '../Pages/Clinic_Pages/Clinic_DoctorsSearchPage.dart';
import '../Pages/Clinic_Pages/Clinic_PatientsSearchPage.dart';
import '../Pages/Clinic_Pages/Clinic_StockPage.dart';
import '../Pages/LAB_Pages/LAB_CashFlowPage.dart';
import '../Pages/LAB_Pages/LAB_MyTasks.dart';
import '../Pages/LAB_Pages/LAB_StockPage.dart';
import '../Pages/LAB_Pages/LAB_TodayLabRequestsPage.dart';

class PagesController extends PageController {
  static PagesController instance = Get.find();
  static int index = 0;
  static int previousIndex = 0;

  PageView MainPageRoutes() {
    String role = siteController.getRole();
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
                  child: UserSearchPage(dataSource: ApplicationUserDataSource(type: UserRoles.Assistant)),
                ),
              ),
              Container(
                child: Center(child: UserSearchPage(dataSource: ApplicationUserDataSource(type: UserRoles.Instructor))),
              ),
              Container(
                child: Center(child: UserSearchPage(dataSource: ApplicationUserDataSource(type: UserRoles.Candidate))),
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
                child: CIA_SettingsPage(),
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
                  child: LabRequestsSearchPage(),
                ),
                Container(
                  child: Center(
                    child: UserSearchPage(dataSource: ApplicationUserDataSource(type: UserRoles.OutSource)),
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
                LabRequestsSearchPage(),
              ],
            );
          }
          return PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pagesController,
            children: [
              Container(
                child: LabRequestsSearchPage(),
              ),
              Container(
                child: UserSearchPage(dataSource: ApplicationUserDataSource(type: UserRoles.Technician)),
              ),
              Container(
                child: Center(
                  child: UserSearchPage(dataSource: ApplicationUserDataSource(type: UserRoles.OutSource)),
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

  static List<SidebarXItem> DrawerItems() {
    String role = siteController.getRole();

    switch (siteController.getSite()) {
      case Website.CIA:
        {
          return [
            SidebarXItem(
              label: 'atients',
              onTap: () {
                pagesController.jumpToPage(0);
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
                pagesController.jumpToPage(1);
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
                pagesController.jumpToPage(2);
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
                pagesController.jumpToPage(3);
              },
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
                pagesController.jumpToPage(4);
              },
              iconWidget: Container(
                  child: Tooltip(
                      message: "Stock",child: Icon(Icons.store))),
            ),
            SidebarXItem(
              label: 'Cash Flow',
              onTap: () {
                pagesController.jumpToPage(5);
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
                  label: 'My Tasks',
                  onTap: () {
                    pagesController.jumpToPage(0);
                  },
                iconWidget: Container(
                    child: Tooltip(
                      message: "My Tasks",
                      child: Icon(Icons.task),
                    )),
              ),
            ];
          }
          return [
            SidebarXItem(
                label: 'Lab Requests',
                onTap: () {
                  pagesController.jumpToPage(0);
                },
                iconWidget: Container()),
            SidebarXItem(
                label: 'Technicians',
                onTap: () {
                  pagesController.jumpToPage(1);
                },
                iconWidget: Container()),
            SidebarXItem(
                label: 'Customers',
                onTap: () {
                  pagesController.jumpToPage(2);
                },
                iconWidget: Container()),
            SidebarXItem(
                label: 'Stock',
                onTap: () {
                  pagesController.jumpToPage(3);
                },
                iconWidget: Container()),
            SidebarXItem(
                label: 'Cash Flow',
                onTap: () {
                  pagesController.jumpToPage(4);
                },
                iconWidget: Container()),
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

class TabsController extends PageController {
  static TabsController instance = Get.find();
  RxInt index = 0.obs;

  @override
  void jumpToPage(int page) {
    index.value = page;
    super.jumpToPage(page);
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
