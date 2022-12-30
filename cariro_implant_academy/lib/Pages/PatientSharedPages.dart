import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientInfo_SharedPage extends StatefulWidget {
  PatientInfo_SharedPage({Key? key, required this.patient}) : super(key: key);

  PatientInfoModel patient;
  @override
  State<PatientInfo_SharedPage> createState() => _PatientInfo_SharedPageState();
}

class _PatientInfo_SharedPageState extends State<PatientInfo_SharedPage> {
  bool edit = false;
  FocusNode next = FocusNode();

  @override
  Widget build(BuildContext context) {
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
                                    text: widget.patient?.ID.toString() == null
                                        ? ""
                                        : widget.patient?.ID.toString()))
                          ],
                        ),
                        edit
                            ? CIA_TextFormField(
                                label: "Name",
                                controller: TextEditingController(
                                    text: widget.patient?.Name == null
                                        ? ""
                                        : widget.patient?.Name),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(text: "Name")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: widget.patient?.Name == null
                                              ? ""
                                              : widget.patient?.Name))
                                ],
                              ),
                        edit
                            ? CIA_TextFormField(
                                label: "Name",
                                controller: TextEditingController(
                                    text: widget.patient?.Name == null
                                        ? ""
                                        : widget.patient?.Name),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(text: "Gender")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: widget.patient?.Gender == null
                                              ? ""
                                              : widget.patient?.Gender))
                                ],
                              ),
                        edit
                            ? CIA_TextFormField(
                                label: "Phone Number",
                                controller: TextEditingController(
                                    text: widget.patient?.Phone == null
                                        ? ""
                                        : widget.patient?.Phone),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(
                                          text: "Phone Number")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: widget.patient?.Phone == null
                                              ? ""
                                              : widget.patient?.Phone))
                                ],
                              ),
                        edit
                            ? CIA_TextFormField(
                                label: "Another Phone Number",
                                controller: TextEditingController(
                                    text: widget.patient?.Phone2 == null
                                        ? ""
                                        : widget.patient?.Phone2),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(
                                          text: "Another Phone Number")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: widget.patient?.Phone2 == null
                                              ? ""
                                              : widget.patient?.Phone2))
                                ],
                              ),
                        edit
                            ? CIA_TextFormField(
                                label: "Date Of Birth",
                                controller: TextEditingController(
                                    text: widget.patient?.DateOfBirth == null
                                        ? ""
                                        : widget.patient?.DateOfBirth),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(
                                          text: "Date Of Birth")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: widget.patient?.DateOfBirth ==
                                                  null
                                              ? ""
                                              : widget.patient?.DateOfBirth))
                                ],
                              ),
                        edit
                            ? CIA_TextFormField(
                                label: "MaritalStatus",
                                controller: TextEditingController(
                                    text: widget.patient?.MaritalStatus == null
                                        ? ""
                                        : widget.patient?.MaritalStatus),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(
                                          text: "Marital Status")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: widget.patient?.MaritalStatus ==
                                                  null
                                              ? ""
                                              : widget.patient?.MaritalStatus))
                                ],
                              ),
                        edit
                            ? CIA_TextFormField(
                                label: "Address",
                                controller: TextEditingController(
                                    text: widget.patient?.Address == null
                                        ? ""
                                        : widget.patient?.Address),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      child:
                                          FormTextKeyWidget(text: "Address")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: widget.patient?.Address == null
                                              ? ""
                                              : widget.patient?.Address))
                                ],
                              ),
                        edit
                            ? CIA_TextFormField(
                                label: "City",
                                controller: TextEditingController(
                                    text: widget.patient?.City == null
                                        ? ""
                                        : widget.patient?.City),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(text: "City")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: widget.patient?.City == null
                                              ? ""
                                              : widget.patient?.City))
                                ],
                              ),
                        Row(
                          children: [
                            Expanded(
                                child: FormTextKeyWidget(
                              text: "Registration: " +
                                  (widget.patient?.Name == null
                                      ? ""
                                      : widget.patient?.Name as String),
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
                            child: Image(
                                image: AssetImage("assets/ProfileImage.png"))),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Image(
                                      image: AssetImage(
                                          "assets/userIDFront.png"))),
                              Expanded(
                                  child: Image(
                                      image:
                                          AssetImage("assets/userIDBack.png"))),
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

class PatientVisits_SharedPage extends StatelessWidget {
  PatientVisits_SharedPage({Key? key, required this.patient}) : super(key: key);
  PatientInfoModel patient;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
