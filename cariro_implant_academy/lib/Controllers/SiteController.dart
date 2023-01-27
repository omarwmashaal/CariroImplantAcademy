import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Constants/Controllers.dart';
import '../Widgets/SlidingTab.dart';

class SiteController extends GetxController {
  static SiteController instance = Get.find();
  String _site = "CIA";
  AssetImage _siteLogo = AssetImage("CIA_Logo3.png");
  RxString _currentRole = "".obs;
  List<String> _CIA_Roles = ["Admin", "Instructor", "Secretary", "Assistant"];
  List<String> _Lab_Roles = ["Admin", "technician", "Secretary"];
  List<String> _Clinic_Roles = ["Admin", "Secretary", "Doctor"];

  Widget appBarWidget = Container();
  RxString title = "".obs;

  setAppBarWidget(
      {List<String>? tabs,
      Function? onChange,
      double? width,
      double? height,
      double? fontSize}) async {
    if (tabs != null) {
      appBarWidget = Container(
        key: GlobalKey(),
        child: SlidingTab(
            key: GlobalKey(),
            titles: tabs,
            weight: width == null ? 400 : width,
            height: height,
            fontSize: fontSize,
            controller: tabsController,
            onChange: ((value) {
              print(tabsController.page.toString() + " => $value");
              tabsController.jumpToPage(value);
              title.value = tabs[value];
            })),
      );
      //title.value = tabs[0];
      await Future.delayed(Duration(microseconds: 1));
      title.value = tabs[0];
    } else {
      appBarWidget = Container();
      await Future.delayed(Duration(microseconds: 1));
    }
    update();
  }

  String getSite() => _site;

  AssetImage getSiteLogo() => _siteLogo;

  AssetImage getSiteLogoBySite(String site) {
    if (site == "CIA")
      return AssetImage("assets/CIA_Logo3.png");
    else if (site == "LAB")
      return AssetImage("assets/LAB_Logo.png");
    else
      return AssetImage("assets/Clinic_logo.png");
  }

  setSite(String site) {
    switchTheme(site);
    _site = site;
    if (site == "CIA")
      _siteLogo = AssetImage("assets/CIA_Logo3.png");
    else if (site == "LAB")
      _siteLogo = AssetImage("assets/LAB_Logo.png");
    else
      _siteLogo = AssetImage("assets/Clinic_logo.png");
  }

  setRole(String Role) {
    _currentRole.value = Role;
  }

  String getRole() => _currentRole.value;

  List<String> getRoles() {
    if (_site == "CIA")
      return _CIA_Roles;
    else if (_site == "LAB")
      return _Lab_Roles;
    else
      return _Clinic_Roles;
  }
}
