import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void ShowSnackBar(
    {required bool isSuccess, required String title, required String message}) {
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
  );
}
