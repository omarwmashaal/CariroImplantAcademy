import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/Title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../Constants/Colors.dart';
import '../../Models/API_Response.dart';
import '../../Models/VisitsModel.dart';
import '../../Widgets/CIA_PopUp.dart';
import '../../Widgets/SnackBar.dart';

class PatientInfo_SharedPage extends StatefulWidget {
  PatientInfo_SharedPage({Key? key, required this.patientID, this.loadFunction})
      : super(key: key);

  int patientID;
  Function? loadFunction;

  @override
  State<PatientInfo_SharedPage> createState() => _PatientInfo_SharedPageState();
}

class _PatientInfo_SharedPageState extends State<PatientInfo_SharedPage> {
  bool edit = false;
  FocusNode next = FocusNode();

  PatientInfoModel patient =
      PatientInfoModel(1, "name", "phone", "maritalStatus ");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.loadFunction != null
          ? widget.loadFunction!(widget.patientID)
          : null,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          if ((snapshot.data as API_Response).statusCode == 200) {
            patient =
                (snapshot.data as API_Response).result as PatientInfoModel;
          }
          return Padding(
            padding: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Obx(() => TitleWidget(
                    title: siteController.title.value, showBackButton: true)),
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
                                  Expanded(
                                      child: FormTextKeyWidget(text: "ID")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: patient?.id.toString() == null
                                              ? ""
                                              : patient?.id.toString()))
                                ],
                              ),
                              edit
                                  ? CIA_TextFormField(
                                      onChange: (value) {
                                        patient.name = value;
                                      },
                                      label: "Name",
                                      controller: TextEditingController(
                                          text: patient?.name == null
                                              ? ""
                                              : patient?.name),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                            child: FormTextKeyWidget(
                                                text: "Name")),
                                        Expanded(
                                            child: FormTextValueWidget(
                                                text: patient?.name == null
                                                    ? ""
                                                    : patient?.name))
                                      ],
                                    ),
                              edit
                                  ? CIA_TextFormField(
                                      onChange: (value) {
                                        patient.name = value;
                                      },
                                      label: "Name",
                                      controller: TextEditingController(
                                          text: patient?.name == null
                                              ? ""
                                              : patient?.name),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                            child: FormTextKeyWidget(
                                                text: "Gender")),
                                        Expanded(
                                            child: FormTextValueWidget(
                                                text: patient?.gender == null
                                                    ? ""
                                                    : patient?.gender))
                                      ],
                                    ),
                              edit
                                  ? CIA_TextFormField(
                                      onChange: (value) {
                                        patient.phone = value;
                                      },
                                      label: "Phone Number",
                                      controller: TextEditingController(
                                          text: patient?.phone == null
                                              ? ""
                                              : patient?.phone),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                            child: FormTextKeyWidget(
                                                text: "Phone Number")),
                                        Expanded(
                                            child: FormTextValueWidget(
                                                text: patient?.phone == null
                                                    ? ""
                                                    : patient?.phone))
                                      ],
                                    ),
                              edit
                                  ? CIA_TextFormField(
                                      onChange: (value) {
                                        patient.phone2 = value;
                                      },
                                      label: "Another Phone Number",
                                      controller: TextEditingController(
                                          text: patient?.phone2 == null
                                              ? ""
                                              : patient?.phone2),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                            child: FormTextKeyWidget(
                                                text: "Another Phone Number")),
                                        Expanded(
                                            child: FormTextValueWidget(
                                                text: patient?.phone2 == null
                                                    ? ""
                                                    : patient?.phone2))
                                      ],
                                    ),
                              edit
                                  ? CIA_TextFormField(
                                      onChange: (value) {
                                        patient.dateOfBirth = value;
                                      },
                                      label: "Date Of Birth",
                                      controller: TextEditingController(
                                          text: patient?.dateOfBirth == null
                                              ? ""
                                              : patient?.dateOfBirth),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                            child: FormTextKeyWidget(
                                                text: "Date Of Birth")),
                                        Expanded(
                                            child: FormTextValueWidget(
                                                text:
                                                    patient?.dateOfBirth == null
                                                        ? ""
                                                        : patient?.dateOfBirth))
                                      ],
                                    ),
                              edit
                                  ? CIA_TextFormField(
                                      onChange: (value) {
                                        patient.maritalStatus = value;
                                      },
                                      label: "MaritalStatus",
                                      controller: TextEditingController(
                                          text: patient?.maritalStatus == null
                                              ? ""
                                              : patient?.maritalStatus),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                            child: FormTextKeyWidget(
                                                text: "Marital Status")),
                                        Expanded(
                                            child: FormTextValueWidget(
                                                text: patient?.maritalStatus ==
                                                        null
                                                    ? ""
                                                    : patient?.maritalStatus))
                                      ],
                                    ),
                              edit
                                  ? CIA_TextFormField(
                                      onChange: (value) {
                                        patient.address = value;
                                      },
                                      label: "Address",
                                      controller: TextEditingController(
                                          text: patient?.address == null
                                              ? ""
                                              : patient?.address),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                            child: FormTextKeyWidget(
                                                text: "Address")),
                                        Expanded(
                                            child: FormTextValueWidget(
                                                text: patient?.address == null
                                                    ? ""
                                                    : patient?.address))
                                      ],
                                    ),
                              edit
                                  ? CIA_TextFormField(
                                      onChange: (value) {
                                        patient.city = value;
                                      },
                                      label: "City",
                                      controller: TextEditingController(
                                          text: patient?.city == null
                                              ? ""
                                              : patient?.city),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                            child: FormTextKeyWidget(
                                                text: "City")),
                                        Expanded(
                                            child: FormTextValueWidget(
                                                text: patient?.city == null
                                                    ? ""
                                                    : patient?.city))
                                      ],
                                    ),
                              Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(
                                    text: "Registration: " +
                                        (patient?.name == null
                                            ? ""
                                            : patient?.name as String),
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
                                      image: AssetImage(
                                          "assets/ProfileImage.png"))),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Image(
                                            image: AssetImage(
                                                "assets/userIDFront.png"))),
                                    Expanded(
                                        child: Image(
                                            image: AssetImage(
                                                "assets/userIDBack.png"))),
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
                                    onTab: () async {
                                      var response =
                                          await PatientAPI.UpdatePatientDate(
                                              patient);

                                      if (response.statusCode == 200)
                                        ShowSnackBar(
                                            isSuccess: true,
                                            title: "Succeed!",
                                            message:
                                                "Patient data has been saved successfully!");
                                      else
                                        ShowSnackBar(
                                            isSuccess: false,
                                            title: "Failed!",
                                            message: response.errorMessage!);

                                      setState(() {
                                        edit = false;
                                      });
                                    }),
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
        } else
          return Center(
            child: LoadingIndicator(
              indicatorType: Indicator.ballClipRotateMultiple,
              colors: [Color_Accent],
            ),
          );
      },
    );
  }
}

class PatientVisits_SharedPage extends StatefulWidget {
  PatientVisits_SharedPage(
      {Key? key, required this.patientID, this.loadFunction, this.patientName})
      : super(key: key);

  Function? loadFunction;
  int patientID;
  String? patientName;

  @override
  State<PatientVisits_SharedPage> createState() =>
      _PatientVisits_SharedPageState();
}

class _PatientVisits_SharedPageState extends State<PatientVisits_SharedPage> {
  bool edit = false;

  VisitDataSource dataSource = VisitDataSource();
  FocusNode next = FocusNode();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dataSource.loadData(widget.patientID),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(top: 5, left: 10),
              child: Column(
                children: [
                  Obx(() => TitleWidget(
                        title: siteController.title.value,
                        showBackButton: true,
                      )),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              FormTextKeyWidget(text: "ID: "),
                              SizedBox(width: 10),
                              FormTextValueWidget(
                                  text: widget.patientID.toString()),
                              SizedBox(width: 30),
                              FormTextKeyWidget(text: "Name: "),
                              SizedBox(width: 10),
                              FormTextValueWidget(
                                  text: dataSource.models.length == 0
                                      ? ""
                                      : dataSource.models[0].patientName),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: FormTextKeyWidget(
                                text: "Patient Visit Procedures",
                              ),
                            )),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              FormTextKeyWidget(text: "Next Visit: "),
                              SizedBox(width: 10),
                              //FormTextValueWidget(text: patient.name),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CIA_SecondaryButton(
                                    width: 150,
                                    label: "Patient Arrive",
                                    onTab: () async {
                                      var res = await PatientAPI.PatientVisits(
                                          widget.patientID);
                                      if (res.statusCode == 200) {
                                        dataSource.setData(
                                            res.result as List<VisitsModel>);
                                        ShowSnackBar(
                                            isSuccess: true,
                                            title: "Success",
                                            message: "");
                                      } else {
                                        ShowSnackBar(
                                            isSuccess: false,
                                            title: "Failed",
                                            message: res.errorMessage ??
                                                "Couldn't perform action");
                                      }
                                    }),
                                CIA_SecondaryButton(
                                    width: 180,
                                    label: "Patient Enters Clinic",
                                    onTab: () async {
                                      var res =
                                          await PatientAPI.PatientEntersClinic(
                                              widget.patientID);
                                      if (res.statusCode == 200) {
                                        dataSource.setData(
                                            res.result as List<VisitsModel>);
                                        ShowSnackBar(
                                            isSuccess: true,
                                            title: "Success",
                                            message: "");
                                      } else {
                                        ShowSnackBar(
                                            isSuccess: false,
                                            title: "Failed",
                                            message: res.errorMessage ??
                                                "Couldn't perform action");
                                      }
                                    }),
                                CIA_SecondaryButton(
                                    width: 150,
                                    label: "Patient Leaves",
                                    onTab: () async {
                                      var res = await PatientAPI.PatientLeaves(
                                          widget.patientID);
                                      if (res.statusCode == 200) {
                                        dataSource.setData(
                                            res.result as List<VisitsModel>);
                                        ShowSnackBar(
                                            isSuccess: true,
                                            title: "Success",
                                            message: "");
                                      } else {
                                        ShowSnackBar(
                                            isSuccess: false,
                                            title: "Failed",
                                            message: res.errorMessage ??
                                                "Couldn't perform action");
                                      }
                                    }),
                              ],
                            )),
                        Expanded(
                            child: Row(
                          children: [
                            Expanded(child: SizedBox()),
                            CIA_PrimaryButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              width: 200,
                              label: "Schedule new visit",
                              onTab: () {
                                CIA_PopupDialog_DateTimePicker(
                                    context, "Schedule Next Visit", (value) {});
                              },
                              isLong: true,
                            )
                          ],
                        )),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 12,
                      child: CIA_Table(
                          columnNames: VisitsModel.columns,
                          dataSource: dataSource,
                          onCellClick: (value) {
                            //print(dataSource.models[value - 1].);
                          }))
                ],
              ),
            );
          } else {
            return Center(
              child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotateMultiple,
                colors: [Color_Accent],
              ),
            );
          }
        });
  }
}
