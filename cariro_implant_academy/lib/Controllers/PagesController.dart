import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Constants/Controllers.dart';
import '../Pages/CIA_Pages/Assistants_SearchPage.dart';
import '../Pages/CIA_Pages/Candidates_SearchPage.dart';
import '../Pages/CIA_Pages/CashFlowPage.dart';
import '../Pages/CIA_Pages/Instructors_SearchPage.dart';
import '../Pages/CIA_Pages/PatientsSearchPage.dart';
import '../Pages/CIA_Pages/StockPage.dart';
import '../Pages/Clinic_Pages/Clinic_CashFlowPage.dart';
import '../Pages/Clinic_Pages/Clinic_DoctorsSearchPage.dart';
import '../Pages/Clinic_Pages/Clinic_PatientsSearchPage.dart';
import '../Pages/Clinic_Pages/Clinic_StockPage.dart';
import '../Pages/LAB_Pages/LAB_CashFlowPage.dart';
import '../Pages/LAB_Pages/LAB_CustomersSearchPage.dart';
import '../Pages/LAB_Pages/LAB_MyTasks.dart';
import '../Pages/LAB_Pages/LAB_StockPage.dart';
import '../Pages/LAB_Pages/LAB_TodayLabRequestsPage.dart';

class PagesController extends PageController {
  static PagesController instance = Get.find();

  PageView MainPageRoutes() {
    String role = siteController.getRole();
    switch (siteController.getSite()) {
      case "CIA":
        {
          return PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pagesController,
            children: [
              Container(
                child: PatientsSearchPage(),
              ),
              Container(
                child: const Center(
                  child: AssistantsSearchPage(),
                ),
              ),
              Container(
                child: const Center(child: InstructorsSearchPage()),
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
            ],
          );
          break;
        }
      case "LAB":
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
                  child: const Center(
                    child: LAB_CustomersSearchPage(),
                  ),
                ),
                Container(
                  child: const Center(child: LAB_StockSearchPage()),
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
                child: const Center(
                  child: LAB_CustomersSearchPage(),
                ),
              ),
              Container(
                child: const Center(child: LAB_StockSearchPage()),
              ),
              LAB_CashFlowsSearchPage()
            ],
          );

          break;
        }
      case "Clinic":
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
      case "CIA":
        {
          return [
            SideMenuItem(
              priority: 0,
              title: 'Patients',
              onTap: () {
                pagesController.jumpToPage(0);
              },
            ),
            SideMenuItem(
              priority: 1,
              title: 'Assistants',
              onTap: () {
                pagesController.jumpToPage(1);
              },
            ),
            SideMenuItem(
              priority: 2,
              title: 'Instructors',
              onTap: () {
                pagesController.jumpToPage(2);
              },
            ),
            SideMenuItem(
              priority: 3,
              title: 'Candidates',
              onTap: () {
                pagesController.jumpToPage(3);
              },
            ),
            SideMenuItem(
              priority: 4,
              title: 'Stock',
              onTap: () {
                pagesController.jumpToPage(4);
              },
            ),
            SideMenuItem(
              priority: 5,
              title: 'Cash Flow',
              onTap: () {
                pagesController.jumpToPage(5);
              },
            ),
          ];
        }
      case "LAB":
        {
          if (role == "technician") {
            return [
              SideMenuItem(
                priority: 0,
                title: 'My Tasks',
                onTap: () {
                  pagesController.jumpToPage(0);
                },
              ),
            ];
          }
          return [
            SideMenuItem(
              priority: 0,
              title: 'Lab Requests',
              onTap: () {
                pagesController.jumpToPage(0);
              },
            ),
            SideMenuItem(
              priority: 1,
              title: 'Customers',
              onTap: () {
                pagesController.jumpToPage(1);
              },
            ),
            SideMenuItem(
              priority: 2,
              title: 'Stock',
              onTap: () {
                pagesController.jumpToPage(2);
              },
            ),
            SideMenuItem(
              priority: 3,
              title: 'Cash Flow',
              onTap: () {
                pagesController.jumpToPage(3);
              },
            ),
          ];
        }
      case "Clinic":
        {
          return [
            SideMenuItem(
              priority: 0,
              title: 'Patients',
              onTap: () {
                pagesController.jumpToPage(0);
              },
            ),
            SideMenuItem(
              priority: 1,
              title: 'Doctors',
              onTap: () {
                pagesController.jumpToPage(1);
              },
            ),
            SideMenuItem(
              priority: 2,
              title: 'Stock',
              onTap: () {
                pagesController.jumpToPage(2);
              },
            ),
            SideMenuItem(
              priority: 3,
              title: 'Cash Flow',
              onTap: () {
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
}

class InternalPagesController extends PageController {
  static InternalPagesController instance = Get.find();
  late Object passedObject;
  static int index = 0;

  setPassedObject(Object object) {
    passedObject = object;
  }

  @override
  @override
  void jumpToPage(int page) {
    index = page;
    super.jumpToPage(page);
  }

  goBack() {
    index--;
    super.jumpToPage(index);
  }
}
