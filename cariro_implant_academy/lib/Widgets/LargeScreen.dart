import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/SiteController.dart';
import 'package:cariro_implant_academy/Widgets/Drawer.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constants/Colors.dart';
import '../Models/NotificationModel.dart';
import 'CIA_DropDown2.dart';

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
            child: Column(
          children: [
            Expanded(
              flex: 3,
              child: DrawerItems(
                onSiteChange: () => setState(
                  () {},
                ),
              ),
            ),
            siteController.getRole() != "Admin"
                ? Container(
                    color: Colors.white,
                  )
                : Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Divider(),
                          FormTextKeyWidget(text: "Switch Sites"),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  siteController.setSite("CIA");
                                  setState(() {});
                                  ;
                                },
                                child: Image(
                                  image:
                                      siteController.getSiteLogoBySite("CIA"),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  siteController.setSite("LAB");
                                  setState(() {});
                                  ;
                                },
                                child: Image(
                                  image:
                                      siteController.getSiteLogoBySite("LAB"),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  siteController.setSite("Clinic");
                                  setState(() {});
                                  ;
                                },
                                child: Image(
                                  image: siteController
                                      .getSiteLogoBySite("Clinic"),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        )),
        Expanded(
            flex: 7,
            child: Column(
              children: [
                GetBuilder<SiteController>(
                    builder: (siteController) => Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              siteController.appBarWidget,
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CIA_DropDown2(
                                    iconButton: Icon(Icons.notifications),
                                    notifications: [
                                      NotificationModel(
                                          title: "title 1",
                                          content:
                                              "akdhaasdasdasdasdasdasdasdasdasdasdsadsadssl;fghaskljf"),
                                      NotificationModel(
                                          title: "title 1",
                                          content: "akdhasl;fghaskljf"),
                                      NotificationModel(
                                          title: "title 1",
                                          content: "akdhasl;fghaskljf"),
                                      NotificationModel(
                                          title: "title 1",
                                          content: "akdhasl;fghasadasdaskljf"),
                                      NotificationModel(
                                          title: "title 1",
                                          content: "akdhasl;fghaskljf"),
                                      NotificationModel(
                                          title: "title 1",
                                          content: "akdhasl;fghaskljf"),
                                      NotificationModel(
                                          title: "title 1",
                                          content: "akdhasl;fghaskljf"),
                                      NotificationModel(
                                          title: "title 1",
                                          content: "akdhasl;fghaskljf"),
                                    ],
                                  ),
                                  SizedBox(width: 30),
                                  Image.asset("assets/user.png"),
                                  SizedBox(
                                    width: 20,
                                  )
                                ],
                              ))
                            ],
                          ),
                        )),
                Expanded(
                  child: Container(
                    color: Color_Background,
                    child: pagesController.MainPageRoutes(),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
