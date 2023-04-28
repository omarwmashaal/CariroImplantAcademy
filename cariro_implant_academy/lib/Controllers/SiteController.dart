import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Widgets/MedicalSlidingBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Constants/Controllers.dart';
import '../Widgets/SlidingTab.dart';

class SiteController extends GetxController {
  static SiteController instance = Get.find();
  Website _site = Website.CIA;
  AssetImage _siteLogo = AssetImage("CIA_Logo3.png");
  RxString _currentRole = "".obs;
  String _token = "";
  List<String> _CIA_Roles = ["admin", "instructor", "secretary", "assistant"];
  List<String> _Lab_Roles = ["Admin", "technician", "Secretary"];
  List<String> _Clinic_Roles = ["Admin", "Secretary", "Doctor"];
  ApplicationUserModel _applicationUser = ApplicationUserModel();

  ApplicationUserModel getUser() => _applicationUser;

  setUser(ApplicationUserModel user) => _applicationUser = user;
  Widget appBarWidget = Container();
  RxString title = "".obs;

  setAppBarWidget(
      {List<String>? tabs,
      Function? onChange,
      Future<bool> Function()? popUp,
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
            onChange: ((value) async {
              if (popUp != null) {
                bool changePage = await popUp();
                if(!changePage) return;
              }
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

  setMedicalAppBar({required MedicalSlidingBar bar}) async
  {
    appBarWidget = bar;
    await Future.delayed(Duration(microseconds: 1));
    update();
  }

  Website getSite() => _site;

  AssetImage getSiteLogo() => _siteLogo;

  AssetImage getSiteLogoBySite(Website site) {
    if (site == "CIA")
      return AssetImage("assets/CIA_Logo3.png");
    else if (site == "LAB")
      return AssetImage("assets/LAB_Logo.png");
    else
      return AssetImage("assets/Clinic_logo.png");
  }

  setSite(Website site) {
    switchTheme(site);
    _site = site;
    if (site == Website.CIA)
      _siteLogo = AssetImage("assets/CIA_Logo3.png");
    else if (site == Website.Lab)
      _siteLogo = AssetImage("assets/LAB_Logo.png");
    else
      _siteLogo = AssetImage("assets/Clinic_logo.png");
  }

  setRole(String role) {
    _currentRole.value = role;
  }

  setToken(String token) => _token = token;

  String getToken() => _token;

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
