import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SiteController extends GetxController {
  static SiteController instance = Get.find();
  String _site = "CIA";
  String getSite() => _site;
  setSite(String site) {
    switchTheme(site);
    _site = site;
  }
}
