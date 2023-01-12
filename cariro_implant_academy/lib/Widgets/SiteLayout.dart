import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Helpers/ResponsiveWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SiteLayout extends StatefulWidget {
  SiteLayout({Key? key, required this.largeScreen}) : super(key: key);
  Widget largeScreen;

  @override
  State<SiteLayout> createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color_Background,
      body: ResponsiveWidget(
        LargeScreen: widget.largeScreen,
        SmallScreen: widget.largeScreen,
      ),
    );
  }
}
