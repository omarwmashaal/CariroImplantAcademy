import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Constants/Fonts.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextField.dart';
import 'package:cariro_implant_academy/Widgets/Horizontal_RadioButtons.dart';
import 'package:cariro_implant_academy/Widgets/SlidingTab.dart';
import 'package:cariro_implant_academy/Widgets/Title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../Controllers/PagesController.dart';
import '../Models/PatientInfo.dart';
import 'CIA_Table.dart';
String Search = "";
String SearchFilter = "";
List<PatientInfoModel> models = <PatientInfoModel>[
  PatientInfoModel(5, "Omar", "1290447120", "Married"),
  PatientInfoModel(21, "Omar", "1290447120", "Married"),
  PatientInfoModel(4, "Omar", "1290447120", "Married"),
  PatientInfoModel(8, "Omar", "1290447120", "Married"),
  PatientInfoModel(14, "Omar", "1290447120", "Married"),
  PatientInfoModel(20, "Omar", "1290447120", "Married"),
  PatientInfoModel(13, "Omar", "1290447120", "Married"),
  PatientInfoModel(9, "Omar", "1290447120", "Married"),
];
class TabsLayout extends StatefulWidget {
  TabsLayout({Key? key, required this.tabs, required this.pages, this.showBackButton = false}) : super(key: key);
  List<String> tabs ;
  List<Widget> pages;
  bool showBackButton;

  final tabsController = new TabsController();
  @override
  State<TabsLayout> createState() => _TabsLayoutState();
}

class _TabsLayoutState extends State<TabsLayout> {

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: buildAsync(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasData) {
          print("Done");
          return snapshot.data as Widget;
        } else {
          print("Loading....");
          return LoadingIndicator(
            indicatorType: Indicator.circleStrokeSpin,
            colors: [Colors.red, Colors.orange],
            strokeWidth: 4.0,
            //pathBackgroundColor:
            //showPathBackground ? Colors.black45 : null,
          );
        }
      },
    );
  }

  Future<Widget> buildAsync() async {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: SlidingTab(
                      onChange: ((value) {
                        tabsController.jumpToPage(value);
                        setState(() {
                          index = value;
                        });
                      }),
                      titles: widget.tabs,
                      weight: 400,
                      controller: tabsController,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child:  TitleWidget(title: widget.tabs[index], showBackButton: widget.showBackButton,)),
           // Obx(() =>widget.pages[tabsController.index.value] ),
            Expanded(
              flex:10,
              child:Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: PageView(
                  controller: tabsController,
                  children: widget.pages,

                ),
              )
            )


          ],
        ),
      ),
    );
  }


}
