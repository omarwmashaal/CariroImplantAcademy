import 'dart:html';

import 'package:cariro_implant_academy/Routes/Router.dart';
import 'package:cariro_implant_academy/Routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constants/Controllers.dart';

Navigator LocalNavigator() =>
    Navigator(
      key: navigationController.navigationKey,
      initialRoute: LoginPageRoute,
      onGenerateRoute: generateRoute,
    );
