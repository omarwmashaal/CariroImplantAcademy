import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/TabsLayout.dart';

class ViewPatientPage extends StatelessWidget {
  ViewPatientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.sync(onWillPop),
        child: Column(
          children: [
            Expanded(
              child: TabsLayout(
                showBackButton: true,
                tabs: ["Patient Data", "Visits Data"],
                pages: [
                  _PatientInfo(),
                  _PatientVisits(),
                ],
              ),
            ),
          ],
        ));
  }

  bool onWillPop() {
    internalPagesController.jumpTo(0);
    return false;
  }
}

class _PatientInfo extends StatefulWidget {
  _PatientInfo({Key? key}) : super(key: key);

  @override
  State<_PatientInfo> createState() => _PatientInfoState();
}

class _PatientInfoState extends State<_PatientInfo> {
  PatientInfoModel? patient;

  bool edit = false;
  FocusNode next = FocusNode();

  @override
  Widget build(BuildContext context) {
    if (internalPagesController.passedObject is PatientInfoModel)
      patient = internalPagesController.passedObject as PatientInfoModel;
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: FocusTraversalGroup(
                    policy: OrderedTraversalPolicy(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Expanded(child: FormTextKeyWidget(text: "ID")),
                            Expanded(
                                child: FormTextValueWidget(
                                    text: patient?.ID.toString() == null
                                        ? ""
                                        : patient?.ID.toString()))
                          ],
                        ),
                        edit
                            ? CIA_TextFormField(
                                label: "Name",
                                controller: TextEditingController(
                                    text: patient?.Name == null
                                        ? ""
                                        : patient?.Name),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(text: "Name")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: patient?.Name == null
                                              ? ""
                                              : patient?.Name))
                                ],
                              ),
                        edit
                            ? CIA_TextFormField(
                                label: "Name",
                                controller: TextEditingController(
                                    text: patient?.Name == null
                                        ? ""
                                        : patient?.Name),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(text: "Gender")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: patient?.Gender == null
                                              ? ""
                                              : patient?.Gender))
                                ],
                              ),
                        edit
                            ? CIA_TextFormField(
                                label: "Phone Number",
                                controller: TextEditingController(
                                    text: patient?.Phone == null
                                        ? ""
                                        : patient?.Phone),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(
                                          text: "Phone Number")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: patient?.Phone == null
                                              ? ""
                                              : patient?.Phone))
                                ],
                              ),
                        edit
                            ? CIA_TextFormField(
                                label: "Another Phone Number",
                                controller: TextEditingController(
                                    text: patient?.Phone2 == null
                                        ? ""
                                        : patient?.Phone2),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(
                                          text: "Another Phone Number")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: patient?.Phone2 == null
                                              ? ""
                                              : patient?.Phone2))
                                ],
                              ),
                        edit
                            ? CIA_TextFormField(
                                label: "Date Of Birth",
                                controller: TextEditingController(
                                    text: patient?.DateOfBirth == null
                                        ? ""
                                        : patient?.DateOfBirth),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(
                                          text: "Date Of Birth")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: patient?.DateOfBirth == null
                                              ? ""
                                              : patient?.DateOfBirth))
                                ],
                              ),
                        edit
                            ? CIA_TextFormField(
                                label: "MaritalStatus",
                                controller: TextEditingController(
                                    text: patient?.MaritalStatus == null
                                        ? ""
                                        : patient?.MaritalStatus),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(
                                          text: "Marital Status")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: patient?.MaritalStatus == null
                                              ? ""
                                              : patient?.MaritalStatus))
                                ],
                              ),
                        edit
                            ? CIA_TextFormField(
                                label: "Address",
                                controller: TextEditingController(
                                    text: patient?.Address == null
                                        ? ""
                                        : patient?.Address),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      child:
                                          FormTextKeyWidget(text: "Address")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: patient?.Address == null
                                              ? ""
                                              : patient?.Address))
                                ],
                              ),
                        edit
                            ? CIA_TextFormField(
                                label: "City",
                                controller: TextEditingController(
                                    text: patient?.City == null
                                        ? ""
                                        : patient?.City),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(text: "City")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: patient?.City == null
                                              ? ""
                                              : patient?.City))
                                ],
                              ),
                        Row(
                          children: [
                            Expanded(
                                child: FormTextKeyWidget(
                              text: "Registration: " +
                                  (patient?.Name == null
                                      ? ""
                                      : patient?.Name as String),
                              secondaryInfo: true,
                            )),
                            Expanded(
                                child: FormTextValueWidget(
                              text: "12/10/2022",
                              secondaryInfo: true,
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Expanded(
                            child:
                                Image(image: AssetImage("ProfileImage.png"))),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Image(
                                      image: AssetImage("userIDFront.png"))),
                              Expanded(
                                  child: Image(
                                      image: AssetImage("userIDBack.png"))),
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
          Expanded(
            child: edit
                ? Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: SizedBox()),
                        Flexible(
                          child: CIA_SecondaryButton(
                              label: "Cancel",
                              onTab: () => setState(() => edit = false)),
                        ),
                        Flexible(
                          child: CIA_PrimaryButton(
                              label: "Save",
                              isLong: true,
                              onTab: () => setState(() => edit = false)),
                        ),
                        Expanded(child: SizedBox()),

                      ],
                    ),
                  )
                : Center(
                    child: CIA_SecondaryButton(
                      onTab: () {
                        setState(() {
                          edit = true;
                        });
                      },
                      label: "Edit Info",
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

class _PatientVisits extends StatelessWidget {
  _PatientVisits({Key? key}) : super(key: key);
  PatientInfoModel? patient;

  @override
  Widget build(BuildContext context) {
    if (internalPagesController.passedObject is PatientInfoModel)
      patient = internalPagesController.passedObject as PatientInfoModel;
    return Container();
  }
}
