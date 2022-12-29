import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Constants/Fonts.dart';
import 'package:cariro_implant_academy/Models/LAB_RequestModel.dart';
import 'package:cariro_implant_academy/Pages/LAB_Pages/LAB_CreateNewLabRequest.dart';
import 'package:cariro_implant_academy/Pages/LAB_Pages/LAB_ViewRequest.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/TabsLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/CIA_Table.dart';
import '../../Widgets/CIA_TextField.dart';
import '../../Widgets/Horizontal_RadioButtons.dart';

class LabRequestsSearchPage extends StatefulWidget {
  const LabRequestsSearchPage({Key? key}) : super(key: key);

  @override
  State<LabRequestsSearchPage> createState() => _LabRequestsSearchPageState();
}

class _LabRequestsSearchPageState extends State<LabRequestsSearchPage> {
  LabRequestDataSource dataSource = LabRequestDataSource();

  @override
  Widget build(BuildContext context) {
    late LAB_RequestsModel selectedTodayLabRequests = LAB_RequestsModel(
        1,
        "Date",
        "Source",
        "RequesterName",
        "RequesterPhone",
        "PatientName",
        "12",
        "Status");
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: internalPagesController,
      children: [
        TabsLayout(
            sideWidget: Row(
              children: [
                CIA_PrimaryButton(
                  width: 155,
                  label: "Add new request",
                  onTab: () {
                    internalPagesController.jumpToPage(2);
                  },
                  isLong: true,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Requests in Queue ",
                  style: TextStyle(fontFamily: Inter_Bold, fontSize: 20),
                ),
                Text(
                  "1",
                  style: TextStyle(
                      fontFamily: Inter_Bold, fontSize: 30, color: Colors.red),
                ),
                SizedBox(
                  width: 30,
                )
              ],
            ),
            tabs: [
              "Today",
              "All"
            ],
            pages: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  flex: 3,
                                  child: HorizontalRadioButtons(
                                    names: [
                                      "Sender Name",
                                      "Sender Phone",
                                      "Assigned To"
                                    ],
                                  ),
                                ),
                                Expanded(flex: 2, child: SizedBox())
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CIA_DropDown(
                                    label: 'Source',
                                    values: ["all"],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: CIA_DropDown(
                                    label: 'Payment',
                                    values: ["all"],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: CIA_DropDown(
                                    label: 'Status',
                                    values: ["all"],
                                  ),
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
                    flex: 3,
                    child: CIA_Table(
                        columnNames: LAB_RequestsModel.columns,
                        dataSource: dataSource,
                        onCellClick: (value) {
                          print(dataSource.models[value - 1].ID);
                          selectedTodayLabRequests =
                              dataSource.models[value - 1];
                          internalPagesController.jumpToPage(1);
                        }),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  flex: 3,
                                  child: HorizontalRadioButtons(
                                    names: [
                                      "Sender Name",
                                      "Sender Phone",
                                      "Assigned To"
                                    ],
                                  ),
                                ),
                                Expanded(flex: 2, child: SizedBox())
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CIA_DropDown(
                                    label: 'Source',
                                    values: ["all"],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: CIA_DropDown(
                                    label: 'From Date',
                                    values: ["all"],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: CIA_DropDown(
                                    label: 'To Date',
                                    values: ["all"],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: CIA_DropDown(
                                    label: 'Payment',
                                    values: ["all"],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: CIA_DropDown(
                                    label: 'Status',
                                    values: ["all"],
                                  ),
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
                    flex: 3,
                    child: CIA_Table(
                        columnNames: LAB_RequestsModel.columns,
                        dataSource: dataSource,
                        onCellClick: (value) {
                          print(dataSource.models[value - 1].ID);
                          selectedTodayLabRequests =
                              dataSource.models[value - 1];
                          internalPagesController.jumpToPage(1);
                        }),
                  ),
                ],
              ),
            ]),
        LAB_ViewRequestPage(request: selectedTodayLabRequests),
        LAB_CreateNewLabRequest()
        /*Obx(() => (rolesController.role == "Admin" ||
                rolesController.role == "Instructor")
            ? TodayLabRequestsMedicalInfoPage(
                todayLabRequestsMedicalController:
                    TodayLabRequestsMedicalController(selectedTodayLabRequests),
              )
            : ViewTodayLabRequestsPage())*/
      ],
    );
  }
}
