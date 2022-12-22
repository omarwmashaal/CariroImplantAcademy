import 'package:get/get.dart';

import '../Models/PatientInfo.dart';

class RolesController extends GetxController {
  static RolesController instance = Get.find();

  Rx<String> role = "Instructor".obs;
  Rx<PatientInfoModel> patient =
      PatientInfoModel(1, "as", "Phone", "MaritalStatus").obs;
}
