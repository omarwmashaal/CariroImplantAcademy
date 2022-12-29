import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Constants/Fonts.dart';
import 'package:cariro_implant_academy/Controllers/PagesController.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<String> roles = ["Secretary", "Admin", "Instructor"];

class DrawerItems extends StatelessWidget {
  DrawerItems({Key? key, this.onRoleChange}) : super(key: key);

  Function? onRoleChange;
  @override
  Widget build(BuildContext context) {
    return SideMenu(
      controller: pagesController,
      title: Image(
        image: siteController.getSiteLogo(),
        width: 100,
        height: 100,
        fit: BoxFit.contain,
      ),
      style: SideMenuStyle(
        backgroundColor: Colors.white,
        // showTooltip: false,
        displayMode: SideMenuDisplayMode.open,
        hoverColor: Color_DrawerHover,
        selectedColor: Color_SideMenuFocus,
        unselectedTitleTextStyle:
            TextStyle(fontSize: 16, fontFamily: Inter_SemiBold),
        selectedTitleTextStyle: TextStyle(fontSize: 20, fontFamily: Inter_Bold),
        selectedIconColor: Colors.red,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.all(Radius.circular(10)),
        // ),
        // backgroundColor: Colors.blueGrey[700]
      ),
      items: PagesController.DrawerItems(),
    );
  }
}
