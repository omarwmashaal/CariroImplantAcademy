import 'package:cariro_implant_academy/Controllers/PagesController.dart';
import 'package:cariro_implant_academy/Widgets/Drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/Colors.dart';

//TODO: Return to stateless
class CIA_LargeScreen extends StatelessWidget {
  const CIA_LargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //TODO: Remove onrole change
        Expanded(child: DrawerItems()),
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
