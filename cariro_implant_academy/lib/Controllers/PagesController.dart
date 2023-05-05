import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/CIA_SettingsPage.dart';
import 'package:cariro_implant_academy/Pages/UsersSearchPage.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
                child:  Center(
                  child:  UserSearchPage(dataSource: ApplicationUserDataSource(type: UserRoles.Assistant)),
                ),
              ),
              Container(
                child:  Center(child: UserSearchPage(dataSource: ApplicationUserDataSource(type: UserRoles.Instructor))),
              ),
              Container(child: CandidatesSearchPage()),
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
                  child:  Center(
                    child: UserSearchPage(dataSource: ApplicationUserDataSource(type: UserRoles.OutSource)),
                  ),
                ),
                Container(
                  child:  Center(child: LAB_StockSearchPage()),
                ),
                LAB_CashFlowsSearchPage(),
              ],
            );
          else if (role == "technician") {
            return PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pagesController,
              children: [
                LAB_MyTasksPage(),
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
                child:  Center(
                  child:UserSearchPage(dataSource: ApplicationUserDataSource(type: UserRoles.OutSource)),
                ),
              ),
              Container(
                child:  Center(child: LAB_StockSearchPage()),
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
          return PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pagesController,
              children: []);
        }
    }
  }

  static List<SideMenuItem> DrawerItems() {
    String role = siteController.getRole();

    switch (siteController.getSite()) {
      case Website.CIA:
        {
          return [
            SideMenuItem(
              priority: 0,
              title: 'Patients',
              onTap: (x,y) {
                pagesController.jumpToPage(0);
              },
            ),
            SideMenuItem(
              priority: 1,
              title: 'Assistants',
              onTap: (x,y) {
                pagesController.jumpToPage(1);
              },
            ),
            SideMenuItem(
              priority: 2,
              title: 'Instructors',
              onTap: (x,y) {
                pagesController.jumpToPage(2);
              },
            ),
            SideMenuItem(
              priority: 3,
              title: 'Candidates',
              onTap: (x,y) {
                pagesController.jumpToPage(3);
              },
            ),
            SideMenuItem(
              priority: 4,
              title: 'Stock',
              onTap: (x,y) {
                pagesController.jumpToPage(4);
              },
            ),
            SideMenuItem(
              priority: 5,
              title: 'Cash Flow',
              onTap: (x,y) {
                pagesController.jumpToPage(5);
              },
            ),
          ];
        }
      case Website.Lab:
        {
          if (role == "technician") {
            return [
              SideMenuItem(
                priority: 0,
                title: 'My Tasks',
                onTap: (x,y) {
                  pagesController.jumpToPage(0);
                },
              ),
            ];
          }
          return [
            SideMenuItem(
              priority: 0,
              title: 'Lab Requests',
              onTap: (x,y) {
                pagesController.jumpToPage(0);
              },
            ),
            SideMenuItem(
              priority: 1,
              title: 'Technicians',
              onTap: (x,y) {
                pagesController.jumpToPage(1);
              },
            ),
            SideMenuItem(
              priority: 2,
              title: 'Customers',
              onTap: (x,y) {
                pagesController.jumpToPage(2);
              },
            ),
            SideMenuItem(
              priority: 3,
              title: 'Stock',
              onTap: (x,y) {
                pagesController.jumpToPage(3);
              },
            ),
            SideMenuItem(
              priority:4,
              title: 'Cash Flow',
              onTap: (x,y) {
                pagesController.jumpToPage(4);
              },
            ),
          ];
        }
      case Website.Clinic:
        {
          return [
            SideMenuItem(
              priority: 0,
              title: 'Patients',
              onTap: (x,y) {
                pagesController.jumpToPage(0);
              },
            ),
            SideMenuItem(
              priority: 1,
              title: 'Doctors',
              onTap: (x,y) {
                pagesController.jumpToPage(1);
              },
            ),
            SideMenuItem(
              priority: 2,
              title: 'Stock',
              onTap: (x,y) {
                pagesController.jumpToPage(2);
              },
            ),
            SideMenuItem(
              priority: 3,
              title: 'Cash Flow',
              onTap: (x,y) {
                pagesController.jumpToPage(3);
              },
            ),
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
