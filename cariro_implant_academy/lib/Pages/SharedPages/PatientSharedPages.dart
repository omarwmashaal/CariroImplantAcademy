import 'package:cariro_implant_academy/API/LoadinAPI.dart';
import 'package:cariro_implant_academy/API/MedicalAPI.dart';
import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/API/UserAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/NonSurgicalTreatment.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Patient_MedicalInfo.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/Horizontal_RadioButtons.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:cariro_implant_academy/Widgets/Title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../Constants/Colors.dart';
import '../../Models/API_Response.dart';
import '../../Models/ComplainsModel.dart';
import '../../Models/DTOs/DropDownDTO.dart';
import '../../Models/VisitsModel.dart';
import '../../Widgets/CIA_PopUp.dart';
import '../../Widgets/SnackBar.dart';

class _getxController extends GetxController {
  static Rx<PatientInfoModel> duplicateFound = PatientInfoModel().obs;
  static RxList<DropDownDTO> searchList = <DropDownDTO>[].obs;
}

class PatientInfo_SharedPage extends StatefulWidget {
  PatientInfo_SharedPage({Key? key, required this.patientID, this.loadFunction, this.hideSaveButton = false, this.onSave}) : super(key: key);

  int patientID;
  Function? loadFunction;
  Function(API_Response response)? onSave;
  bool hideSaveButton;

  @override
  State<PatientInfo_SharedPage> createState() => _PatientInfo_SharedPageState();
}

class _PatientInfo_SharedPageState extends State<PatientInfo_SharedPage> {
  bool edit = false;
  bool addNew = false;
  FocusNode next = FocusNode();

  @override
  void initState() {
    addNew = widget.patientID == 0;
    if (addNew) {
      patient.maritalStatus = "Married";
      patient.gender = "Male";
      _getxController.searchList.value = [];
      _getxController.duplicateFound.value = PatientInfoModel();
    }
  }

  PatientInfoModel patient = PatientInfoModel(patientType: EnumPatientType.CIA);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.loadFunction != null ? widget.loadFunction!(widget.patientID ?? 0) : Future(() => API_Response()),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          if (!addNew && (snapshot.data as API_Response).statusCode == 200) {
            patient = (snapshot.data as API_Response).result as PatientInfoModel;
          }
          return Padding(
            padding: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Obx(() => TitleWidget(title: siteController.title.value, showBackButton: true)),
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
                              Visibility(
                                  child: Row(
                                    children: [
                                      Expanded(child: FormTextKeyWidget(text: "ID")),
                                      Expanded(child: FormTextValueWidget(text: patient?.id.toString() == null ? "" : patient?.id.toString()))
                                    ],
                                  ),
                                  visible: !addNew),
                              Visibility(
                                visible: addNew,
                                child: CIA_MultiSelectChipWidget(
                                  singleSelect: true,
                                  onChange: (item, isSelected) {
                                    if (isSelected) {
                                      if (item == "CIA")
                                        patient.patientType = EnumPatientType.CIA;
                                      else if (item == "Clinic")
                                        patient.patientType = EnumPatientType.Clinic;
                                      else if (item == "OutSource") patient.patientType = EnumPatientType.OutSource;
                                    }
                                  },
                                  labels: [
                                    CIA_MultiSelectChipWidgeModel(label: "CIA"),
                                    CIA_MultiSelectChipWidgeModel(label: "Clinic"),
                                    CIA_MultiSelectChipWidgeModel(label: "OutSource"),
                                  ],
                                ),
                              ),
                              addNew
                                  ? CIA_TextFormField(
                                      onChange: (value) {
                                        patient.name = value;
                                      },
                                      label: "Name",
                                      controller: TextEditingController(text: patient?.name == null ? "" : patient?.name),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Name")),
                                        Expanded(child: FormTextValueWidget(text: patient?.name == null ? "" : patient?.name))
                                      ],
                                    ),
                              addNew
                                  ? HorizontalRadioButtons(
                                      names: ["Male", "Female"],
                                      groupValue: "Male",
                                      onChange: (p0) {
                                        patient.gender = p0;
                                      },
                                    )
                                  : Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Gender")),
                                        Expanded(child: FormTextValueWidget(text: patient?.gender == null ? "" : patient?.gender))
                                      ],
                                    ),
                              edit || addNew
                                  ? CIA_TextFormField(
                                      onChange: (value) async {
                                        var res = await PatientAPI.CompareDuplicateNumber(value ?? "");
                                        if (res.statusCode == 200) {
                                          if (res.result != null)
                                            _getxController.duplicateFound.value = res.result as PatientInfoModel;
                                          else
                                            _getxController.duplicateFound.value = PatientInfoModel();
                                        }
                                        patient.phone = value;
                                      },
                                      label: "Phone Number",
                                      controller: TextEditingController(text: patient?.phone == null ? "" : patient?.phone),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Phone Number")),
                                        Expanded(child: FormTextValueWidget(text: patient?.phone == null ? "" : patient?.phone))
                                      ],
                                    ),
                              Obx(() => Visibility(
                                  visible: _getxController.duplicateFound.value.name != null && _getxController.duplicateFound.value.id != widget.patientID,
                                  child: FormTextKeyWidget(
                                      color: Colors.red,
                                      text:
                                          "Duplicate found patient: ${_getxController.duplicateFound.value.name != null ? _getxController.duplicateFound.value!.name! : ""}"))),
                              edit || addNew
                                  ? CIA_TextFormField(
                                      onChange: (value) {
                                        patient.phone2 = value;
                                      },
                                      label: "Another Phone Number",
                                      controller: TextEditingController(text: patient?.phone2 == null ? "" : patient?.phone2),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Another Phone Number")),
                                        Expanded(child: FormTextValueWidget(text: patient?.phone2 == null ? "" : patient?.phone2))
                                      ],
                                    ),
                              addNew
                                  ? CIA_TextFormField(
                                      onTap: () {
                                        CIA_PopupDialog_DateOnlyPicker(context, "Date of birth", (date) {
                                          patient.dateOfBirth = date;
                                          setState(() {});
                                        });
                                      },
                                      onChange: (value) {
                                        patient.dateOfBirth = value;
                                      },
                                      label: "Date Of Birth",
                                      controller: TextEditingController(text: patient?.dateOfBirth == null ? "" : patient?.dateOfBirth),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Date Of Birth")),
                                        Expanded(child: FormTextValueWidget(text: patient?.dateOfBirth == null ? "" : patient?.dateOfBirth))
                                      ],
                                    ),
                              edit || addNew
                                  ? HorizontalRadioButtons(
                                      names: ["Married", "Single"],
                                      onChange: (v) {
                                        patient.maritalStatus = v;
                                      },
                                      groupValue: patient.maritalStatus ?? "Married",
                                    )
                                  : Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Marital Status")),
                                        Expanded(child: FormTextValueWidget(text: patient?.maritalStatus == null ? "" : patient?.maritalStatus))
                                      ],
                                    ),
                              edit || addNew
                                  ? CIA_TextFormField(
                                      onChange: (value) {
                                        patient.address = value;
                                      },
                                      label: "Address",
                                      controller: TextEditingController(text: patient?.address == null ? "" : patient?.address),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Address")),
                                        Expanded(child: FormTextValueWidget(text: patient?.address == null ? "" : patient?.address))
                                      ],
                                    ),
                              edit || addNew
                                  ? CIA_TextFormField(
                                      onChange: (value) {
                                        patient.city = value;
                                      },
                                      label: "City",
                                      controller: TextEditingController(text: patient?.city == null ? "" : patient?.city),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "City")),
                                        Expanded(child: FormTextValueWidget(text: patient?.city == null ? "" : patient?.city))
                                      ],
                                    ),
                              addNew
                                  ? CIA_TextFormField(
                                      onTap: () {
                                        _getxController.searchList.value = [];
                                        CIA_ShowPopUp(
                                            context: context,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                CIA_TextFormField(
                                                  label: "Search",
                                                  controller: TextEditingController(),
                                                  onChange: (value) async {
                                                    var res = await PatientAPI.QuickSearch(value);
                                                    if (res.statusCode == 200) {
                                                      _getxController.searchList.value = res.result as List<DropDownDTO>;
                                                    } else
                                                      _getxController.searchList.value = [];
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 400,
                                                  child: Obx(() => ListView.builder(
                                                        itemBuilder: (context, index) {
                                                          return ListTile(
                                                            onTap: () {
                                                              patient.relativePatient = DropDownDTO(
                                                                  id: _getxController.searchList.value[index].id,
                                                                  name: _getxController.searchList.value[index].name);
                                                              patient.relativePatientId = _getxController.searchList.value[index].id;
                                                              setState(() {});
                                                            },
                                                            title: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  _getxController.searchList.value[index].name!,
                                                                  textAlign: TextAlign.start,
                                                                ),
                                                                Divider()
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        itemCount: _getxController.searchList.value.length,
                                                      )),
                                                )
                                              ],
                                            ));
                                      },
                                      label: "Relative",
                                      controller: TextEditingController(text: patient.relativePatient != null ? patient.relativePatient!.name! : ""),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Relative")),
                                        Expanded(child: FormTextValueWidget(text: patient.relativePatient != null ? patient.relativePatient!.name! : ""))
                                      ],
                                    ),
                              Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(
                                    text: "Registration: " + siteController.getUser().name!,
                                    secondaryInfo: true,
                                  )),
                                  Expanded(
                                      child: FormTextValueWidget(
                                    text: DateTime.now().toLocal().toString(),
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
                              Expanded(child: Image(image: AssetImage("assets/ProfileImage.png"))),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(child: Image(image: AssetImage("assets/userIDFront.png"))),
                                    Expanded(child: Image(image: AssetImage("assets/userIDBack.png"))),
                                  ],
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                Visibility(
                  visible: !widget.hideSaveButton,
                  child: Expanded(
                    child: addNew
                        ? Center(
                            child: CIA_PrimaryButton(
                                label: "Save",
                                isLong: true,
                                onTab: () async {
                                  var response = await PatientAPI.CreatePatient(patient);
                                  if (widget.onSave != null) widget.onSave!(response);
                                  if (response.statusCode == 200)
                                    ShowSnackBar(isSuccess: true, title: "Succeed!", message: "Patient has been added successfully!");
                                  else
                                    ShowSnackBar(isSuccess: false, title: "Failed!", message: response.errorMessage!);
                                }),
                          )
                        : edit
                            ? Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: SizedBox()),
                                    Flexible(
                                      child: CIA_SecondaryButton(label: "Cancel", onTab: () => setState(() => edit = false)),
                                    ),
                                    Flexible(
                                      child: CIA_PrimaryButton(
                                          label: "Save",
                                          isLong: true,
                                          onTab: () async {
                                            var response = await PatientAPI.UpdatePatientDate(patient);

                                            if (response.statusCode == 200)
                                              ShowSnackBar(isSuccess: true, title: "Succeed!", message: "Patient data has been saved successfully!");
                                            else
                                              ShowSnackBar(isSuccess: false, title: "Failed!", message: response.errorMessage!);

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
  PatientVisits_SharedPage({Key? key, required this.patientID, this.loadFunction, this.patientName}) : super(key: key);

  Function? loadFunction;
  int patientID;
  String? patientName;

  @override
  State<PatientVisits_SharedPage> createState() => _PatientVisits_SharedPageState();
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
                              FormTextValueWidget(text: widget.patientID.toString()),
                              SizedBox(width: 30),
                              FormTextKeyWidget(text: "Name: "),
                              SizedBox(width: 10),
                              FormTextValueWidget(text: dataSource.models.length == 0 ? "" : dataSource.models[0].patientName ?? ""),
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
                                      var res = await PatientAPI.PatientVisits(widget.patientID);
                                      if (res.statusCode == 200) {
                                        dataSource.setData(res.result as List<VisitsModel>);
                                        ShowSnackBar(isSuccess: true, title: "Success", message: "");
                                      } else {
                                        ShowSnackBar(isSuccess: false, title: "Failed", message: res.errorMessage ?? "Couldn't perform action");
                                      }
                                    }),
                                CIA_SecondaryButton(
                                    width: 180,
                                    label: "Patient Enters Clinic",
                                    onTab: () async {
                                      var res = await PatientAPI.PatientEntersClinic(widget.patientID);
                                      if (res.statusCode == 200) {
                                        dataSource.setData(res.result as List<VisitsModel>);
                                        ShowSnackBar(isSuccess: true, title: "Success", message: "");
                                      } else {
                                        ShowSnackBar(isSuccess: false, title: "Failed", message: res.errorMessage ?? "Couldn't perform action");
                                      }
                                    }),
                                CIA_SecondaryButton(
                                    width: 150,
                                    label: "Patient Leaves",
                                    onTab: () async {
                                      var res = await PatientAPI.PatientLeaves(widget.patientID);
                                      if (res.statusCode == 200) {
                                        dataSource.setData(res.result as List<VisitsModel>);
                                        ShowSnackBar(isSuccess: true, title: "Success", message: "");
                                      } else {
                                        ShowSnackBar(isSuccess: false, title: "Failed", message: res.errorMessage ?? "Couldn't perform action");
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
                                CIA_PopupDialog_DateTimePicker(context, "Schedule Next Visit", (value) {});
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
                          columnNames: dataSource.columns,
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

class PatientComplains extends StatefulWidget {
  PatientComplains({Key? key, required this.patientId}) : super(key: key);
  int patientId;

  @override
  State<PatientComplains> createState() => _PatientComplainsState();
}

class _PatientComplainsState extends State<PatientComplains> {
  PatientInfoModel patient = PatientInfoModel();
  List<ComplainsModel> complains = [];
  List<NonSurgicalTreatmentModel> treatments = [];

  @override
  Widget build(BuildContext context) {
    return CIA_FutureBuilder(
      loadFunction: () async {
        var res = await PatientAPI.GetPatientData(widget.patientId);
        if (res.statusCode == 200) patient = res.result as PatientInfoModel;
        res = await MedicalAPI.GetPatientAllNonSurgicalTreatments(widget.patientId);
        if (res.statusCode == 200) treatments = (res.result ?? []) as List<NonSurgicalTreatmentModel>;
        return await PatientAPI.GetComplains(id: widget.patientId);
      }(),
      onSuccess: (data) {
        ComplainsModel newComplain = ComplainsModel(
          patientID: widget.patientId,
        );

        complains = data as List<ComplainsModel>;
        return Column(
          children: [
            Obx(() => TitleWidget(
                  title: siteController.title.value,
                  showBackButton: true,
                )),
            SizedBox(
              height: 10,
            ),
            CIA_TextFormField(
              label: "New Complain",
              controller: TextEditingController(),
              onChange: (v) => newComplain.comment = v,
              maxLines: 5,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Entered By: "),
                      FormTextValueWidget(secondaryInfo: true, smallFont: true, text: siteController.getUser().name),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Date: "),
                      FormTextValueWidget(secondaryInfo: true, smallFont: true, text: DateFormat("dd-MM-yyyy hh:mm a").format(DateTime.now()).toString()),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Last Supervisor: "),
                      FormTextValueWidget(secondaryInfo: true, smallFont: true, text: treatments.isEmpty ? "" : treatments.first.supervisor!.name!),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Last Doctor: "),
                      FormTextValueWidget(secondaryInfo: true, smallFont: true, text: treatments.isEmpty ? "" : treatments.first.operator!.name!),
                    ],
                  ),
                ),
                Expanded(
                  child: CIA_DropDownSearch(
                    onSelect: (e) => newComplain.mentionedDoctorId = e.id,
                    label: "Mentioned Doctor",
                    asyncItems: () async {
                      List<DropDownDTO> r = [];
                      var res1 = await LoadinAPI.LoadSupervisors();
                      var res2 = await LoadinAPI.LoadAssistants();
                      if (res1.statusCode == 200) r.addAll(res1.result as List<DropDownDTO>);
                      if (res2.statusCode == 200) r.addAll(res2.result as List<DropDownDTO>);
                      return Future(() => API_Response(statusCode: res1.statusCode, result: r));
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CIA_PrimaryButton(
                    label: "Add Complain",
                    onTab: () async {
                      await PatientAPI.AddComplain(newComplain).then((value) {
                        if (value.statusCode == 200) {
                          ShowSnackBar(isSuccess: true, title: "Added", message: "");
                          setState(() {});
                        } else
                          ShowSnackBar(isSuccess: false, title: "Failed", message: value.errorMessage ?? "");
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                
                child: Column(
                  children: complains
                      .map(
                        (e) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(),
                            Row(
                              children: [
                                

                                Expanded(
                                  child: Text(
                                    e.comment ?? "",
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                  ),
                                ),SizedBox(width: 10),Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RoundCheckBox(
                                      onTap: e.resolved!
                                          ? null
                                          : (value) async {
                                        await PatientAPI.ResolveComplain(e.id!).then((value) {
                                          if (value.statusCode == 200) complains = value.result as List<ComplainsModel>;
                                          setState(() {});
                                        });
                                      },
                                      size: 30,
                                      disabledColor: Colors.green,
                                      checkedColor: Colors.green,
                                      borderColor: Colors.red,
                                      isRound: true,
                                      isChecked: e.resolved,
                                    ),
                                    FormTextValueWidget(
                                      text: "Mark as resolved",
                                      secondaryInfo: true,
                                      smallFont: true,
                                    )
                                  ],
                                ),

                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Entered By: "),
                                      FormTextValueWidget(secondaryInfo: true, smallFont: true, text: e.entryBy!.name!),
                                      SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Date: "),
                                      FormTextValueWidget(secondaryInfo: true, smallFont: true, text: e.entryTime ?? ""),
                                      SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Last Supervisor: "),
                                      FormTextValueWidget(secondaryInfo: true, smallFont: true, text: e.lastSupervisor!.name!),
                                      SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Last Doctor: "),
                                      FormTextValueWidget(secondaryInfo: true, smallFont: true, text: e.lastDoctor!.name!),
                                      SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Mentioned Doctor: "),
                                      FormTextValueWidget(secondaryInfo: true, smallFont: true, text: e.mentionedDoctor!.name!),
                                      SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Resolved By: "),
                                      FormTextValueWidget(secondaryInfo: true, smallFont: true, text: e.resolvedBy!.name!),
                                      SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                                Expanded(child: SizedBox())
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
