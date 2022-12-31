import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/PagesController.dart';
import 'package:cariro_implant_academy/Widgets/Drawer.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
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
            flex: 5,
            child: Container(
              color: Color_Background,
              child: PagesController.MainPageRoutes(),
            ))
      ],
    );
  }
}
