import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Models/LAB_RequestModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Widgets/CIA_LAB_StepTimelineWidget.dart';
import '../../Widgets/FormTextWidget.dart';
import '../../Widgets/Title.dart';

class LAB_ViewRequestPage extends StatelessWidget {
  LAB_ViewRequestPage({Key? key, required this.request}) : super(key: key);
  LAB_RequestsModel request;

  @override
  Widget build(BuildContext context) {
    request.Cost = "1500";
    request.PayedAmount = "0";
    request.Steps.add(
        LAB_StepModel("Scan", "Omar", "12/12/2012", StepStatus.Done));
    request.Steps.add(
        LAB_StepModel("Design", "Omar", "12/12/2012", StepStatus.Done));
    request.Steps.add(
        LAB_StepModel("Review Design", "Omar", "asdas", StepStatus.InProgress));
    request.Steps.add(
        LAB_StepModel("Milling", "Omar", "12/12/2012", StepStatus.NotYet));
    request.Steps.add(
        LAB_StepModel("Step 5", "Omar", "12/12/2012", StepStatus.NotYet));
    request.Steps.add(
        LAB_StepModel("Step 6", "Omar", "12/12/2012", StepStatus.NotYet));
    request.Steps.add(
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
                  title: "Request Details",
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
                                text: request.ID.toString(),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
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
                                text: request.Date == null ? "" : request.Date,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
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
                                text: request.Source == null
                                    ? ""
                                    : request.Source,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
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
                                text: request.CustomerName == null
                                    ? ""
                                    : request.CustomerName,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
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
                                text: request.CustomerPhone == null
                                    ? ""
                                    : request.CustomerPhone,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FormTextKeyWidget(
                                text: "Patient Name",
                              ),
                            ),
                            Expanded(
                              child: FormTextValueWidget(
                                text: request.PatientName == null
                                    ? ""
                                    : request.PatientName,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FormTextKeyWidget(
                                text: "Assigend To",
                              ),
                            ),
                            Expanded(
                              child: FormTextValueWidget(
                                text: request.AssignedTo == null
                                    ? ""
                                    : request.AssignedTo,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
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
                                text: request.Status == null
                                    ? ""
                                    : request.Status,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FormTextKeyWidget(
                                text: "Payment Status",
                              ),
                            ),
                            Expanded(
                              child: FormTextValueWidget(
                                text: request.PaymentStatus == null
                                    ? ""
                                    : request.PaymentStatus,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FormTextKeyWidget(
                                text: "Cost",
                              ),
                            ),
                            Expanded(
                              child: FormTextValueWidget(
                                text: request.Cost == null ? "" : request.Cost,
                                suffix: "EGP",
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FormTextKeyWidget(
                                text: "Payed Amount",
                              ),
                            ),
                            Expanded(
                              child: FormTextValueWidget(
                                suffix: "EGP",
                                text: request.PayedAmount == null
                                    ? ""
                                    : request.PayedAmount,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Expanded(
                    child: CIA_LAB_StepTimelineWidget(steps: request.Steps),
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
