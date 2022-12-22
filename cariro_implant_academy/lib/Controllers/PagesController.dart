import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PagesController extends PageController {
  static PagesController instance = Get.find();
}

class TabsController extends PageController {
  static TabsController instance = Get.find();
  RxInt index = 0.obs;
}

class InternalPagesController extends PageController {
  static InternalPagesController instance = Get.find();
  late Object passedObject;
  setPassedObject(Object object) {
    passedObject = object;
  }
}
