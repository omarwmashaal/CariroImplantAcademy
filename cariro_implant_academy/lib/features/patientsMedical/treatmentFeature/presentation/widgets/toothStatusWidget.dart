import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadCandidateBatchesUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadCandidateByBatchIdUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getImplantSizesUseCase.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc_States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../Constants/Colors.dart';
import '../../../../../../Widgets/CIA_DropDown.dart';
import '../../../../../../Widgets/CIA_PopUp.dart';
import '../../../../../../Widgets/CIA_TextFormField.dart';
import '../../../../../../Widgets/FormTextWidget.dart';
import '../../../../../../core/injection_contianer.dart';
import '../../../../../Widgets/SnackBar.dart';
import '../../../../../core/features/settings/domain/useCases/getImplantCompaniesUseCase.dart';
import '../../../../../core/features/settings/domain/useCases/getImplantLinesUseCase.dart';
import '../../domain/entities/trearmentPlanPropertyEntity.dart';

class ToothStatusWidget extends StatefulWidget {
  ToothStatusWidget(
      {Key? key,
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
  late TreatmentBloc bloc;

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
                                    widget.fieldModel.date = DateTime.now().toUtc();
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
                                  widget.fieldModel.date = DateTime.now().toUtc();
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
                          List<BasicNameIdObjectEntity> companies = [];
                          int? companyID;
                          List<BasicNameIdObjectEntity> lines = [];
                          int? lineID;
                          List<BasicNameIdObjectEntity> implants = [];

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
                                            child: CIA_DropDownSearchBasicIdName<NoParams>(
                                              label: "Implant Company",
                                              asyncUseCase: sl<GetImplantCompaniesUseCase>(),
                                              searchParams: NoParams(),
                                              selectedItem: companies.firstWhereOrNull((element) => element.id == companyID),
                                              onSelect: (value) {
                                                companyID = value!.id!;

                                                setState(() {});
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: CIA_DropDownSearchBasicIdName<int>(
                                              label: "Implant Lines",
                                              asyncUseCase: companyID == null ? null : sl<GetImplantLinesUseCase>(),
                                              emptyString: "Select implant company first",
                                              searchParams: companyID,
                                              selectedItem: lines.firstWhereOrNull((element) => element.id == lineID),
                                              onSelect: (value) {
                                                lineID = value!.id!;

                                                setState(() {});
                                              },
                                            ),
                                          ),
                                          Expanded(
                                              child: BlocConsumer<TreatmentBloc, TreatmentBloc_States>(
                                            listener: (context, state) {
                                              if (state is TreatmentBloc_ConsumedItemSuccessfullyState)
                                                ShowSnackBar(context, isSuccess: true, message: "Implant Consumed Successfully");
                                              else if (state is TreatmentBloc_ConsumeItemErrorState)
                                                ShowSnackBar(context, isSuccess: false, message: state.message);
                                            },
                                            builder: (context, state) {
                                              return CIA_DropDownSearchBasicIdName<int>(
                                                label: "Implant Size",
                                                asyncUseCase: lineID == null ? null : sl<GetImplantSizesUseCase>(),
                                                emptyString: "Select implant line first",
                                                searchParams: companyID,
                                                selectedItem: widget.fieldModel.implant,
                                                onSelect: (value) async {
                                                  widget.fieldModel.implant!.name = value.name;
                                                  widget.fieldModel.implantID = value.id;
                                                  await CIA_ShowPopUpYesNo(
                                                      context: context,
                                                      title: "Consume Implant ${widget.fieldModel.implant!.name}?",
                                                      onSave: () => bloc.add(TreatmentBloc_ConsumeImplantEvent(id: widget.fieldModel.implantID!)));
                                                  setState(() {});
                                                },
                                              );
                                            },
                                          )),
                                        ],
                                      ),
                                      CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                                        label: "Supervisor",
                                        asyncUseCase: sl<LoadUsersUseCase>(),
                                        searchParams: LoadUsersEnum.supervisors,
                                        selectedItem: widget.fieldModel.doneBySupervisor,
                                        onSelect: (value) {
                                          widget.fieldModel.doneBySupervisor = value;
                                          widget.fieldModel.doneBySupervisorID = value.id;
                                        },
                                      ),
                                      CIA_DropDownSearchBasicIdName(
                                        label: "Candidate Batch",
                                        asyncUseCase: sl<LoadCandidateBatchesUseCase>(),
                                        selectedItem: widget.fieldModel.doneByCandidateBatch,
                                        onSelect: (value) {
                                          widget.fieldModel.doneByCandidateBatch = value;
                                          widget.fieldModel.doneByCandidateBatchID = value.id;
                                          setState(() {});
                                        },
                                      ),
                                      CIA_DropDownSearchBasicIdName<int>(
                                        label: "Candidate",
                                        asyncUseCase: widget.fieldModel.doneByCandidateBatchID ==null ?null:sl<LoadCandidatesByBatchId>(),
                                        searchParams: widget.fieldModel.doneByCandidateBatchID??0,
                                        selectedItem: widget.fieldModel.doneByCandidate,
                                        onSelect: (value) {
                                          widget.fieldModel.doneByCandidate = value;
                                          widget.fieldModel.doneByCandidateID = value.id;
                                        },
                                      ),
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
                  : widget.assignButton
                      ? Expanded(
                          child: Row(
                          children: [
                            Expanded(
                              child: CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                                asyncUseCase: sl<LoadUsersUseCase>(),
                                searchParams: LoadUsersEnum.assistants,
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
    bloc = BlocProvider.of<TreatmentBloc>(context);
    if (widget.price && widget.fieldModel.planPrice == null || widget.fieldModel.planPrice == 0) widget.fieldModel.planPrice = widget.settingsPrice;
  }
}
