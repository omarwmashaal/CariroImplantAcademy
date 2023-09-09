import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../Constants/Colors.dart';
import '../../../../../../Widgets/CIA_DropDown.dart';
import '../../../../../../Widgets/CIA_PopUp.dart';
import '../../../../../../Widgets/CIA_TextFormField.dart';
import '../../../../../../Widgets/FormTextWidget.dart';
import '../../../../../../core/injection_contianer.dart';
import '../../domain/entities/trearmentPlanPropertyEntity.dart';

class ToothStatusWidget extends StatefulWidget {
  ToothStatusWidget({Key? key,
    required this.fieldModel,
    this.price = false,
    required this.title,
    this.onDelete,
    this.assignButton = false,
    this.isImplant = false,
    this.settingsPrice = 0,
    required this.isSurgical,
    this.viewOnlyMode = false})
      : super(key: key);
  TreatmentPlanPropertyEntity fieldModel;
  String title;
  bool isImplant;
  bool assignButton;
  Function? onDelete;
  bool viewOnlyMode;
  bool price;
  int? settingsPrice;
  bool isSurgical;

  @override
  State<ToothStatusWidget> createState() => _ToothStatusWidgetState();
}

class _ToothStatusWidgetState extends State<ToothStatusWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.viewOnlyMode) {

      return Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: IconButton(
                      onPressed: () {
                        if (widget.onDelete != null) widget.onDelete!();
                      },
                      icon: Icon(Icons.delete_forever),
                      color: Colors.red,
                    )),
                Expanded(
                  child: widget.isSurgical
                      ? RoundCheckBox(
                    isChecked: widget.fieldModel.status,
                    onTap: sl<SharedPreferences>().getString("role") == "secretary"
                        ? null
                        : (selected) {
                      widget.fieldModel.status = selected;
                      if (selected!) {
                        widget.fieldModel.doneByAssistant = BasicNameIdObjectEntity(
                            name: sl<SharedPreferences>().getString("userName"), id: sl<SharedPreferences>().getInt("userid"));
                        widget.fieldModel.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                        widget.fieldModel.date = DateTime.now();
                      } else {
                        widget.fieldModel.doneByAssistant = BasicNameIdObjectEntity();
                        widget.fieldModel.doneByAssistantID = null;
                      }
                      setState(() {});
                    },
                    border: null,
                    borderColor: Colors.transparent,
                    uncheckedWidget: Icon(
                      Icons.remove,
                      color: Colors.red,
                    ),
                    size: 30,
                  )
                      : widget.fieldModel.status!
                      ? Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                      : Icon(
                    Icons.remove,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 18,
            child: Row(
              children: [
                Expanded(
                    flex: widget.isSurgical ? 7 : 3,
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              FormTextKeyWidget(
                                text: widget.title,
                              ),
                              FormTextValueWidget(
                                text: ": ${widget.fieldModel.value ?? ""}",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        widget.assignButton
                            ? Expanded(
                          child: Row(
                            children: [
                              FormTextKeyWidget(
                                text: "Assigned to: ",
                              ),
                              FormTextValueWidget(
                                text: widget.fieldModel.assignedTo != null ? widget.fieldModel.assignedTo!.name ?? "" : "",
                              ),
                            ],
                          ),
                        )
                            : Container(),
                      ],
                    )),
                SizedBox(width: 10),
                widget.isSurgical
                    ? Expanded(
                    flex: 9,
                    child: ElevatedButton(
                      onPressed: () {
                        /*                          List<DropDownDTO> companies = [];
                            int? companyID;
                            List<DropDownDTO> lines = [];
                            int? lineID;
                            List<DropDownDTO> implants = [];
*/
                        CIA_ShowPopUp(
                            context: context,
                            title: "${widget.title} Data",
                            onSave: () => setState(() {}),
                            width: 900,
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    /*Row(
                                          children: [
                                            Expanded(
                                              child: CIA_DropDownSearchBasicIdName(
                                                label: "Implant Company",
                                                selectedItem: companies.firstWhereOrNull((element) => element.id == companyID),

                                                asyncItems: () async {
                                                  var res = await LoadinAPI.LoadImplantCompanies();
                                                  if (res.statusCode == 200) companies = res.result as List<DropDownDTO>;
                                                  return res;
                                                },
                                                onSelect: (value) {
                                                  companyID = value!.id!;

                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                label: "Implant Lines",
                                                selectedItem: lines.firstWhereOrNull((element) => element.id == lineID),
                                                asyncItems: companyID == null
                                                    ? null
                                                    : () async {
                                                        var res = await LoadinAPI.LoadImplantLines(companyID!);
                                                        if (res.statusCode == 200) lines = res.result as List<DropDownDTO>;
                                                        return res;
                                                      },
                                                onSelect: (value) {
                                                  lineID = value!.id!;

                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                selectedItem: widget.fieldModel.implant,
                                                label: "Size",
                                                asyncItems: lineID == null
                                                    ? null
                                                    : () async {
                                                        var res = await LoadinAPI.LoadImplants(lineID!);
                                                        if (res.statusCode == 200) implants = res.result as List<DropDownDTO>;
                                                        return res;
                                                      },
                                                onSelect: (value) {
                                                  widget.fieldModel.implant!.name = value.name;
                                                  widget.fieldModel.implantID = value.id;
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        CIA_DropDownSearch(
                                          selectedItem: widget.fieldModel.doneBySupervisor,
                                          label: "Supervisor",
                                          asyncItems: LoadinAPI.LoadSupervisors,
                                          onSelect: (value) {
                                            widget.fieldModel.doneBySupervisor = value;
                                            widget.fieldModel.doneBySupervisorID = value.id;
                                          },
                                        ),
                                        CIA_DropDownSearch(
                                          selectedItem: widget.fieldModel.doneByCandidateBatch,
                                          label: "Candidate Batch",
                                          asyncItems: LoadinAPI.LoadCandidatesBatches,
                                          onSelect: (value) {
                                            widget.fieldModel.doneByCandidateBatch = value;
                                            widget.fieldModel.doneByCandidateBatchID = value.id;
                                            setState(() {});
                                          },
                                        ),
                                        CIA_DropDownSearch(
                                          selectedItem: widget.fieldModel.doneByCandidate,
                                          label: "Candidate",
                                          asyncItems: widget.fieldModel.doneByCandidateBatchID == null
                                              ? null
                                              : () async {
                                                  return await LoadinAPI.LoadCandidatesByBatchID(widget.fieldModel.doneByCandidateBatchID!);
                                                },
                                          onSelect: (value) {
                                            widget.fieldModel.doneByCandidate = value;
                                            widget.fieldModel.doneByCandidateID = value.id;
                                          },
                                        ),*/
                                  ],
                                );
                              },
                            ));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color_Background),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    FormTextKeyWidget(
                                      text: "Candidate",
                                      smallFont: true,
                                    ),
                                    SizedBox(width: 5),
                                    FormTextValueWidget(
                                      text: widget.fieldModel.doneByCandidate!.name,
                                      smallFont: true,
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    FormTextKeyWidget(
                                      text: "Batch",
                                      smallFont: true,
                                    ),
                                    SizedBox(width: 5),
                                    FormTextValueWidget(
                                      text: widget.fieldModel.doneByCandidateBatch!.name,
                                      smallFont: true,
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    FormTextKeyWidget(
                                      text: "Assistant",
                                      smallFont: true,
                                    ),
                                    SizedBox(width: 5),
                                    FormTextValueWidget(
                                      text: widget.fieldModel.doneByAssistant!.name,
                                      smallFont: true,
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    FormTextKeyWidget(
                                      text: "Supervisor",
                                      smallFont: true,
                                    ),
                                    SizedBox(width: 5),
                                    FormTextValueWidget(
                                      text: widget.fieldModel.doneBySupervisor!.name,
                                      smallFont: true,
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    FormTextKeyWidget(
                                      text: "Implant",
                                      smallFont: true,
                                    ),
                                    SizedBox(width: 5),
                                    FormTextValueWidget(
                                      text: widget.fieldModel.implant == null ? "" : widget.fieldModel.implant!.name,
                                      smallFont: true,
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
                    : widget.assignButton && !widget.viewOnlyMode
                    ? Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                            label: "Assign to assistant",
                            onSelect: (value) {
                              widget.fieldModel.assignedTo = value;
                              widget.fieldModel.assignedToID = value.id;
                            },
                            selectedItem: widget.fieldModel.assignedTo,
                            asyncUseCase: sl<LoadUsersUseCase>(),

                          ),
                        ),
                        SizedBox(width: 10)
                      ],
                    ))
                    : SizedBox(width: 10),
                Expanded(
                    child: Row(
                      children: [
                        FormTextKeyWidget(text: "Price: "),
                        FormTextKeyWidget(
                            text: (widget.fieldModel.planPrice != 0 && widget.fieldModel.planPrice != null
                                ? widget.fieldModel.planPrice ?? widget.settingsPrice
                                : widget.settingsPrice)
                                .toString()),
                      ],
                    ))
              ],
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                  child: IconButton(
                    onPressed: () {
                      if (widget.onDelete != null) widget.onDelete!();
                    },
                    icon: Icon(Icons.delete_forever),
                    color: Colors.red,
                  )),
              Expanded(
                child: widget.isSurgical
                    ? RoundCheckBox(
                  isChecked: widget.fieldModel.status,
                  onTap: sl<SharedPreferences>().getString("role") == "secretary"
                      ? null
                      : (selected) {
                    widget.fieldModel.status = selected;
                    if (selected!) {
                      widget.fieldModel.doneByAssistant = BasicNameIdObjectEntity(
                          name: sl<SharedPreferences>().getString("userName"), id: sl<SharedPreferences>().getInt("userid"));
                      widget.fieldModel.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                      widget.fieldModel.date = DateTime.now();
                    } else {
                      widget.fieldModel.doneByAssistant = BasicNameIdObjectEntity();
                      widget.fieldModel.doneByAssistantID = null;
                    }
                    setState(() {});
                  },
                  border: null,
                  borderColor: Colors.transparent,
                  uncheckedWidget: Icon(
                    Icons.remove,
                    color: Colors.red,
                  ),
                  size: 30,
                )
                    : widget.fieldModel.status!
                    ? Icon(
                  Icons.check,
                  color: Colors.green,
                )
                    : Icon(
                  Icons.remove,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 18,
          child: Row(
            children: [
              Expanded(
                flex: widget.isSurgical
                    ? 7
                    : widget.price
                    ? 2
                    : 3,
                child: CIA_TextFormField(
                  onChange: (value) {
                    widget.fieldModel.value = value;
                  },
                  label: widget.title,
                  controller: TextEditingController(
                    text: (widget.fieldModel.value),
                  ),
                ),
              ),
              SizedBox(width: 10),
              widget.price
                  ? Expanded(
                  child: CIA_TextFormField(
                    suffix: "EGP",
                    label: 'Price',
                    isNumber: true,
                    onChange: (v) => widget.fieldModel.planPrice = int.parse(v),
                    controller: TextEditingController(text: () {
                      if (widget.fieldModel.planPrice != null && widget.fieldModel.planPrice != 0)
                        return widget.fieldModel.planPrice.toString();
                      else
                        return widget.settingsPrice.toString();
                    }()),
                  ))
                  : SizedBox(),
              SizedBox(width: 10),
              widget.isSurgical
                  ? Expanded(
                  flex: 9,
                  child: ElevatedButton(
                    onPressed: () {
                      /*  List<DropDownDTO> companies = [];
                          int? companyID;
                          List<DropDownDTO> lines = [];
                          int? lineID;
                          List<DropDownDTO> implants = [];

                          CIA_ShowPopUp(
                              context: context,
                              title: "${widget.title} Data",
                              onSave: () => setState(() {}),
                              width: 900,
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CIA_DropDownSearch(
                                              label: "Implant Company",
                                              selectedItem: companies.firstWhereOrNull((element) => element.id == companyID),
                                              asyncItems: () async {
                                                var res = await LoadinAPI.LoadImplantCompanies();
                                                if (res.statusCode == 200) companies = res.result as List<DropDownDTO>;
                                                return res;
                                              },
                                              onSelect: (value) {
                                                companyID = value!.id!;

                                                setState(() {});
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: CIA_DropDownSearch(
                                              label: "Implant Lines",
                                              selectedItem: lines.firstWhereOrNull((element) => element.id == lineID),
                                              asyncItems: companyID == null
                                                  ? null
                                                  : () async {
                                                      var res = await LoadinAPI.LoadImplantLines(companyID!);
                                                      if (res.statusCode == 200) lines = res.result as List<DropDownDTO>;
                                                      return res;
                                                    },
                                              onSelect: (value) {
                                                lineID = value!.id!;

                                                setState(() {});
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: CIA_DropDownSearch(
                                              selectedItem: widget.fieldModel.implant,
                                              label: "Size",
                                              asyncItems: lineID == null
                                                  ? null
                                                  : () async {
                                                      var res = await LoadinAPI.LoadImplants(lineID!);
                                                      if (res.statusCode == 200) implants = res.result as List<DropDownDTO>;
                                                      return res;
                                                    },
                                              onSelect: (value) async {
                                                widget.fieldModel.implant!.name = value.name;
                                                widget.fieldModel.implantID = value.id;
                                                await CIA_ShowPopUpYesNo(
                                                    context: context,
                                                    title: "Consume Implant ${widget.fieldModel.implant!.name}?",
                                                    onSave: () async {
                                                      var res = await MedicalAPI.ConsumeImplant(widget.fieldModel.implantID!);
                                                      ShowSnackBar(context, isSuccess: res.statusCode == 200, message: res.errorMessage ?? "");
                                                    });
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      CIA_DropDownSearch(
                                        selectedItem: widget.fieldModel.doneBySupervisor,
                                        label: "Supervisor",
                                        asyncItems: LoadinAPI.LoadSupervisors,
                                        onSelect: (value) {
                                          widget.fieldModel.doneBySupervisor = value;
                                          widget.fieldModel.doneBySupervisorID = value.id;
                                        },
                                      ),
                                      CIA_DropDownSearch(
                                        selectedItem: widget.fieldModel.doneByCandidateBatch,
                                        label: "Candidate Batch",
                                        asyncItems: LoadinAPI.LoadCandidatesBatches,
                                        onSelect: (value) {
                                          widget.fieldModel.doneByCandidateBatch = value;
                                          widget.fieldModel.doneByCandidateBatchID = value.id;
                                          setState(() {});
                                        },
                                      ),
                                      CIA_DropDownSearch(
                                        selectedItem: widget.fieldModel.doneByCandidate,
                                        label: "Candidate",
                                        asyncItems: widget.fieldModel.doneByCandidateBatchID == null
                                            ? null
                                            : () async {
                                                return await LoadinAPI.LoadCandidatesByBatchID(widget.fieldModel.doneByCandidateBatchID!);
                                              },
                                        onSelect: (value) {
                                          widget.fieldModel.doneByCandidate = value;
                                          widget.fieldModel.doneByCandidateID = value.id;
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ));*/
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color_Background),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  FormTextKeyWidget(
                                    text: "Candidate",
                                    smallFont: true,
                                  ),
                                  SizedBox(width: 5),
                                  FormTextValueWidget(
                                    text: widget.fieldModel.doneByCandidate!.name,
                                    smallFont: true,
                                  ),
                                  SizedBox(width: 5),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  FormTextKeyWidget(
                                    text: "Batch",
                                    smallFont: true,
                                  ),
                                  SizedBox(width: 5),
                                  FormTextValueWidget(
                                    text: widget.fieldModel.doneByCandidateBatch!.name,
                                    smallFont: true,
                                  ),
                                  SizedBox(width: 5),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  FormTextKeyWidget(
                                    text: "Assistant",
                                    smallFont: true,
                                  ),
                                  SizedBox(width: 5),
                                  FormTextValueWidget(
                                    text: widget.fieldModel.doneByAssistant!.name,
                                    smallFont: true,
                                  ),
                                  SizedBox(width: 5),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  FormTextKeyWidget(
                                    text: "Supervisor",
                                    smallFont: true,
                                  ),
                                  SizedBox(width: 5),
                                  FormTextValueWidget(
                                    text: widget.fieldModel.doneBySupervisor!.name,
                                    smallFont: true,
                                  ),
                                  SizedBox(width: 5),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  FormTextKeyWidget(
                                    text: "Implant",
                                    smallFont: true,
                                  ),
                                  SizedBox(width: 5),
                                  FormTextValueWidget(
                                    text: widget.fieldModel.implant == null ? "" : widget.fieldModel.implant!.name,
                                    smallFont: true,
                                  ),
                                  SizedBox(width: 5),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
                  : widget.assignButton
                  ? Expanded(
                  child: Row(
                    children: [

                      Expanded(
                        child: CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                          asyncUseCase: sl<LoadUsersUseCase>(),
                          searchType: LoadUsersEnum.assistants,
                          label: "Assign to assistant",
                          onSelect: (value) {
                            widget.fieldModel.assignedTo = value;
                            widget.fieldModel.assignedToID = value.id;
                          },
                          selectedItem: widget.fieldModel.assignedTo,

                        ),
                      ),
                      SizedBox(width: 10)
                    ],
                  ))
                  : SizedBox(),
              //SizedBox(width: 10)
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    if (widget.price && widget.fieldModel.planPrice == null || widget.fieldModel.planPrice == 0)
      widget.fieldModel.planPrice = widget.settingsPrice;
  }
}
