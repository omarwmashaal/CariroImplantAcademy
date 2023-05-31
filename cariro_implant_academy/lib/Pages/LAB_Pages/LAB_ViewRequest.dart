import 'package:cariro_implant_academy/API/LAB_RequestsAPI.dart';
import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/LAB_RequestModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Models/Lab_StepModel.dart';
import '../../Widgets/CIA_LAB_StepTimelineWidget.dart';
import '../../Widgets/FormTextWidget.dart';
import '../../Widgets/Title.dart';

class LAB_ViewRequestPage extends StatelessWidget {
  LAB_ViewRequestPage({Key? key, required this.request}) : super(key: key);
  LAB_RequestModel request;

  @override
  Widget build(BuildContext context) {
    /*request.Cost = "1500";
    request.PayedAmount = "0";
    request.steps.add(
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
        LAB_StepModel("Step 7", "Omar", "12/12/2012", StepStatus.NotYet));*/
    //siteController.setAppBarWidget();
    return CIA_FutureBuilder(
      loadFunction: LAB_RequestsAPI.GetRequest(request.id!),
      onSuccess: (data) {
        request = data as LAB_RequestModel;
        return Column(
          children: [
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
                        var medicalInfo = request.getMedicalInfoList();
                        CIA_ShowPopUp(
                          context: context,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  FormTextKeyWidget(text: "Teeth: "),
                                  FormTextValueWidget(text: (){
                                    var r = "";
                                    (request.teeth??[]).forEach((e) => r+="${e.toString()}, ");
                                    return r;
                                  }()),
                                ],
                              ),
                              Container(alignment:AlignmentDirectional.centerStart ,child: FormTextKeyWidget(text: "Required: ")),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: medicalInfo.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(medicalInfo[index]),

                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
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
                                  text: request.id.toString(),
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
                                  text: request.date == null ? "" : request.date,
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
                                  text: request.source == null ? "" : request.source!.name,
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
                                  text: request.customer == null ? "" : request.customer!.name,
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
                                  text: request.customer == null ? "" : request.customer!.phoneNumber,
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
                                  text: request.patient == null ? "" : request.patient!.name,
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
                                  text: request.assignedTo == null ? "" : request.assignedTo!.name,
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
                                  text: request.status == null ? "" : request.status!.name,
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
                                  text: request.paid! ? "Paid" : "Not paid",
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
                                  text: request.cost == null ? "0" : request.cost.toString(),
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
                                  text: request.paidAmount == null ? "0" : request.paidAmount.toString(),
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
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                          alignment: Alignment.topCenter, padding: EdgeInsets.only(top: 50), child: CIA_LAB_StepTimelineWidget(steps: request.steps!)),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
