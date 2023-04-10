import 'package:get/get.dart';

import '../Models/PatientInfo.dart';

class RolesController extends GetxController {
  static RolesController instance = Get.find();

  Rx<PatientInfoModel> patient =
      PatientInfoModel().obs;
}
