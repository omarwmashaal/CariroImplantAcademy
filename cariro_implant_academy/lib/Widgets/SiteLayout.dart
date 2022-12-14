import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Helpers/ResponsiveWidget.dart';
import 'package:cariro_implant_academy/Widgets/AppBar.dart';
import 'package:cariro_implant_academy/Widgets/Drawer.dart';
import 'package:cariro_implant_academy/Widgets/LargeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SmallScreen.dart';

class SiteLayout extends StatelessWidget {
  SiteLayout({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      drawer: Drawer(
        child: DrawerItems(),
      ),
      backgroundColor: Color_Background,
      body: ResponsiveWidget(LargeScreen: LargeScreen(), SmallScreen: SmallScreen(),),
    );
  }
}
