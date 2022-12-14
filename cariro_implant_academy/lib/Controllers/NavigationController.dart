import 'package:cariro_implant_academy/Routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NavigationController extends GetxController{
  static NavigationController instance = Get.find();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();


  Future<dynamic>? navigateTo(String routeName)
  {
    return navigationKey.currentState?.pushNamed(routeName);
  }
  goBack()=> navigationKey.currentState?.pop();
}