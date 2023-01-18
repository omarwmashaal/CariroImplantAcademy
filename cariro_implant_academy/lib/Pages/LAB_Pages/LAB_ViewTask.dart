import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Models/LAB_TaskModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Models/LAB_RequestModel.dart';
import '../../Widgets/CIA_DropDown.dart';
import '../../Widgets/CIA_LAB_StepTimelineWidget.dart';
import '../../Widgets/CIA_PrimaryButton.dart';
import '../../Widgets/FormTextWidget.dart';
import '../../Widgets/Title.dart';

class LAB_ViewTaskPage extends StatelessWidget {
  LAB_ViewTaskPage({Key? key, required this.task}) : super(key: key);
  LAB_TaskModel task;

  @override
  Widget build(BuildContext context) {
    task.Steps.add(
        LAB_StepModel("Scan", "Omar", "12/12/2012", StepStatus.Done));
    task.Steps.add(
        LAB_StepModel("Design", "Omar", "12/12/2012", StepStatus.Done));
    task.Steps.add(
        LAB_StepModel("Review Design", "Omar", "asdas", StepStatus.InProgress));
    task.Steps.add(
        LAB_StepModel("Milling", "Omar", "12/12/2012", StepStatus.NotYet));
    task.Steps.add(
        LAB_StepModel("Step 5", "Omar", "12/12/2012", StepStatus.NotYet));
    task.Steps.add(
        LAB_StepModel("Step 6", "Omar", "12/12/2012", StepStatus.NotYet));
    task.Steps.add(
        LAB_StepModel("Step 7", "Omar", "12/12/2012", StepStatus.NotYet));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Expanded(child: SizedBox()),
          Expanded(
            child: Row(
              children: [
                TitleWidget(
                  title: "Task Details",
                  showBackButton: true,
                ),
                SizedBox(width: 10),
                CIA_SecondaryButton(
                    label: "Medical Info",
                    onTab: () {
                      Alert(
                        context: context,
                        title: "Medical Details",
                        content: SizedBox(
                          width: 400,
                        ),
                        buttons: [
                          DialogButton(
                            color: Color_Accent,
                            width: 150,
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Ok",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ).show();
                    })
              ],
            ),
          ),
          Expanded(
            flex: 12,
            child: Padding(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FormTextKeyWidget(
                                text: "ID",
                              ),
                            ),
                            Expanded(
                              child: FormTextValueWidget(
                                text: task.ID.toString(),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FormTextKeyWidget(
                                text: "Date Added",
                              ),
                            ),
                            Expanded(
                              child: FormTextValueWidget(
                                text: task.Date == null ? "" : task.Date,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FormTextKeyWidget(
                                text: "Source",
                              ),
                            ),
                            Expanded(
                              child: FormTextValueWidget(
                                text: task.Source == null ? "" : task.Source,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FormTextKeyWidget(
                                text: "Requester Name",
                              ),
                            ),
                            Expanded(
                              child: FormTextValueWidget(
                                text: task.CustomerName == null
                                    ? ""
                                    : task.CustomerName,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FormTextKeyWidget(
                                text: "Requester Phone",
                              ),
                            ),
                            Expanded(
                              child: FormTextValueWidget(
                                text: task.CustomerPhone == null
                                    ? ""
                                    : task.CustomerPhone,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FormTextKeyWidget(
                                text: "Required Step",
                              ),
                            ),
                            Expanded(
                              child: FormTextValueWidget(
                                text: task.RequiredStep == null
                                    ? ""
                                    : task.RequiredStep,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FormTextKeyWidget(
                                text: "Current Status",
                              ),
                            ),
                            Expanded(
                              child: FormTextValueWidget(
                                text: task.Status == null ? "" : task.Status,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  FormTextKeyWidget(text: "Assign Next Step"),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: CIA_DropDown(
                                        label: "Next",
                                        values: ["name1", "name2", "name3"]),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 30),
                            CIA_PrimaryButton(
                              isLong: true,
                              label: "Finish",
                              onTab: () {},
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Expanded(
                    child: CIA_LAB_StepTimelineWidget(
                      steps: task.Steps,
                      isTask: true,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
