import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/PagesController.dart';
import 'package:cariro_implant_academy/Widgets/Drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/Colors.dart';

//TODO: Return to stateless
class CIA_LargeScreen extends StatefulWidget {
  CIA_LargeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CIA_LargeScreen> createState() => _CIA_LargeScreenState();
}

class _CIA_LargeScreenState extends State<CIA_LargeScreen> {
  @override
  Widget build(BuildContext context) {
    if (pagesController.hasClients) pagesController.jumpToPage(0);
    return Row(
      children: [
        //TODO: Remove onrole change
        Expanded(
            child: DrawerItems(
          onSiteChange: () => setState(() {}),
        )),
        Expanded(
            flex: 5,
            child: Container(
              color: Color_Background,
              child: PagesController.MainPageRoutes(),
            ))
      ],
    );
  }
}
