import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/TabsLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/LAB_TaskModel.dart';
import '../../Widgets/CIA_Table.dart';
import '../../Widgets/CIA_TextField.dart';
import '../../Widgets/Horizontal_RadioButtons.dart';
import '../../features/labRequest/presentation/pages/LAB_ViewTask.dart';
/*
class LAB_MyTasksPage extends StatefulWidget {
  const LAB_MyTasksPage({Key? key}) : super(key: key);
  static String routeName = "MyTasks";
   static String routeNameClinic = "ClinicMyTasks";
  static String routePath = "MyTasks/TodaysTasks";
  @override
  State<LAB_MyTasksPage> createState() => _LAB_MyTasksPageState();
}

class _LAB_MyTasksPageState extends State<LAB_MyTasksPage> {
  LabTaskDataSource dataSource = LabTaskDataSource();

  @override
  Widget build(BuildContext context) {
    late LAB_TaskModel selectedTask = LAB_TaskModel(1, "12/5/2023", "Clinic",
        "Omar", "0112345353", "Designing", "Waiting your work");
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: internalPagesController,
      children: [
        TabsLayout(tabs: [
          "Today",
          "All"
        ], pages: [
          CIA_Table(
              columnNames: LAB_TaskModel.columns,
              dataSource: dataSource,
              onCellClick: (value) {

                setState(() {
                  selectedTask = dataSource.models[value - 1];
                });
                internalPagesController.jumpToPage(1);
              }),
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
                                  "Customer Name",
                                  "Customer Phone",
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
                    columnNames: LAB_TaskModel.columns,
                    dataSource: dataSource,
                    onCellClick: (value) {

                      setState(() {
                        selectedTask = dataSource.models[value - 1];
                      });
                      internalPagesController.jumpToPage(1);
                    }),
              ),
            ],
          ),
        ]),
        LAB_ViewTaskPage(
          request: selectedTask,
        )

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
*/