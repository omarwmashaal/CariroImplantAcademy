import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Helpers/ResponsiveWidget.dart';
import 'package:cariro_implant_academy/Widgets/Drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SiteLayout extends StatelessWidget {
  SiteLayout({Key? key, required this.largeScreen}) : super(key: key);
  Widget largeScreen;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: DrawerItems(),
      ),
      backgroundColor: Color_Background,
      body: ResponsiveWidget(
        LargeScreen: largeScreen,
        SmallScreen: largeScreen,
      ),
    );
  }
}
