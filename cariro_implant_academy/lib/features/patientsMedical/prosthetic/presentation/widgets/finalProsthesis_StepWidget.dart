import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/injection_contianer.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticStepEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/tryInCheckListEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../Models/DTOs/DropDownDTO.dart';
import '../../../../../Widgets/CIA_DropDown.dart';
import '../../../../../Widgets/CIA_PopUp.dart';
import '../../../../../Widgets/FormTextWidget.dart';
import '../../../../../core/constants/enums/enums.dart';
import '../../../../../core/presentation/widgets/CIA_GestureWidget.dart';

class FinalProsthesis_StepWidget extends StatefulWidget {
  FinalProsthesis_StepWidget({
    Key? key,
    required this.data,
    required this.onDelete,
    required this.index,
    this.fullArch = false,
  }) : super(key: key);
  bool fullArch;
  ProstheticStepEntity data;
  Function() onDelete;
  int index;

  @override
  State<FinalProsthesis_StepWidget> createState() => _FinalProsthesis_StepWidgetState();
}

class _FinalProsthesis_StepWidgetState extends State<FinalProsthesis_StepWidget> {
  late ProstheticBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ProstheticBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              FormTextKeyWidget(text: "${widget.index}. ${widget.data.item?.name}"),
              FormTextValueWidget(
                text: " || Teeth: ",
              ),
              FormTextValueWidget(
                text: widget.fullArch
                    ? ((widget.data.fullArchUpper == true ? "Upper Arch " : " ") + (widget.data.fullArchLower == true ? "Lower Arch " : " "))
                    : widget.data.teeth?.toString(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      child: CIA_DropDownSearchBasicIdName(
                        label: "Procedure",
                        asyncUseCase: sl<xxx>(),
                        selectedItem: () {
                          if (widget.data.status != null) {
                            return BasicNameIdObjectEntity(
                              name: widget.data.status!.name,
                              id: widget.data.statusId,
                            );
                          }
                          return null;
                        }(),
                        onSelect: (value) {
                          widget.data.status = value;
                          widget.data.statusId = value.id;
                          widget.data.operatorId = siteController.getUserId();
                          setState(() {
                            widget.data.operator = BasicNameIdObjectEntity(name: siteController.getUserName());
                            widget.data.date = widget.data.date ?? DateTime.now();
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CIA_DropDownSearchBasicIdName(
                        label: "Next Step",
                        asyncUseCase: sl<xxx>(),
                        selectedItem: () {
                          if (widget.data.nextVisit != null) {
                            return BasicNameIdObjectEntity(
                              name: widget.data.nextVisit!.name,
                              id: widget.data.nextVisitId,
                            );
                          }
                          return null;
                        }(),
                        onSelect: (value) {
                          widget.data.nextVisit = value;
                          widget.data.nextVisitId = value.id;
                          widget.data.operatorId = siteController.getUserId();
                          setState(() {
                            widget.data.operator = BasicNameIdObjectEntity(name: siteController.getUserName());
                            widget.data.date = widget.data.date ?? DateTime.now();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              widget.data.item?.name?.contains("Try In") ?? false
                  ? Expanded(
                      child: CIA_SecondaryButton(
                      label: "Check List",
                      onTab: () {
                        bloc.add(ProstheticBloc_GetTryInCheckList(stepId: widget.data.id!));
                        return CIA_ShowPopUp(
                            context: context,
                            width: 900,
                            height: 600,
                            child: BlocBuilder<ProstheticBloc, ProstheticBloc_States>(
                              buildWhen: (previous, current) =>
                                  current is ProstheticBloc_TryInLoadingErrorState ||
                                  current is ProstheticBloc_TryInLoadingState ||
                                  current is ProstheticBloc_TryInLoadedSuccessfullyState,
                              builder: (context, state) {
                                if (state is ProstheticBloc_TryInLoadingErrorState)
                                  return BigErrorPageWidget(message: state.message);
                                else if (state is ProstheticBloc_TryInLoadingState)
                                  return LoadingWidget();
                                else if (state is ProstheticBloc_TryInLoadedSuccessfullyState) {
                                  TryInCheckListEntity tryInCheckListEntity = state.data;
                                  return Expanded(
                                      child: CIA_SecondaryButton(
                                    label: "Check List",
                                    onTab: () => CIA_ShowPopUp(
                                        context: context,
                                        width: 900,
                                        height: 600,
                                        child: StatefulBuilder(builder: (context, setState) {
                                          return Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: ListView(
                                              children: [
                                                Row(
                                                  children: [
                                                    CIA_MultiSelectChipWidget(
                                                      singleSelect: true,
                                                      labels: [
                                                        CIA_MultiSelectChipWidgeModel(
                                                            label: "Satisfied", isSelected: tryInCheckListEntity.satisfied == true),
                                                        CIA_MultiSelectChipWidgeModel(
                                                            label: "Non Satisfied", isSelected: tryInCheckListEntity.satisfied == false),
                                                      ],
                                                      onChange: (item, isSelected) {
                                                        if (item == "Satisfied") {
                                                          tryInCheckListEntity.satisfied = true;
                                                          tryInCheckListEntity.nonSatisfiedNewScan = null;
                                                          tryInCheckListEntity.nonSatisfiedDescription = null;
                                                        } else if (item == "Non Satisfied") {
                                                          tryInCheckListEntity.satisfied = false;
                                                        }
                                                        setState(() {});
                                                      },
                                                    ),
                                                    SizedBox(width: 10),
                                                    Visibility(
                                                      visible: tryInCheckListEntity.satisfied == false,
                                                      child: Expanded(
                                                        child: Row(
                                                          children: [
                                                            CIA_MultiSelectChipWidget(
                                                              singleSelect: true,
                                                              labels: [
                                                                CIA_MultiSelectChipWidgeModel(
                                                                    label: "New Scan",
                                                                    isSelected: tryInCheckListEntity.nonSatisfiedNewScan == true),
                                                                CIA_MultiSelectChipWidgeModel(
                                                                    label: "Same Scan",
                                                                    isSelected: tryInCheckListEntity.nonSatisfiedNewScan == false),
                                                              ],
                                                              onChange: (item, isSelected) {
                                                                if (item == "New Scan") {
                                                                  tryInCheckListEntity.nonSatisfiedNewScan = true;
                                                                } else if (item == "Same Scan") {
                                                                  tryInCheckListEntity.nonSatisfiedNewScan = false;
                                                                }
                                                                setState(() {});
                                                              },
                                                            ),
                                                            SizedBox(width: 10),
                                                            Expanded(
                                                              child: CIA_TextFormField(
                                                                label: "Non Satisfied Description",
                                                                controller:
                                                                    TextEditingController(text: tryInCheckListEntity.nonSatisfiedDescription),
                                                                onChange: (v) => tryInCheckListEntity.nonSatisfiedDescription = v,
                                                              ),
                                                            ),
                                                            // Add more fields as needed
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    FormTextKeyWidget(text: "Seating"),
                                                    SizedBox(width: 10),
                                                    CIA_MultiSelectChipWidget(
                                                      singleSelect: true,
                                                      labels: [
                                                        CIA_MultiSelectChipWidgeModel(
                                                            label: "Yes", isSelected: tryInCheckListEntity.seating == true),
                                                        CIA_MultiSelectChipWidgeModel(
                                                            label: "No", isSelected: tryInCheckListEntity.seating == false),
                                                      ],
                                                      onChange: (item, isSelected) {
                                                        if (item == "Yes") {
                                                          tryInCheckListEntity.seating = true;
                                                          tryInCheckListEntity.nonSeatingOtherNotes = null;
                                                          tryInCheckListEntity.nonSeatingType = null;
                                                        } else if (item == "No") {
                                                          tryInCheckListEntity.seating = false;
                                                        }
                                                        setState(() {});
                                                      },
                                                    ),
                                                    SizedBox(width: 10),
                                                    Visibility(
                                                      visible: tryInCheckListEntity.seating == false,
                                                      child: Expanded(
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: CIA_DropDownSearch(
                                                                label: "Non Seating Type",
                                                                selectedItem: tryInCheckListEntity.nonSeatingType != null
                                                                    ? DropDownDTO(
                                                                        name: tryInCheckListEntity.nonSeatingType!.name.replaceAll("_", " "))
                                                                    : null,
                                                                onSelect: (value) {
                                                                  tryInCheckListEntity.nonSeatingType = EnumTryInSeating.values[value.id!];
                                                                },
                                                                items: EnumTryInSeating.values
                                                                    .map(
                                                                      (value) => DropDownDTO(
                                                                        name: value.name.replaceAll("_", " "),
                                                                        id: EnumTryInSeating.values.indexOf(value),
                                                                      ),
                                                                    )
                                                                    .toList(),
                                                              ),
                                                            ),
                                                            SizedBox(width: 10),
                                                            Expanded(
                                                              child: CIA_TextFormField(
                                                                label: "Non Seating Other Notes",
                                                                controller: TextEditingController(text: tryInCheckListEntity.nonSeatingOtherNotes),
                                                                onChange: (v) => tryInCheckListEntity.nonSeatingOtherNotes = v,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                            
                                                SizedBox(height: 10),
                                                CIA_DropDownSearch(
                                                  label: "Mesial Contact",
                                                  selectedItem: tryInCheckListEntity.mesialContacts != null
                                                      ? DropDownDTO(name: tryInCheckListEntity.mesialContacts!.name.replaceAll("_", " "))
                                                      : null,
                                                  onSelect: (value) {
                                                    tryInCheckListEntity.mesialContacts = EnumTryInContacts.values[value.id!];
                                                  },
                                                  items: EnumTryInContacts.values
                                                      .map(
                                                        (value) => DropDownDTO(
                                                          name: value.name.replaceAll("_", " "),
                                                          id: EnumTryInContacts.values.indexOf(value),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                                SizedBox(height: 10),
                                                CIA_DropDownSearch(
                                                  label: "Distal Contact",
                                                  selectedItem: tryInCheckListEntity.distalContacts != null
                                                      ? DropDownDTO(name: tryInCheckListEntity.distalContacts!.name.replaceAll("_", " "))
                                                      : null,
                                                  onSelect: (value) {
                                                    tryInCheckListEntity.distalContacts = EnumTryInContacts.values[value.id!];
                                                  },
                                                  items: EnumTryInContacts.values
                                                      .map(
                                                        (value) => DropDownDTO(
                                                          name: value.name.replaceAll("_", " "),
                                                          id: EnumTryInContacts.values.indexOf(value),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                                SizedBox(height: 10),
                                                CIA_DropDownSearch(
                                                  label: "Occlusion",
                                                  selectedItem: tryInCheckListEntity.occlusion != null
                                                      ? DropDownDTO(name: tryInCheckListEntity.occlusion!.name.replaceAll("_", " "))
                                                      : null,
                                                  onSelect: (value) {
                                                    tryInCheckListEntity.occlusion = EnumOcclusion.values[value.id!];
                                                  },
                                                  items: EnumOcclusion.values
                                                      .map(
                                                        (value) => DropDownDTO(
                                                          name: value.name.replaceAll("_", " "),
                                                          id: EnumOcclusion.values.indexOf(value),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                                SizedBox(height: 10),
                                                CIA_DropDownSearch(
                                                  label: "Buccal Contour",
                                                  selectedItem: tryInCheckListEntity.buccalContour != null
                                                      ? DropDownDTO(name: tryInCheckListEntity.buccalContour!.name.replaceAll("_", " "))
                                                      : null,
                                                  onSelect: (value) {
                                                    tryInCheckListEntity.buccalContour = EnumBuccalContour.values[value.id!];
                                                  },
                                                  items: EnumBuccalContour.values
                                                      .map(
                                                        (value) => DropDownDTO(
                                                          name: value.name.replaceAll("_", " "),
                                                          id: EnumBuccalContour.values.indexOf(value),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: FormTextKeyWidget(
                                                        text: "Passive",
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: CIA_MultiSelectChipWidget(
                                                        singleSelect: true,
                                                        labels: [
                                                          CIA_MultiSelectChipWidgeModel(
                                                              label: "Yes", isSelected: tryInCheckListEntity.passive == true),
                                                          CIA_MultiSelectChipWidgeModel(
                                                              label: "No", isSelected: tryInCheckListEntity.passive == false),
                                                        ],
                                                        onChange: (item, isSelected) {
                                                          tryInCheckListEntity.passive = item == "Yes";
                                                          setState(() {});
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                            
                                                // Other dropdowns and text fields...
                                                SizedBox(height: 10),
                                                CIA_TextFormField(
                                                  label: "Retention",
                                                  controller: TextEditingController(text: tryInCheckListEntity.retention),
                                                  onChange: (v) => tryInCheckListEntity.retention = v,
                                                ),
                                                SizedBox(height: 10),
                                                CIA_TextFormField(
                                                  label: "Occlusion Notes",
                                                  controller: TextEditingController(text: tryInCheckListEntity.occlusionNotes),
                                                  onChange: (v) => tryInCheckListEntity.occlusionNotes = v,
                                                ),
                                                SizedBox(height: 10),
                                                CIA_TextFormField(
                                                  label: "Occlusal Plan and Midline",
                                                  controller: TextEditingController(text: tryInCheckListEntity.occlusalPlanAndMidline),
                                                  onChange: (v) => tryInCheckListEntity.occlusalPlanAndMidline = v,
                                                ),
                                                SizedBox(height: 10),
                                                CIA_TextFormField(
                                                  label: "Centric Relation",
                                                  controller: TextEditingController(text: tryInCheckListEntity.centricRelation),
                                                  onChange: (v) => tryInCheckListEntity.centricRelation = v,
                                                ),
                                                SizedBox(height: 10),
                                                CIA_TextFormField(
                                                  label: "Vertical Dimension",
                                                  controller: TextEditingController(text: tryInCheckListEntity.verticalDimension),
                                                  onChange: (v) => tryInCheckListEntity.verticalDimension = v,
                                                ),
                            
                                                SizedBox(height: 10),
                                                CIA_TextFormField(
                                                  label: "Lip Support",
                                                  controller: TextEditingController(text: tryInCheckListEntity.lipSupport),
                                                  onChange: (v) => tryInCheckListEntity.lipSupport = v,
                                                ),
                            
                                                SizedBox(height: 10),
                                                CIA_TextFormField(
                                                  label: "Size and Shape of Teeth",
                                                  controller: TextEditingController(text: tryInCheckListEntity.sizeAndShapeOfTeeth),
                                                  onChange: (v) => tryInCheckListEntity.sizeAndShapeOfTeeth = v,
                                                ),
                            
                                                SizedBox(height: 10),
                                                CIA_TextFormField(
                                                  label: "Canting",
                                                  controller: TextEditingController(text: tryInCheckListEntity.canting),
                                                  onChange: (v) => tryInCheckListEntity.canting = v,
                                                ),
                            
                                                SizedBox(height: 10),
                                                CIA_TextFormField(
                                                  label: "Frontal Smiling and Lateral Photos",
                                                  controller: TextEditingController(text: tryInCheckListEntity.frontalSmilingAndLateralPhotos),
                                                  onChange: (v) => tryInCheckListEntity.frontalSmilingAndLateralPhotos = v,
                                                ),
                            
                                                SizedBox(height: 10),
                                                CIA_TextFormField(
                                                  label: "Evaluation",
                                                  controller: TextEditingController(text: tryInCheckListEntity.evaluation),
                                                  onChange: (v) => tryInCheckListEntity.evaluation = v,
                                                ),
                            
                                                SizedBox(height: 10),
                                                CIA_TextFormField(
                                                  label: "Explain Why",
                                                  controller: TextEditingController(text: tryInCheckListEntity.explainWhy),
                                                  onChange: (v) => tryInCheckListEntity.explainWhy = v,
                                                ),
                                                // Add the remaining fields as needed...
                                              ],
                                            ),
                                          );
                                        })),
                                  ));
                                }
                                return Container();
                              },
                            ));
                      },
                    ))
                  : Container(),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    FormTextKeyWidget(text: "Date"),
                    SizedBox(width: 10),
                    Expanded(
                        child: CIA_GestureWidget(
                      onTap: () {
                        CIA_PopupDialog_DateOnlyPicker(context, "Change Date and Time", initialDate: widget.data.date, (v) {
                          setState(() {
                            widget.data.date = v;
                          });
                        });
                      },
                      child: FormTextValueWidget(
                        text: widget.data.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(widget.data.date!),
                      ),
                    )),
                    SizedBox(width: 10),
                    Expanded(
                        child: CIA_GestureWidget(
                      onTap: () => CIA_ShowPopUp(
                        context: context,
                        height: 100,
                        onSave: () => setState(() => null),
                        child: CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                          asyncUseCase: sl<LoadUsersUseCase>(),
                          searchParams: LoadUsersEnum.instructorsAndAssistants,
                          onSelect: (value) {
                            widget.data.operatorId = value.id;
                            widget.data.operator = value;
                          },
                          //selectedItem: DropDownDTO(),
                          selectedItem: widget.data.operator ?? BasicNameIdObjectEntity(name: "", id: 0),
                          label: "Operator",
                        ),
                      ),
                      child: FormTextValueWidget(
                        text: widget.data.operator?.name,
                      ),
                    )),
                    SizedBox(width: 10),
                    IconButton(onPressed: () => widget.onDelete(), icon: Icon(Icons.delete)),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
