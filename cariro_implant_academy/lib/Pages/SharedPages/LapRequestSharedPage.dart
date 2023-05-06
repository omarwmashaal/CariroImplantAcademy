import 'package:cariro_implant_academy/API/LAB_RequestsAPI.dart';
import 'package:cariro_implant_academy/API/Lab_CustomerAPI.dart';
import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Models/LAB_CustomerModel.dart';
import 'package:cariro_implant_academy/Models/LAB_RequestModel.dart';
import 'package:cariro_implant_academy/Models/Lab_PatientModel.dart';
import 'package:cariro_implant_academy/Models/Lab_StepModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../API/UserAPI.dart';
import '../../Models/API_Response.dart';
import '../../Models/ApplicationUserModel.dart';
import '../../Models/PatientInfo.dart';
import '../../Widgets/CIA_CheckBoxWidget.dart';
import '../../Widgets/CIA_Table.dart';
import '../../Widgets/FormTextWidget.dart';
import 'PatientSharedPages.dart';

class LapRequestSharedPage extends StatefulWidget {
  LapRequestSharedPage({
    Key? key,
    this.isDoctor = false,
    this.onChange,
    this.patient
  }) : super(key: key);
  bool isDoctor;
  Function? onChange;
  PatientInfoModel? patient;

  @override
  State<LapRequestSharedPage> createState() => _LapRequestSharedPageState();
}

class _LapRequestSharedPageState extends State<LapRequestSharedPage> {
  LAB_RequestModel labRequest = LAB_RequestModel();

  late Function globalSetState;

  @override
  Widget build(BuildContext buildContext) {
    return Column(
      children: [
        Expanded(
          flex: 10,
          child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: ListView(
              children: [
                FocusTraversalGroup(
                  policy: OrderedTraversalPolicy(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: CIA_TextFormField(
                              label: "Doctor",
                              enabled: false,
                              controller: TextEditingController(text: labRequest.customer!.name ?? ""),
                              onTap: widget.isDoctor
                                  ? null
                                  : () {
                                      {
                                        EnumLabRequestSources selectedSource = EnumLabRequestSources.CIA;
                                        String search = "";
                                        _PatientDoctorsSearchDataSource dataSource = _PatientDoctorsSearchDataSource(type: _SearchDataType.Doctors);
                                        CIA_ShowPopUp(
                                          width: 900,
                                          height: 600,
                                          context: buildContext,
                                          onSave: () => setState(() {}),
                                          child: StatefulBuilder(builder: (context, setState) {
                                            return Column(
                                              children: [
                                                CIA_PrimaryButton(
                                                  label: "Add New Customer",
                                                  onTab: () {
                                                    ApplicationUserModel newCustomer = ApplicationUserModel();
                                                    bool newWorkPlace = false;
                                                    Alert(
                                                      context: buildContext,
                                                      title: "Add new customer",
                                                      content: StatefulBuilder(builder: (context, setState) {
                                                        return Column(
                                                          children: [
                                                            CIA_TextFormField(
                                                              label: "Name",
                                                              controller: TextEditingController(text: newCustomer.name ?? ""),
                                                              onChange: (v) => newCustomer.name = v,
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            CIA_TextFormField(
                                                              label: "Phone Number 1",
                                                              isNumber: true,
                                                              controller: TextEditingController(text: newCustomer.phoneNumber ?? ""),
                                                              onChange: (v) => newCustomer.phoneNumber = v,
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            CIA_TextFormField(
                                                              label: "Phone Number 2",
                                                              isNumber: true,
                                                              controller: TextEditingController(text: newCustomer.phoneNumber2 ?? ""),
                                                              onChange: (v) => newCustomer.phoneNumber2 = v,
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: CIA_MultiSelectChipWidget(
                                                                      onChange: (item, isSelected) {
                                                                        newWorkPlace = isSelected;
                                                                        setState(() {});
                                                                      },
                                                                      labels: [CIA_MultiSelectChipWidgeModel(label: "New Work Place")]),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child: newWorkPlace
                                                                      ? CIA_TextFormField(
                                                                          label: "New Work Place Name",
                                                                          controller: TextEditingController(
                                                                              text: newCustomer.workPlace == null ? "" : newCustomer.workPlace!.name ?? ""),
                                                                          onChange: (v) {
                                                                            newCustomer.workPlace = DropDownDTO(name: v);
                                                                            newCustomer.workPlaceId = null;
                                                                          },
                                                                        )
                                                                      : CIA_DropDownSearch(
                                                                          asyncItems: Lab_CustomerAPI.GetAllWorkPlaces,
                                                                          onSelect: (value) {
                                                                            newCustomer.workPlace = value;
                                                                            newCustomer.workPlaceId = value.id;
                                                                          },
                                                                        ),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                          ],
                                                        );
                                                      }),
                                                      buttons: [
                                                        DialogButton(
                                                          color: Color_Accent,
                                                          width: 150,
                                                          onPressed: () async {
                                                            newCustomer.workPlaceEnum = EnumLabRequestSources.OutSource;
                                                            var res = await Lab_CustomerAPI.AddCustomer(newCustomer);
                                                            if (res.statusCode == 200) {
                                                              ShowSnackBar(isSuccess: true, title: "Success", message: "Customer Added!");
                                                              labRequest.customer = res.result as ApplicationUserModel;
                                                              globalSetState(() {});
                                                              Navigator.pop(buildContext);
                                                              Navigator.pop(buildContext);
                                                            } else
                                                              ShowSnackBar(isSuccess: false, title: "Failed", message: res.errorMessage ?? "");
                                                          },
                                                          child: Text(
                                                            "Ok",
                                                            style: TextStyle(color: Colors.white, fontSize: 20),
                                                          ),
                                                        ),
                                                      ],
                                                    ).show();
                                                  },
                                                ),
                                                SizedBox(height: 10),
                                                CIA_MultiSelectChipWidget(
                                                  singleSelect: true,
                                                  onChange: (item, isSelected) {
                                                    if (item == "CIA Doctors")
                                                      selectedSource = EnumLabRequestSources.CIA;
                                                    else if (item == "Clinic Doctors")
                                                      selectedSource = EnumLabRequestSources.Clinic;
                                                    else if (item == "Outsource Doctors") selectedSource = EnumLabRequestSources.OutSource;
                                                    dataSource.models = [];
                                                    dataSource.init();
                                                    dataSource.notifyListeners();
                                                  },
                                                  labels: [
                                                    CIA_MultiSelectChipWidgeModel(label: "CIA Doctors", isSelected: selectedSource == "CIA Doctors"),
                                                    CIA_MultiSelectChipWidgeModel(label: "Clinic Doctors", isSelected: selectedSource == "Clinic Doctors"),
                                                    CIA_MultiSelectChipWidgeModel(
                                                        label: "Outsource Doctors", isSelected: selectedSource == "Outsource Doctors"),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                CIA_TextFormField(
                                                  label: "Search",
                                                  controller: TextEditingController(text: search),
                                                  onChange: (v) {
                                                    dataSource.loadData(search: v ?? "", source: selectedSource);
                                                  },
                                                ),
                                                SizedBox(height: 10),
                                                CIA_Table(
                                                  columnNames: dataSource.columns,
                                                  dataSource: dataSource,
                                                  loadFunction: () async {
                                                    return dataSource.loadData(search: "", source: selectedSource);
                                                  },
                                                  onCellClick: (index) async {
                                                    var p = dataSource.models[index - 1];
                                                    labRequest.customer!.name = p.name;
                                                    labRequest.customer!.idInt = p.id;
                                                    labRequest.customerId = p.id;
                                                    var res = await UserAPI.GetUserData(p.id!);
                                                    if (res.statusCode == 200) labRequest.customer = res.result as ApplicationUserModel;
                                                    Navigator.pop(context);
                                                    globalSetState(() {});
                                                  },
                                                )
                                              ],
                                            );
                                          }),
                                        );
                                      }
                                    },
                            ),
                          ),

                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CIA_TextFormField(
                                onTap: () {
                                  CIA_PopupDialog_DateOnlyPicker(buildContext, "Delivery Date", (value) {
                                    setState(() {
                                      labRequest.deliveryDate = value;
                                    });
                                  });
                                },
                                label: "Delivery Date",
                                controller: TextEditingController(text: labRequest.deliveryDate ?? "")),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CIA_TextFormField(
                              label: "Phone",
                              controller: TextEditingController(text: labRequest.customer!.phoneNumber ?? ""),
                              onChange: (v) => labRequest.customer!.phoneNumber = v,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CIA_TextFormField(
                            label: "Step Required",
                            controller: TextEditingController(text: labRequest.requiredStep ?? ""),
                            onChange: (v) => labRequest.requiredStep = v,
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CIA_TextFormField(
                              label: "Patient",
                              enabled: false,
                              controller: TextEditingController(text: labRequest.patient!.name ?? ""),
                              onTap: widget.isDoctor?null: () {
                                {
                                  EnumLabRequestSources selectedSource = EnumLabRequestSources.CIA;
                                  String search = "";
                                  _PatientDoctorsSearchDataSource dataSource = _PatientDoctorsSearchDataSource(type: _SearchDataType.Patients);
                                  CIA_ShowPopUp(
                                    width: 900,
                                    height: 600,
                                    context: buildContext,
                                    onSave: () => setState(() {}),
                                    child: StatefulBuilder(builder: (context, setState) {
                                      return Column(
                                        children: [
                                          CIA_PrimaryButton(
                                            label: "Create New Patient",
                                            onTab: () {
                                              PatientInfoModel newPatient = PatientInfoModel();
                                              CIA_ShowPopUp(
                                                width: 600,
                                                height: 800,
                                                hideButton: true,
                                                context: context,
                                                onSave: () {},
                                                child: PatientInfo_SharedPage(
                                                  patientID: 0,
                                                  onSave: (response) {
                                                    if (response.statusCode == 200) {
                                                      var res = response.result as PatientInfoModel;
                                                      labRequest.patientId = res.id;
                                                      labRequest.patient = DropDownDTO(name: res.name, id: res.id);
                                                    }
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    globalSetState(() {});
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(height: 10),
                                          CIA_MultiSelectChipWidget(
                                            singleSelect: true,
                                            onChange: (item, isSelected) {
                                              if (item == "CIA Patients")
                                                selectedSource = EnumLabRequestSources.CIA;
                                              else if (item == "Clinic Patients")
                                                selectedSource = EnumLabRequestSources.Clinic;
                                              else if (item == "Outsource Patients") selectedSource = EnumLabRequestSources.OutSource;
                                              dataSource.models = [];
                                              dataSource.init();
                                              dataSource.notifyListeners();
                                            },
                                            labels: [
                                              CIA_MultiSelectChipWidgeModel(label: "CIA Patients", isSelected: selectedSource == "CIA Patients"),
                                              CIA_MultiSelectChipWidgeModel(label: "Clinic Patients", isSelected: selectedSource == "Clinic Patients"),
                                              CIA_MultiSelectChipWidgeModel(label: "Outsource Patients", isSelected: selectedSource == "Outsource Patients"),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          CIA_TextFormField(
                                            label: "Search",
                                            controller: TextEditingController(text: search),
                                            onChange: (v) {
                                              dataSource.loadData(search: v ?? "", source: selectedSource);
                                            },
                                          ),
                                          SizedBox(height: 10),
                                          CIA_Table(
                                            columnNames: dataSource.columns,
                                            dataSource: dataSource,
                                            loadFunction: () async {
                                              return dataSource.loadData(search: "", source: selectedSource);
                                            },
                                            onCellClick: (index) {
                                              var p = dataSource.models[index - 1];
                                              labRequest.patient!.name = p.name;
                                              labRequest.patient!.id = p.id;
                                              labRequest.patientId = p.id;
                                              Navigator.pop(context);
                                              globalSetState(() {});
                                            },
                                          )
                                        ],
                                      );
                                    }),
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CIA_TextFormField(
                              label: "Notes",
                              controller: TextEditingController(text: labRequest.notes ?? ""),
                              onChange: (v) => labRequest.notes = v,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CIA_SecondaryButton(
                                label: "Edit Steps",
                                onTab: () {
                                  List<LAB_StepModel> steps = labRequest.steps ?? [LAB_StepModel()];
                                  CIA_ShowPopUp(
                                      context: context,
                                      child: StatefulBuilder(builder: (context, setState) {
                                        return Column(
                                          children: () {
                                            var r = <Widget>[];
                                            r.addAll(
                                              steps.map(
                                                (e) => Padding(
                                                  padding: const EdgeInsets.only(bottom: 10),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: CIA_TextFormField(
                                                          controller: TextEditingController(text: e.name ?? ""),
                                                          label: "Step Name",
                                                          onChange: (v) => e.name = v,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                        child: CIA_TextFormField(
                                                          onTap: () {
                                                            _PatientDoctorsSearchDataSource dataSource =
                                                                _PatientDoctorsSearchDataSource(type: _SearchDataType.Technicians);
                                                            String search = "";
                                                            CIA_ShowPopUp(
                                                              width: 900,
                                                              height: 600,
                                                              context: buildContext,
                                                              onSave: () => setState(() {}),
                                                              child: Column(
                                                                children: [
                                                                  CIA_TextFormField(
                                                                    label: "Search",
                                                                    controller: TextEditingController(text: search),
                                                                    onChange: (v) {
                                                                      dataSource.loadData(search: v ?? "", source: EnumLabRequestSources.CIA);
                                                                    },
                                                                  ),
                                                                  SizedBox(height: 10),
                                                                  CIA_Table(
                                                                    columnNames: dataSource.columns,
                                                                    dataSource: dataSource,
                                                                    loadFunction: () async {
                                                                      return dataSource.loadData(search: "", source: EnumLabRequestSources.CIA);
                                                                    },
                                                                    onCellClick: (index) async {
                                                                      var p = dataSource.models[index - 1];
                                                                      var res = await UserAPI.GetUserData(p.id!);
                                                                      ApplicationUserModel user = ApplicationUserModel();
                                                                      if (res.statusCode == 200) {
                                                                        user = res.result as ApplicationUserModel;
                                                                        e.technician = DropDownDTO(name: user.name, id: user.idInt);
                                                                        e.technicianId = user.idInt;
                                                                      }

                                                                      Navigator.pop(context);
                                                                      setState(() {});
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                          enabled: false,
                                                          controller: TextEditingController(text: e.technician != null ? e.technician!.name ?? "" : ""),
                                                          label: "Assigned to",
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            steps.add(LAB_StepModel());
                                                            setState(() {});
                                                          },
                                                          icon: Icon(Icons.add)),
                                                      IconButton(
                                                          onPressed: () {
                                                            steps.remove(e);
                                                            setState(() {});
                                                          },
                                                          icon: Icon(Icons.remove))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                            return r;
                                          }(),
                                        );
                                      }),
                                      onSave: () {
                                        labRequest.steps = steps;
                                      });
                                }),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: FormTextKeyWidget(
                              text: () {
                                if (labRequest.customer != null && labRequest.customer!.workPlaceEnum != null)
                                  return EnumLabRequestSources.values[labRequest.customer!.workPlaceEnum!.index!].toString().split(".").last + " Customer";
                                else
                                  return "";
                              }(),
                              secondaryInfo: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FormTextKeyWidget(text: "Details"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                CIA_CheckBoxWidget(
                                  text: "Full zireon crown",
                                  value: labRequest.fullZireonCrown ?? false,
                                  onChange: (value) => labRequest.fullZireonCrown = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Porcelain fused to zircomium",
                                  value: labRequest.porcelainFusedToZircomium ?? false,
                                  onChange: (value) => labRequest.porcelainFusedToZircomium = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Porcelain fused to metal",
                                  value: labRequest.porcelainFusedToMetal ?? false,
                                  onChange: (value) => labRequest.porcelainFusedToMetal = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Porcelain fused to metal (CAD-CAM Co-Cr alloy)",
                                  value: labRequest.porcelainFusedToMetalCADCAMCoCrAlloy ?? false,
                                  onChange: (value) => labRequest.porcelainFusedToMetalCADCAMCoCrAlloy = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Glass ceramic crown",
                                  value: labRequest.glassCeramicCrown ?? false,
                                  onChange: (value) => labRequest.glassCeramicCrown = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Visiolign bonded to PEEK",
                                  value: labRequest.visiolignBondedToPEEK ?? false,
                                  onChange: (value) => labRequest.visiolignBondedToPEEK = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Laminate veneer",
                                  value: labRequest.laminateVeneer ?? false,
                                  onChange: (value) => labRequest.laminateVeneer = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Milled PMMA temporary crown",
                                  value: labRequest.milledPMMATemporaryCrown ?? false,
                                  onChange: (value) => labRequest.milledPMMATemporaryCrown = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Long term temporary crown",
                                  value: labRequest.longTermTemporaryCrown ?? false,
                                  onChange: (value) => labRequest.longTermTemporaryCrown = value,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                CIA_CheckBoxWidget(
                                  text: "Screw-ratained crown",
                                  value: labRequest.screwRatainedCrown ?? false,
                                  onChange: (value) => labRequest.screwRatainedCrown = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Survey crown for RPD",
                                  value: labRequest.surveyCrownForRPD ?? false,
                                  onChange: (value) => labRequest.surveyCrownForRPD = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Survey crown with extra coronal attahcment",
                                  value: labRequest.surveyCrownWithExtraCoronalAttahcment ?? false,
                                  onChange: (value) => labRequest.surveyCrownWithExtraCoronalAttahcment = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Cast post & core",
                                  value: labRequest.castPostcore ?? false,
                                  onChange: (value) => labRequest.castPostcore = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Zirconium post and core",
                                  value: labRequest.zirconiumPostAndCore ?? false,
                                  onChange: (value) => labRequest.zirconiumPostAndCore = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Custom carbon fiber post",
                                  value: labRequest.customCarbonFiberPost ?? false,
                                  onChange: (value) => labRequest.customCarbonFiberPost = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Zirconium inlay or onlay",
                                  value: labRequest.zirconiumInlayOrOnlay ?? false,
                                  onChange: (value) => labRequest.zirconiumInlayOrOnlay = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Glass ceramic inlay or onlay",
                                  value: labRequest.glassCeramicInlayOrOnlay ?? false,
                                  onChange: (value) => labRequest.glassCeramicInlayOrOnlay = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "CAD-CAM abutment",
                                  value: labRequest.caDCAMAbutment ?? false,
                                  onChange: (value) => labRequest.caDCAMAbutment = value,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                CIA_CheckBoxWidget(
                                  text: "Special tray",
                                  value: labRequest.specialTray ?? false,
                                  onChange: (value) => labRequest.specialTray = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Occlusion block",
                                  value: labRequest.occlusionBlock ?? false,
                                  onChange: (value) => labRequest.occlusionBlock = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Diagnostic or trail setup",
                                  value: labRequest.diagnosticOrTrailSetup ?? false,
                                  onChange: (value) => labRequest.diagnosticOrTrailSetup = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Flexible RPD",
                                  value: labRequest.flexibleRPD ?? false,
                                  onChange: (value) => labRequest.flexibleRPD = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Metallic RPD",
                                  value: labRequest.metallicRPD ?? false,
                                  onChange: (value) => labRequest.metallicRPD = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Night guard vacuum template",
                                  value: labRequest.nightGuardVacuumTemplate ?? false,
                                  onChange: (value) => labRequest.nightGuardVacuumTemplate = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Radiographic duplicates for CBCT",
                                  value: labRequest.radiographicDuplicatesForCBCT ?? false,
                                  onChange: (value) => labRequest.radiographicDuplicatesForCBCT = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Clear surgical templates",
                                  value: labRequest.clearSurgicalTemplates ?? false,
                                  onChange: (value) => labRequest.clearSurgicalTemplates = value,
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Diagnostic surveying",
                                  value: labRequest.diagnosticSurveying ?? false,
                                  onChange: (value) => labRequest.diagnosticSurveying = value,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          FormTextKeyWidget(
                            text: "Date of Entry",
                            secondaryInfo: true,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FormTextValueWidget(
                            text: DateFormat("dd-MM-yyyy hh:mm a").format(DateTime.now()).toString(),
                            secondaryInfo: true,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          FormTextKeyWidget(
                            text: "Entry by",
                            secondaryInfo: true,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FormTextValueWidget(
                            text: siteController.getUser().name ?? "",
                            secondaryInfo: true,
                          ),
                        ],
                      ),
                      Center(
                        child: CIA_PrimaryButton(
                          label: "Finish",
                          onTab: () async {
                            var res = await LAB_RequestsAPI.AddRequest(labRequest);
                            if (res.statusCode == 200) {
                              ShowSnackBar(isSuccess: true, title: "Success", message: "Request Added!");
                              if (widget.isDoctor)
                                Navigator.pop(context);
                              else
                                internalPagesController.goBack();
                            } else {
                              ShowSnackBar(isSuccess: false, title: "Failed", message: res.errorMessage ?? "");
                            }
                          },
                          isLong: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    globalSetState = setState;
    if (widget.isDoctor) {
      labRequest.customer = siteController.getUser();
      labRequest.customerId = siteController.getUser().idInt;
      if(widget.patient!=null)
        {
          labRequest.patient = DropDownDTO(name: widget.patient!.name,id: widget.patient!.id);
          labRequest.patientId = widget.patient!.id;
        }
    }
  }
}

enum _SearchDataType { Patients, Doctors, Technicians }

class _dummyClass {
  int? id;
  String? name;
  String? phoneNumber;

  _dummyClass({this.id, this.name, this.phoneNumber});

  _dummyClass.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    phoneNumber = json['phone'] ?? json['phoneNumber'];
  }
}

class _PatientDoctorsSearchDataSource extends DataGridSource {
  List<_dummyClass> models = <_dummyClass>[];
  var columns = ["ID", "Name", "Phone"];

  _SearchDataType type;

  /// Creates the patient data source class with required details.
  _PatientDoctorsSearchDataSource({required this.type}) {
    init();
  }

  init() {
    _data = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<String>(columnName: 'Phone', value: e.phoneNumber ?? ""),
            ]))
        .toList();
  }

  List<DataGridRow> _data = [];

  @override
  List<DataGridRow> get rows => _data;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: 50),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  Future<bool> loadData({required String search, required EnumLabRequestSources source}) async {
    late API_Response res;
    if (type == _SearchDataType.Doctors) {
      res = await UserAPI.SearchUsersByWorkplace(search: search ?? "", source: source);
    } else if (type == _SearchDataType.Patients) {
      res = await Lab_CustomerAPI.SearchPatientsByType(search: search, type: source);
    } else if (type == _SearchDataType.Technicians) {
      res = await UserAPI.SearcshUsersByRole(search: search ?? "", role: UserRoles.Technician);
    }
    if (res.statusCode! > 199 && res.statusCode! < 300) {
      if (type == _SearchDataType.Patients)
        models = (res.result as List<PatientInfoModel>).map((e) => _dummyClass(id: e.id, name: e.name, phoneNumber: e.phone)).toList();
      else if (type == _SearchDataType.Doctors)
        models = (res.result as List<ApplicationUserModel>).map((e) => _dummyClass(id: e.idInt, name: e.name, phoneNumber: e.phoneNumber)).toList();
      else if (type == _SearchDataType.Technicians)
        models = (res.result as List<ApplicationUserModel>).map((e) => _dummyClass(id: e.idInt, name: e.name, phoneNumber: e.phoneNumber)).toList();
    } else
      models = [];

    init();
    notifyListeners();
    return true;
  }
}
