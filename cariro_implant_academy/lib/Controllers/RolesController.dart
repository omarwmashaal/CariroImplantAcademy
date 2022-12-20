import 'package:get/get.dart';

import '../Models/PatientInfo.dart';

class RolesController extends GetxController{
  static RolesController instance = Get.find();

  String role = "".obs as String;
  PatientInfoModel patient = PatientInfoModel(1, "as", "Phone", "MaritalStatus").obs as PatientInfoModel;

}