import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Constants/Controllers.dart';
import '../Pages/CIA_Pages/Assistants_SearchPage.dart';
import '../Pages/CIA_Pages/Candidates_SearchPage.dart';
import '../Pages/CIA_Pages/CashFlowMainPage.dart';
import '../Pages/CIA_Pages/Instructors_SearchPage.dart';
import '../Pages/CIA_Pages/PatientsSearchPage.dart';
import '../Pages/LAB_Pages/LAB_CustomersSearchPage.dart';
import '../Pages/LAB_Pages/LAB_TodayLabRequestsPage.dart';

class PagesController extends PageController {
  static PagesController instance = Get.find();

  static PageView MainPageRoutes() {
    String role = siteController.getRole();
    if (siteController.getSite() == "CIA") {
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
            child: const Center(
              child: Text(
                'Operations',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            child: const Center(
              child: Text(
                'Stock',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            child: CashFlowMainPage(),
          ),
        ],
      );
    } else {
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
              child: const Center(child: InstructorsSearchPage()),
            ),
            Container(child: CandidatesSearchPage()),
          ],
        );
      else if (role == "technician") {
        return PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pagesController,
          children: [
            Container(
              child: Container(),
            ),
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
              child: AssistantsSearchPage(),
            ),
          ),
          Container(
            child: const Center(child: InstructorsSearchPage()),
          ),
          Container(child: CandidatesSearchPage()),
        ],
      );
    }
  }

  static List<SideMenuItem> DrawerItems() {
    String role = siteController.getRole();
    if (siteController.getSite() == "CIA") {
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
          title: 'Operations',
          onTap: () {
            pagesController.jumpToPage(4);
          },
        ),
        SideMenuItem(
          priority: 5,
          title: 'Stock',
          onTap: () {
            pagesController.jumpToPage(5);
          },
        ),
        SideMenuItem(
          priority: 6,
          title: 'Cash Flow',
          onTap: () {
            pagesController.jumpToPage(6);
          },
        ),
      ];
    } else {
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
    return <SideMenuItem>[];
  }
}

class TabsController extends PageController {
  static TabsController instance = Get.find();
  RxInt index = 0.obs;
}

class InternalPagesController extends PageController {
  static InternalPagesController instance = Get.find();
  late Object passedObject;

  setPassedObject(Object object) {
    passedObject = object;
  }
}
