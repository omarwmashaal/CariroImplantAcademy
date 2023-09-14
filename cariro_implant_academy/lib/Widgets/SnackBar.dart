import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

void ShowSnackBar(BuildContext context, {required bool isSuccess, String title = "", String message = ""}) {
  if (title == "") title = isSuccess ? "Success" : "Failed";
  late MotionToast toast;
  if(isSuccess)
   toast = MotionToast.success(

    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    description: Text(
      message ?? "",
      style: TextStyle(fontSize: 12),
    ),
    animationType: AnimationType.fromBottom,
     dismissable: true,
     toastDuration: Duration(seconds: 2),
   );
  else
   toast = MotionToast.error(
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    description: Text(
      message ?? "",
      style: TextStyle(fontSize: 12),
    ),
    animationType: AnimationType.fromBottom,
     dismissable: true,
     toastDuration: Duration(seconds: 2),

  );
  toast.show(context);
  /*Future.delayed(const Duration(seconds: 4)).then((value) {
    toast.dismiss();
  });

  Get.snackbar(
    title,
    message,
    icon: Icon(Icons.person, color: Colors.white),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: isSuccess ? Colors.green : Colors.red,
    maxWidth: 500,
    borderRadius: 20,
    margin: EdgeInsets.all(15),
    colorText: Colors.white,
    duration: Duration(seconds: 3),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
  );*/
}
