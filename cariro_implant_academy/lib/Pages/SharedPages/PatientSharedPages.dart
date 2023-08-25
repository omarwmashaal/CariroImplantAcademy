import 'dart:convert';
import 'dart:typed_data';

import 'package:cariro_implant_academy/API/LoadinAPI.dart';
import 'package:cariro_implant_academy/API/MedicalAPI.dart';
import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/API/UserAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/NonSurgicalTreatment.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/Models/PaymentLogModel.dart';
import 'package:cariro_implant_academy/Models/ReceiptModel.dart';
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
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';
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
  static RxBool duplicateId = false.obs;
  static RxInt nextAvailableId = 0.obs;
}

class PatientInfo_SharedPage extends StatefulWidget {
  PatientInfo_SharedPage({Key? key, required this.patientID, this.loadFunction, this.hideSaveButton = false, this.onSave}) : super(key: key);

  static String getPatshViewPatient(String id) {
    return "/CIA/Patients/$id/ViewPatient";
  }

  static String getPasthAddPatient(String id) {
    return "/CIA/Patients/AddPatient";
  }

  static String viewPsatientRouteName = "ViewPatient";
  static String viewPsatientRoutePath = "Patients/:id/ViewPatient";
  static String addPatsientRouteName = "AddPatient";
  static String addPastientRoutePath = "AddPatient";

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

  Uint8List? personalImageBytes;
  Uint8List? frontIdImageBytes;
  Uint8List? backIdImageBytes;
  double imageWidth = 200;
  double imageHeight = 200;

  @override
  void initState() {
    addNew = widget.patientID == 0;

    if (addNew) {
      //siteController.setAppBarWidget();
      patient.maritalStatus = "Married";
      patient.gender = "Male";
      patient.patientType = EnumPatientType.CIA;
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
          if (!edit && !addNew && (snapshot.data as API_Response).statusCode == 200) {
            patient = (snapshot.data as API_Response).result as PatientInfoModel;
          }
          if (addNew)
            PatientAPI.GetNextAvailableId().then((value) {
              _getxController.nextAvailableId.value = value.result as int;
              patient.id = value.result as int;
            });
          return Padding(
            padding: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                TitleWidget(title: "Patient's Data", showBackButton: true),
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
                                  addNew
                                      ? Container()
                                      : CIA_PrimaryButton(
                                          label: "Show Receipts and Payments",
                                          onTab: () {
                                            ReceiptDataSource dataSource = ReceiptDataSource();
                                            CIA_ShowPopUp(
                                              width: 900,
                                              context: context,
                                              child: Column(
                                                children: [
                                                  FormTextKeyWidget(text: "Click on receipt to view payment log"),
                                                  Expanded(
                                                    child: CIA_Table(
                                                      columnNames: dataSource.columns,
                                                      dataSource: dataSource,
                                                      loadFunction: () async {
                                                        return await dataSource.loadData(id: widget.patientID);
                                                      },
                                                      onCellClick: (index) async {
                                                        PaymentLogDataSrouce logDataSource = PaymentLogDataSrouce();

                                                        CIA_ShowPopUp(
                                                          width: 1000,
                                                          context: context,
                                                          child: StatefulBuilder(builder: (context, setState) {
                                                            ReceiptModel receipt = ReceiptModel();

                                                            return CIA_FutureBuilder(
                                                              loadFunction: () async {
                                                                await logDataSource.loadData(id: widget.patientID, receiptId: dataSource.models[index - 1].id!);
                                                                await dataSource.loadData(id: widget.patientID);
                                                                return await PatientAPI.GetReceiptById(dataSource.models[index - 1].id!);
                                                              }(),
                                                              onSuccess: (data) {
                                                                receipt = data as ReceiptModel;
                                                                return Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Column(
                                                                        children: [
                                                                          Expanded(
                                                                            child: SingleChildScrollView(
                                                                              child: Column(
                                                                                children: [
                                                                                  SizedBox(height: 10),
                                                                                  Row(
                                                                                    children: [
                                                                                      Expanded(child: FormTextKeyWidget(text: "Date")),
                                                                                      Expanded(child: FormTextValueWidget(text: receipt.date ?? "")),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(height: 10),
                                                                                  Row(
                                                                                    children: [
                                                                                      Expanded(child: FormTextKeyWidget(text: "Patient ID")),
                                                                                      Expanded(
                                                                                          child: FormTextValueWidget(
                                                                                              text: (receipt.patient!.id ?? "").toString())),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(height: 10),
                                                                                  Row(
                                                                                    children: [
                                                                                      Expanded(child: FormTextKeyWidget(text: "Patient Name")),
                                                                                      Expanded(child: FormTextValueWidget(text: receipt.patient!.name ?? "")),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(height: 10),
                                                                                  Row(
                                                                                    children: [
                                                                                      Expanded(child: FormTextKeyWidget(text: "Operator")),
                                                                                      Expanded(child: FormTextValueWidget(text: receipt.operator!.name ?? "")),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(height: 10),
                                                                                  Column(
                                                                                    children: () {
                                                                                      List<Widget> r = [];
                                                                                      receipt.toothReceiptData!.forEach((element) {
                                                                                        r.add(Visibility(
                                                                                          visible: (element.crown ?? 0) != 0,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.only(bottom: 10),
                                                                                            child: Row(
                                                                                              children: [
                                                                                                Expanded(
                                                                                                    child: FormTextKeyWidget(
                                                                                                        text: "tooth ${element.tooth.toString()} Crown")),
                                                                                                Expanded(
                                                                                                    child: FormTextValueWidget(
                                                                                                        text: (element.crown ?? 0).toString())),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ));
                                                                                        r.add(Visibility(
                                                                                          visible: (element.scaling ?? 0) != 0,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.only(bottom: 10),
                                                                                            child: Row(
                                                                                              children: [
                                                                                                Expanded(
                                                                                                    child: FormTextKeyWidget(
                                                                                                        text: "tooth ${element.tooth.toString()} Scaling")),
                                                                                                Expanded(
                                                                                                    child: FormTextValueWidget(
                                                                                                        text: (element.scaling ?? 0).toString())),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ));
                                                                                        r.add(Visibility(
                                                                                          visible: (element.extraction ?? 0) != 0,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.only(bottom: 10),
                                                                                            child: Row(
                                                                                              children: [
                                                                                                Expanded(
                                                                                                    child: FormTextKeyWidget(
                                                                                                        text: "tooth ${element.tooth.toString()} Extraction")),
                                                                                                Expanded(
                                                                                                    child: FormTextValueWidget(
                                                                                                        text: (element.extraction ?? 0).toString())),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ));
                                                                                        r.add(Visibility(
                                                                                          visible: (element.restoration ?? 0) != 0,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.only(bottom: 10),
                                                                                            child: Row(
                                                                                              children: [
                                                                                                Expanded(
                                                                                                    child: FormTextKeyWidget(
                                                                                                        text: "tooth ${element.tooth.toString()} Restoration")),
                                                                                                Expanded(
                                                                                                    child: FormTextValueWidget(
                                                                                                        text: (element.restoration ?? 0).toString())),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ));
                                                                                        r.add(Visibility(
                                                                                          visible: (element.rootCanalTreatment ?? 0) != 0,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.only(bottom: 10),
                                                                                            child: Row(
                                                                                              children: [
                                                                                                Expanded(
                                                                                                    child: FormTextKeyWidget(
                                                                                                        text:
                                                                                                            "tooth ${element.tooth.toString()} Root Canal Treatment")),
                                                                                                Expanded(
                                                                                                    child: FormTextValueWidget(
                                                                                                        text: (element.rootCanalTreatment ?? 0).toString())),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ));
                                                                                        r.add(Divider());
                                                                                      });
                                                                                      return r;
                                                                                    }(),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Divider(),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(bottom: 10),
                                                                            child: Row(
                                                                              children: [
                                                                                Expanded(child: FormTextKeyWidget(text: "Total")),
                                                                                Expanded(child: FormTextValueWidget(text: (receipt.total ?? 0).toString())),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(bottom: 10),
                                                                            child: Row(
                                                                              children: [
                                                                                Expanded(child: FormTextKeyWidget(text: "Paid amount")),
                                                                                Expanded(
                                                                                    child: FormTextValueWidget(
                                                                                        color: Colors.green, text: (receipt.paid ?? 0).toString())),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(bottom: 10),
                                                                            child: Row(
                                                                              children: [
                                                                                Expanded(child: FormTextKeyWidget(text: "Unpaid amount")),
                                                                                Expanded(
                                                                                    child: FormTextValueWidget(
                                                                                        color: receipt.unpaid != 0 ? Colors.red : Colors.black,
                                                                                        text: (receipt.unpaid ?? 0).toString())),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          CIA_PrimaryButton(
                                                                              label: "Add payment",
                                                                              onTab: () async {
                                                                                int newPrice = 0;
                                                                                CIA_ShowPopUp(
                                                                                  height: 200,
                                                                                  context: context,
                                                                                  onSave: () async {
                                                                                    var res =
                                                                                        await PatientAPI.AddPayment(widget.patientID, receipt.id!, newPrice);
                                                                                    if (res.statusCode == 200) {
                                                                                      ShowSnackBar(context, isSuccess: true);
                                                                                      setState(() {});
                                                                                      Navigator.of(context, rootNavigator: true).pop();

                                                                                    }
                                                                                  },
                                                                                  child: CIA_TextFormField(
                                                                                    label: "New payment",
                                                                                    isNumber: true,
                                                                                    controller: TextEditingController(),
                                                                                    onChange: (v) => newPrice = int.parse(v),
                                                                                    validator: (value) {
                                                                                      if (int.parse(value) >= receipt.unpaid!)
                                                                                        value = receipt.unpaid!.toString();
                                                                                      return value;
                                                                                    },
                                                                                  ),
                                                                                );
                                                                              })
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Expanded(
                                                                      child: Column(
                                                                        children: [
                                                                          FormTextKeyWidget(
                                                                              text: "Payment log for receipt Id ${dataSource.models[index - 1].id}"),
                                                                          Expanded(
                                                                            child: CIA_Table(
                                                                              columnNames: logDataSource.columns,
                                                                              dataSource: logDataSource,
                                                                              loadFunction: () async {
                                                                                return await logDataSource.loadData(
                                                                                    id: widget.patientID, receiptId: dataSource.models[index - 1].id!);
                                                                              },
                                                                            ),
                                                                          ),
                                                                          FormTextKeyWidget(
                                                                              text: "Total paid ${() {
                                                                            int paid = 0;
                                                                            logDataSource.models.forEach((element) {
                                                                              paid += element.paidAmount ?? 0;
                                                                            });
                                                                            return paid.toString();
                                                                          }()}"),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          }),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                  Expanded(child: SizedBox())
                                ],
                              ),
                              addNew
                                  ? Row(
                                      children: [
                                        Obx(
                                          () => Expanded(
                                            child: CIA_TextFormField(
                                              isNumber: true,
                                              onChange: (value) async {
                                                patient.id = int.parse(value);
                                                var res = await PatientAPI.CheckDuplicateId(patient.id!);
                                                if (res.statusCode == 200) _getxController.duplicateId.value = res.result != null;
                                              },
                                              label: "Id",
                                              controller: TextEditingController(text: _getxController.nextAvailableId.value.toString()),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        FormTextKeyWidget(text: "Next Available Id"),
                                        SizedBox(width: 10),
                                        Obx(
                                          () => FormTextValueWidget(text: _getxController.nextAvailableId.value.toString()),
                                        ),
                                        SizedBox(width: 10),
                                        Obx(
                                          () => _getxController.duplicateId.value
                                              ? FormTextValueWidget(
                                                  text: "Duplicate Id",
                                                  color: Colors.red,
                                                )
                                              : FormTextValueWidget(text: "Valid Id", color: Colors.green),
                                        )
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "ID")),
                                        Expanded(child: FormTextValueWidget(text: patient?.id.toString() == null ? "" : patient?.id.toString()))
                                      ],
                                    ),

                              Visibility(
                                visible: addNew && siteController.getSite() == Website.Lab,
                                child: CIA_MultiSelectChipWidget(
                                  key: GlobalKey(),
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
                                    CIA_MultiSelectChipWidgeModel(label: "CIA", isSelected: patient.patientType == EnumPatientType.CIA),
                                    CIA_MultiSelectChipWidgeModel(label: "Clinic", isSelected: patient.patientType == EnumPatientType.Clinic),
                                    CIA_MultiSelectChipWidgeModel(label: "OutSource", isSelected: patient.patientType == EnumPatientType.OutSource),
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
                                  ? CIA_TextFormField(
                                      onChange: (value) {
                                        patient.nationalId = value;
                                      },
                                      isNumber: true,
                                      label: "National ID",
                                      errorFunction: (value) {
                                        return value.length != 14;
                                      },
                                      controller: TextEditingController(text: patient?.nationalId == null ? "" : patient?.nationalId),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "National Id")),
                                        Expanded(child: FormTextValueWidget(text: patient?.nationalId == null ? "" : patient?.nationalId))
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
                                      isPhoneNumber: true,
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
                                      isPhoneNumber: true,
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
                                  ? CIA_DateTimeTextFormField(
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
                                    text: "Registration: ${addNew ? siteController.getUser().name! : patient.registeredBy!.name!}",
                                    secondaryInfo: true,
                                  )),
                                  Expanded(
                                      child: FormTextValueWidget(
                                    text: addNew ? DateTime.now().toLocal().toString() : patient.registerationDate ?? "",
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
                          child: CIA_FutureBuilder(
                            loadFunction: () async {
                              if (!edit && !addNew && patient.profileImageId != null)
                                await PatientAPI.DownloadImage(patient.profileImageId!).then(
                                  (value) {
                                    if (value.statusCode == 200) personalImageBytes = base64Decode(value.result as String);
                                  },
                                );
                              if (!edit && !addNew && patient.idFrontImageId != null)
                                await PatientAPI.DownloadImage(patient.idFrontImageId!).then(
                                  (value) {
                                    if (value.statusCode == 200) frontIdImageBytes = base64Decode(value.result as String);
                                  },
                                );
                              if (!edit && !addNew && patient.idBackImageId != null)
                                await PatientAPI.DownloadImage(patient.idBackImageId!).then(
                                  (value) {
                                    if (value.statusCode == 200) backIdImageBytes = base64Decode(value.result as String);
                                  },
                                );
                              return Future.value(API_Response(statusCode: 200));
                            }(),
                            onSuccess: (date) {
                              return Column(
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      personalImageBytes == null
                                          ? Image(
                                              image: AssetImage("assets/ProfileImage.png"),
                                              height: imageHeight,
                                              width: imageWidth,
                                            )
                                          : Image(
                                              image: MemoryImage(personalImageBytes!),
                                              height: imageHeight,
                                              width: imageWidth,
                                            ),
                                      SizedBox(height: 10),
                                      Visibility(
                                        visible: edit || addNew,
                                        child: CIA_SecondaryButton(
                                            label: "Upload Image",
                                            onTab: () async {
                                              personalImageBytes = await ImagePickerWeb.getImageAsBytes();
                                              setState(() {});
                                            }),
                                      )
                                    ],
                                  )),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          children: [
                                            frontIdImageBytes == null
                                                ? Image(
                                                    image: AssetImage("assets/userIDFront.png"),
                                                    height: imageHeight,
                                                    width: imageWidth,
                                                  )
                                                : Image(
                                                    image: MemoryImage(frontIdImageBytes!),
                                                    height: imageHeight,
                                                    width: imageWidth,
                                                  ),
                                            SizedBox(height: 10),
                                            Visibility(
                                              visible: edit || addNew,
                                              child: CIA_SecondaryButton(
                                                  label: "Upload Image",
                                                  onTab: () async {
                                                    frontIdImageBytes = await ImagePickerWeb.getImageAsBytes();

                                                    setState(() {});
                                                  }),
                                            )
                                          ],
                                        )),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            backIdImageBytes == null
                                                ? Image(
                                                    image: AssetImage("assets/userIDBack.png"),
                                                    height: imageHeight,
                                                    width: imageWidth,
                                                  )
                                                : Image(
                                                    image: MemoryImage(backIdImageBytes!),
                                                    height: imageHeight,
                                                    width: imageWidth,
                                                  ),
                                            SizedBox(height: 10),
                                            Visibility(
                                              visible: edit || addNew,
                                              child: CIA_SecondaryButton(
                                                  label: "Upload Image",
                                                  onTab: () async {
                                                    backIdImageBytes = await ImagePickerWeb.getImageAsBytes();
                                                    setState(() {});
                                                  }),
                                            )
                                          ],
                                        )),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
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
                                  if (_getxController.duplicateId.value) {
                                    ShowSnackBar(context, isSuccess: false, message: "Duplicate Id");
                                    return;
                                  }
                                  var response = await PatientAPI.CreatePatient(patient);
                                  if (response.statusCode == 200) {
                                    patient = response.result as PatientInfoModel;

                                  }
                                  if (widget.onSave != null) widget.onSave!(response);
                                  if (response.statusCode == 200) {
                                    ShowSnackBar(context, isSuccess: true, title: "Succeed!", message: "Uploading Images...");
                                    if (personalImageBytes != null)
                                      response = await PatientAPI.UploadImage(patient.id!, EnumImageType.PatientProfile, personalImageBytes!);
                                    if (backIdImageBytes != null) response = await PatientAPI.UploadImage(patient.id!, EnumImageType.IdBack, backIdImageBytes!);
                                    if (frontIdImageBytes != null)
                                      response = await PatientAPI.UploadImage(patient.id!, EnumImageType.IdFront, frontIdImageBytes!);

                                    if (response.statusCode == 200) {
                                      ShowSnackBar(context, isSuccess: true, title: "Succeed!", message: "Patient has been added successfully!");
                                    } else
                                      ShowSnackBar(context, isSuccess: false, title: "Failed!", message: "Patient added but failed to upload images");
                                  } else
                                    ShowSnackBar(context, isSuccess: false, title: "Failed!", message: response.errorMessage!);

                                  if (response.statusCode == 200) {

                                    PatientAPI.GetNextAvailableId().then((value) {
                                      if (value.statusCode == 200) {
                                        {
                                          if (addNew) patient = PatientInfoModel(id: value.result as int);
                                          setState(() {});
                                          _getxController.nextAvailableId.value = value.result as int;
                                          PatientAPI.CheckDuplicateId(patient.id!).then((_) {
                                            _getxController.duplicateId.value = (_.statusCode == 200 && _.result != null);
                                          });
                                        }
                                      }
                                    });
                                  }

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

                                            if (response.statusCode == 200) {
                                              ShowSnackBar(context, isSuccess: true, title: "Succeed!", message: "Uploading Images...");
                                              if (personalImageBytes != null)
                                                response = await PatientAPI.UploadImage(patient.id!, EnumImageType.PatientProfile, personalImageBytes!);
                                              if (backIdImageBytes != null)
                                                response = await PatientAPI.UploadImage(patient.id!, EnumImageType.IdBack, backIdImageBytes!);
                                              if (frontIdImageBytes != null)
                                                response = await PatientAPI.UploadImage(patient.id!, EnumImageType.IdFront, frontIdImageBytes!);

                                              if (response.statusCode == 200) {
                                                ShowSnackBar(context, isSuccess: true, title: "Succeed!", message: "Patient has been added successfully!");
                                              } else
                                                ShowSnackBar(context, isSuccess: false, title: "Failed!", message: "Patient added but failed to upload images");
                                            } else
                                              ShowSnackBar(context, isSuccess: false, title: "Failed!", message: response.errorMessage!);

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
  PatientVisits_SharedPage({Key? key, required this.patientID, this.patientName}) : super(key: key);

  static String getPath(String id) {
    return "/Patients/$id/VisitsLogs";
  }

  static String routeName = "VisitsLogs";
  static String routePath = "Patients/:id/VisitsLogs";
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
        future: dataSource.loadData(id: widget.patientID),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(top: 5, left: 10),
              child: Column(
                children: [
                  TitleWidget(
                    title: "Visits",
                    showBackButton: true,
                  ),
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
                                        ShowSnackBar(context, isSuccess: true, title: "Success", message: "");
                                      } else {
                                        ShowSnackBar(context, isSuccess: false, title: "Failed", message: res.errorMessage ?? "Couldn't perform action");
                                      }
                                    }),
                                CIA_SecondaryButton(
                                    width: 180,
                                    label: "Patient Enters Clinic",
                                    onTab: () async {
                                      var res = await PatientAPI.PatientEntersClinic(widget.patientID);
                                      if (res.statusCode == 200) {
                                        dataSource.setData(res.result as List<VisitsModel>);
                                        ShowSnackBar(context, isSuccess: true, title: "Success", message: "");
                                      } else {
                                        ShowSnackBar(context, isSuccess: false, title: "Failed", message: res.errorMessage ?? "Couldn't perform action");
                                      }
                                    }),
                                CIA_SecondaryButton(
                                    width: 150,
                                    label: "Patient Leaves",
                                    onTab: () async {
                                      var res = await PatientAPI.GetTodaysReceipt(widget.patientID);
                                      ReceiptModel receipt = ReceiptModel();
                                      if (res.statusCode == 200) receipt = res.result as ReceiptModel;
                                      int newPayment = 0;
                                      int debt = 0;
                                      res = await PatientAPI.GetTotalDebt(widget.patientID);
                                      if (res.statusCode == 200) debt = res.result as int;
                                      if (debt != 0)
                                        await CIA_ShowPopUp(
                                            width: 500,
                                            context: context,
                                            title: "Receipt",
                                            onSave: () async {
                                              if (newPayment != 0) {
                                                PatientAPI.AddPayment(widget.patientID, receipt.id!, newPayment).then((value) => ShowSnackBar(context,
                                                    isSuccess: value.statusCode == 200,
                                                    message: value.statusCode == 200 ? "Added Payment" : "Failed to add payment"));
                                              }
                                            },
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(child: FormTextKeyWidget(text: "Patient total debt")),
                                                            Expanded(
                                                                child:
                                                                    FormTextValueWidget(color: debt != 0 ? Colors.red : Colors.black, text: debt.toString())),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        Row(
                                                          children: [
                                                            Expanded(child: FormTextKeyWidget(text: "Date")),
                                                            Expanded(child: FormTextValueWidget(text: receipt.date ?? "")),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        Row(
                                                          children: [
                                                            Expanded(child: FormTextKeyWidget(text: "Patient ID")),
                                                            Expanded(child: FormTextValueWidget(text: (receipt.patient!.id ?? "").toString())),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        Row(
                                                          children: [
                                                            Expanded(child: FormTextKeyWidget(text: "Patient Name")),
                                                            Expanded(child: FormTextValueWidget(text: receipt.patient!.name ?? "")),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        Row(
                                                          children: [
                                                            Expanded(child: FormTextKeyWidget(text: "Operator")),
                                                            Expanded(child: FormTextValueWidget(text: receipt.operator!.name ?? "")),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        Column(
                                                          children: () {
                                                            List<Widget> r = [];
                                                            receipt.toothReceiptData!.forEach((element) {
                                                              r.add(Visibility(
                                                                visible: (element.crown ?? 0) != 0,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(bottom: 10),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(child: FormTextKeyWidget(text: "tooth ${element.tooth.toString()} Crown")),
                                                                      Expanded(child: FormTextValueWidget(text: (element.crown ?? 0).toString())),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ));
                                                              r.add(Visibility(
                                                                visible: (element.scaling ?? 0) != 0,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(bottom: 10),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(child: FormTextKeyWidget(text: "tooth ${element.tooth.toString()} Scaling")),
                                                                      Expanded(child: FormTextValueWidget(text: (element.scaling ?? 0).toString())),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ));
                                                              r.add(Visibility(
                                                                visible: (element.extraction ?? 0) != 0,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(bottom: 10),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(child: FormTextKeyWidget(text: "tooth ${element.tooth.toString()} Extraction")),
                                                                      Expanded(child: FormTextValueWidget(text: (element.extraction ?? 0).toString())),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ));
                                                              r.add(Visibility(
                                                                visible: (element.restoration ?? 0) != 0,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(bottom: 10),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(child: FormTextKeyWidget(text: "tooth ${element.tooth.toString()} Restoration")),
                                                                      Expanded(child: FormTextValueWidget(text: (element.restoration ?? 0).toString())),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ));
                                                              r.add(Visibility(
                                                                visible: (element.rootCanalTreatment ?? 0) != 0,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(bottom: 10),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                          child: FormTextKeyWidget(
                                                                              text: "tooth ${element.tooth.toString()} Root Canal Treatment")),
                                                                      Expanded(child: FormTextValueWidget(text: (element.rootCanalTreatment ?? 0).toString())),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ));
                                                              r.add(Divider());
                                                            });
                                                            return r;
                                                          }(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Divider(),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 10),
                                                  child: Row(
                                                    children: [
                                                      Expanded(child: FormTextKeyWidget(text: "Total")),
                                                      Expanded(child: FormTextValueWidget(text: (receipt.total ?? 0).toString())),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 10),
                                                  child: Row(
                                                    children: [
                                                      Expanded(child: FormTextKeyWidget(text: "Paid amount")),
                                                      Expanded(child: FormTextValueWidget(color: Colors.green, text: (receipt.paid ?? 0).toString())),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 10),
                                                  child: Row(
                                                    children: [
                                                      Expanded(child: FormTextKeyWidget(text: "Unpaid amount")),
                                                      Expanded(
                                                          child: FormTextValueWidget(
                                                              color: receipt.unpaid != 0 ? Colors.red : Colors.black, text: (receipt.unpaid ?? 0).toString())),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 10),
                                                  child: CIA_TextFormField(
                                                    label: "New Payment",
                                                    isNumber: true,
                                                    controller: TextEditingController(text: "0"),
                                                    suffix: "EGP",
                                                    onChange: (v) => newPayment = int.parse(v),
                                                  ),
                                                ),
                                              ],
                                            ));
                                      res = await PatientAPI.PatientLeaves(widget.patientID);
                                      if (res.statusCode == 200) {
                                        dataSource.setData(res.result as List<VisitsModel>);
                                        ShowSnackBar(context, isSuccess: true, title: "Success", message: "");
                                      } else {
                                        ShowSnackBar(context, isSuccess: false, title: "Failed", message: res.errorMessage ?? "Couldn't perform action");
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
                  Expanded(flex: 12, child: CIA_Table(columnNames: dataSource.columns, dataSource: dataSource, onCellClick: (value) {}))
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

  static String getPath(String id) {
    return "/Patients/Patient/$id/Complains";
  }

  static String routeName = "Complains";
  static String routePath = "Patients/:id/Complains";

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
            TitleWidget(
              title: "Complains",
              showBackButton: true,
            ),
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
                          ShowSnackBar(context, isSuccess: true, title: "Added", message: "");
                          setState(() {});
                        } else
                          ShowSnackBar(context, isSuccess: false, title: "Failed", message: value.errorMessage ?? "");
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    e.comment ?? "",
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "Notes: " + (e.notes ?? ""),
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    e.status == EnumComplainStatus.Untouched
                                        ? CIA_SecondaryButton(
                                            label: "Start working on complain",
                                            onTab: () async {
                                              await PatientAPI.InQueueComplain(e.id!, null).then((value) {
                                                if (value.statusCode == 200) complains = value.result as List<ComplainsModel>;
                                                setState(() {});
                                              });
                                            },
                                          )
                                        : e.status == EnumComplainStatus.InQueue
                                            ? Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  CIA_SecondaryButton(
                                                    label: "Update Notes",
                                                    onTab: () async {
                                                      CIA_ShowPopUp(
                                                        context: context,
                                                        onSave: () async {
                                                          await PatientAPI.UpdateComplainNotes(e.id!, e.notes ?? "").then((value) {
                                                            if (value.statusCode == 200) complains = value.result as List<ComplainsModel>;
                                                            setState(() {});
                                                          });
                                                        },
                                                        child: CIA_TextFormField(
                                                          label: "Notes",
                                                          controller: TextEditingController(text: e.notes),
                                                          onChange: (v) => e.notes = v,
                                                          maxLines: 5,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  CIA_PrimaryButton(
                                                    label: "Resolve",
                                                    isLong: true,
                                                    onTab: () async {
                                                      await PatientAPI.ResolveComplain(e.id!).then((value) {
                                                        if (value.statusCode == 200) complains = value.result as List<ComplainsModel>;
                                                        setState(() {});
                                                      });
                                                    },
                                                  ),
                                                ],
                                              )
                                            : RoundCheckBox(
                                                onTap: e.status == EnumComplainStatus.Resolved!
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
                                                isChecked: e.status == EnumComplainStatus.Resolved,
                                              ),
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
