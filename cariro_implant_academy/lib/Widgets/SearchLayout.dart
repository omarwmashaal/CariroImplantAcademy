import 'package:cariro_implant_academy/Constants/Fonts.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextField.dart';
import 'package:cariro_implant_academy/Widgets/Horizontal_RadioButtons.dart';
import 'package:cariro_implant_academy/Widgets/SlidingTab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SearchLayout extends StatefulWidget {
  SearchLayout({Key? key}) : super(key: key);

  @override
  State<SearchLayout> createState() => _SearchLayoutState();
}

class _SearchLayoutState extends State<SearchLayout> {
  String Search = "";

  String SearchFilter = "";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: buildAsync(),
      builder:(BuildContext context, AsyncSnapshot<Widget> snapshot)
      {
        if(snapshot.hasData)
          {
            print("Done");
            return snapshot.data as Widget;
          }
        else
          {
            print("Loading....");
            return LoadingIndicator(
              indicatorType: Indicator.circleStrokeSpin,
              colors: [Colors.red, Colors.orange],
              strokeWidth: 4.0,
              //pathBackgroundColor:
              //showPathBackground ? Colors.black45 : null,
            );
          }
      } ,

    );
  }
  Future<Widget> buildAsync() async
  {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: SlidingTab(
                            onChange: (() {}),
                            titles: ["Patients Data", "Visits Log"],
                            weight: 400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Text(
                        "Patients Data",
                        style: TextStyle(fontFamily: Inter_ExtraBold, fontSize: 40),
                      )),
                ],
              ),
            ),
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

                          /*Expanded(
                              child: RadioListTile(
                                title: Text("Name"),
                                value: "Name",
                                groupValue: SearchFilter,
                                activeColor: Color_AccentGreen,
                                onChanged: (value){
                                  setState(() {
                                    SearchFilter = value.toString();
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: Text("Phone"),
                                value: "Phone",
                                groupValue: SearchFilter,
                                activeColor: Color_AccentGreen,
                                onChanged: (value){
                                  setState(() {
                                    SearchFilter = value.toString();
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: Text("ID"),
                                value: "ID",
                                contentPadding: EdgeInsets.zero,
                                groupValue: SearchFilter,
                                activeColor: Color_AccentGreen,
                                onChanged: (value){
                                  setState(() {
                                    SearchFilter = value.toString();
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: Text("Instructor"),
                                value: "Instructor",
                                groupValue: SearchFilter,
                                activeColor: Color_AccentGreen,
                                onChanged: (value){
                                  setState(() {
                                    SearchFilter = value.toString();
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: Text("Assistant"),
                                value: "Assistant",
                                groupValue: SearchFilter,
                                activeColor: Color_AccentGreen,
                                onChanged: (value){
                                  setState(() {
                                    SearchFilter = value.toString();
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: Text("Candidate"),
                                value: "Candidate",
                                groupValue: SearchFilter,
                                activeColor: Color_AccentGreen,
                                onChanged: (value){
                                  setState(() {
                                    SearchFilter = value.toString();
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: Text("Operation"),
                                contentPadding: EdgeInsets.only(left: 0,right: 0),
                                toggleable: true,
                                value: "Operation",
                                visualDensity: VisualDensity.compact,
                                groupValue: SearchFilter,
                                activeColor: Color_AccentGreen,
                                onChanged: (value){
                                  setState(() {
                                    SearchFilter = value.toString();
                                  });
                                },
                              ),
                            ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex:5,
              child: CIA_Table(),
            ),
          ],
        ),
      ),
    );

  }
}
