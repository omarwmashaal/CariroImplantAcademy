import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CIA_MedicalAbsrobPointerWidget extends StatelessWidget {
 CIA_MedicalAbsrobPointerWidget({Key? key,required this.child}) : super(key: key);
  Widget child;
  @override
  Widget build(BuildContext context) {
    return Obx(() => AbsorbPointer(
      child:  child,
      absorbing: siteController.disableMedicalEdit.value,
    ));
  }
}
