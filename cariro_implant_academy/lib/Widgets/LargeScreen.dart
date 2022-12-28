import 'package:cariro_implant_academy/Widgets/Drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/Colors.dart';
import '../Routes/Routes.dart';

class CIA_LargeScreen extends StatelessWidget {
  const CIA_LargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: DrawerItems()),
        Expanded(
            flex: 5,
            child: Container(
              color: Color_Background,
              child: MainPageRoutes(),
            ))
      ],
    );
  }
}
