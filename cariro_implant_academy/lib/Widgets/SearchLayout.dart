import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Constants/Fonts.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextField.dart';
import 'package:cariro_implant_academy/Widgets/Horizontal_RadioButtons.dart';
import 'package:cariro_implant_academy/Widgets/SlidingTab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

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
  PatientInfoModel(7, "Omar", "1290447120", "Married"),
  PatientInfoModel(11, "Omar", "1290447120", "Married"),
  PatientInfoModel(15, "Omar", "1290447120", "Married"),
  PatientInfoModel(3, "Omar", "1290447120", "Married"),
  PatientInfoModel(17, "Omar", "1290447120", "Married"),
  PatientInfoModel(2, "Omar", "1290447120", "Married"),
  PatientInfoModel(16, "Omar", "1290447120", "Married"),
  PatientInfoModel(12, "Omar", "1290447120", "Married"),
  PatientInfoModel(1, "Omar", "1290447120", "Married"),
  PatientInfoModel(10, "Omar", "1290447120", "Married"),
  PatientInfoModel(18, "Omar", "1290447120", "Married"),
  PatientInfoModel(19, "Omar", "1290447120", "Married"),
  PatientInfoModel(6, "Omar", "1290447120", "Married"),
];
class SearchLayout extends StatefulWidget {
  SearchLayout({Key? key}) : super(key: key);


  get tabs => ["Patients Data", "Visits Log"];
  List<Widget> pages = [
    Expanded(
      flex: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start  ,
        children: [
          Expanded(
              child: Text(
                "Patients Data",
                style: TextStyle(fontFamily: Inter_ExtraBold, fontSize: 40),
              )),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: CIA_TextField(
                      label: "Search",
                      icon: Icons.search,
                      onChange: (value) {
                        Search = value;
                      },
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: HorizontalRadioButtons(names: [
                            "Name",
                            "Phone",
                            "ID",
                            "Instructor",
                            "Assistant",
                            "Candidate",
                            "Operation",
                          ]),
                        ),
                        Expanded(child: SizedBox())
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child:
           CIA_Table(
                  dataSource:  PatientInfoModel.getDataSource(models),
                  columnNames: PatientInfoModel.columns,
                  onClick: (value)
                  {
                    print(PatientInfoModel.models[value-1].ID);
                  },
          )
            ,
          ),
        ],
      ),
    ),
    Expanded(flex:6,child: Container())
  ];

  @override
  State<SearchLayout> createState() => _SearchLayoutState();
}

class _SearchLayoutState extends State<SearchLayout> {


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
                      onChange: (() {}),
                      titles: widget.tabs,
                      weight: 400,
                      controller: tabsController,
                    ),
                  ),
                ],
              ),
            ),
            Obx(() =>widget.pages[tabsController.index.value] ),

          ],
        ),
      ),
    );
  }


}
