import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/SiteController.dart';
import 'package:cariro_implant_academy/Helpers/Router.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Pages/Authentication/AuthenticationPage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/CIA_MyProfilePage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/PatientsSearchPage.dart';
import 'package:cariro_implant_academy/Widgets/Drawer.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../Constants/Colors.dart';
import '../Models/NotificationModel.dart';
import 'CIA_DropDown2.dart';

//TODO: Return to stateless
class CIA_LargeScreen extends StatefulWidget {
  CIA_LargeScreen({
    Key? key,
    required this.child
  }) : super(key: key);
  Widget child;
  @override
  State<CIA_LargeScreen> createState() => _CIA_LargeScreenState();
}

class _CIA_LargeScreenState extends State<CIA_LargeScreen> {
  @override
  Widget build(BuildContext context) {
    if (pagesController.hasClients) pagesController.jumpToPage(0);

    if(GoRouter.of(context).location=="/")
      return AuthenticationPage();
    return Row(
      children: [
        //TODO: Remove onrole change
        DrawerItems(
          onSiteChange: () => setState(
            () {},
          ),
        ),
        Expanded(
            flex: 7,
            child: Column(
              children: [
                Container(
                  color: Color_Background,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GetBuilder<SiteController>(builder: (siteController) => siteController.appBarWidget),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CIA_DropDown2(
                            customButton: Icon(Icons.notifications),
                            notifications: [
                              NotificationModel(title: "title 1", content: "akdhaasdasdasdasdasdasdasdasdasdasdsadsadssl;fghaskljf"),
                              NotificationModel(title: "title 1", content: "akdhasl;fghaskljf"),
                              NotificationModel(title: "title 1", content: "akdhasl;fghaskljf"),
                              NotificationModel(title: "title 1", content: "akdhasl;fghasadasdaskljf"),
                              NotificationModel(title: "title 1", content: "akdhasl;fghaskljf"),
                              NotificationModel(title: "title 1", content: "akdhasl;fghaskljf"),
                              NotificationModel(title: "title 1", content: "akdhasl;fghaskljf"),
                              NotificationModel(title: "title 1", content: "akdhasl;fghaskljf"),
                            ],
                          ),
                          SizedBox(width: 30),
                          GestureDetector(
                              onTap: () {
                                context.goNamed(CIA_MyProfilePage.routeName);
                              },
                              child: Image.asset("assets/user.png")),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Color_Background,
                    child: widget.child,
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
