import 'package:cariro_implant_academy/Widgets/CIA_CheckBoxWidget.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadCandidateBatchesUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadCandidateByBatchIdUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getImplantCompaniesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getImplantLinesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getImplantSizesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc_Events.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc_States.dart';
import 'package:cariro_implant_academy/core/injection_contianer.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedPatientSearchEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedTreatmentSearchEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterSurgeryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import 'advancedSearchFilterChildWidgert.dart';

class AdvancedSearchTreatmentFilterWidget extends StatefulWidget {
  AdvancedSearchTreatmentFilterWidget({
    Key? key,
    required this.searchTreatmentsDTO,
    required this.treatmentItems,
  }) : super(key: key);

  AdvancedTreatmentSearchEntity searchTreatmentsDTO;
  List<TreatmentItemEntity> treatmentItems;

  @override
  State<AdvancedSearchTreatmentFilterWidget> createState() => _AdvancedSearchTreatmentFilterWidgetState();
}

class _AdvancedSearchTreatmentFilterWidgetState extends State<AdvancedSearchTreatmentFilterWidget> {
  List<BasicNameIdObjectEntity> complicationsItems = [];

  late SettingsBloc settingsBloc;

  @override
  void initState() {
    settingsBloc = BlocProvider.of<SettingsBloc>(context);
    settingsBloc.add(SettingsBloc_LoadDefaultSurgicalComplicationsEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocListener<SettingsBloc, SettingsBloc_States>(
        bloc: settingsBloc,
        listener: (context, state) {
          if (state is SettingsBloc_LoadedDefaultSurgicalComplicationsSuccessfullyState) {
            complicationsItems = state.data;
            setState(() {});
          }
        },
        child: ExpansionTile(
          title: Text("Treatment Filter"),
          children: [
            AdvancedSearchFilterChildWidget(
              title: "Candidate",
              child: Column(
                children: [
                  CIA_DropDownSearchBasicIdName(
                    label: "Candidate Batch",
                    asyncUseCase: sl<LoadCandidateBatchesUseCase>(),
                    selectedItem: widget.searchTreatmentsDTO.candidateBatch,
                    onSelect: (value) {
                      widget.searchTreatmentsDTO.candidateBatch = value;
                      setState(() {});
                    },
                  ),
                  CIA_DropDownSearchBasicIdName(
                    label: "Candidate",
                    asyncUseCase: widget.searchTreatmentsDTO.candidateBatch?.id == null ? null : sl<LoadCandidatesByBatchId>(),
                    searchParams: widget.searchTreatmentsDTO.candidateBatch?.id ?? 0,
                    selectedItem: widget.searchTreatmentsDTO.candidate,
                    onSelect: (value) {
                      widget.searchTreatmentsDTO.candidate = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            AdvancedSearchFilterChildWidget(
              title: "No Treatment Plans Assigned",
              child: Row(
                children: [
                  CIA_CheckBoxWidget(
                      text: "Yes",
                      onChange: (value) {
                        if (value == true) {
                          widget.searchTreatmentsDTO.and_treatmentIds!.clear();
                          widget.searchTreatmentsDTO.or_treatmentIds!.clear();
                          widget.searchTreatmentsDTO.done = null;
                        } else {
                          widget.searchTreatmentsDTO.done = false;
                        }
                        setState(() => widget.searchTreatmentsDTO.noTreatmentPlan = value == true ? true : null);
                      },
                      value: widget.searchTreatmentsDTO.noTreatmentPlan == true),
                ],
              ),
            ),
            Visibility(
              visible: widget.searchTreatmentsDTO.noTreatmentPlan != true,
              child: AdvancedSearchFilterChildWidget(
                title: "Plan Or Surgery",
                child: Row(
                  children: [
                    CIA_CheckBoxWidget(
                        text: "Plan",
                        onChange: (value) => setState(() => widget.searchTreatmentsDTO.done = false),
                        value: widget.searchTreatmentsDTO.done == false),
                    SizedBox(width: 10),
                    CIA_CheckBoxWidget(
                        text: "Surgery",
                        onChange: (value) => setState(() => widget.searchTreatmentsDTO.done = true),
                        value: widget.searchTreatmentsDTO.done == true)
                  ],
                ),
              ),
            ),
            AdvancedSearchFilterChildWidget(
              title: "Implant Failed",
              child: Row(
                children: [
                  CIA_CheckBoxWidget(
                      text: "All",
                      onChange: (value) => setState(() => widget.searchTreatmentsDTO.implantFailed = null),
                      value: widget.searchTreatmentsDTO.implantFailed == null),
                  SizedBox(width: 10),
                  CIA_CheckBoxWidget(
                      text: "Yes",
                      onChange: (value) => setState(() => widget.searchTreatmentsDTO.implantFailed = true),
                      value: widget.searchTreatmentsDTO.implantFailed == true),
                  SizedBox(width: 10),
                  CIA_CheckBoxWidget(
                      text: "No",
                      onChange: (value) => setState(() => widget.searchTreatmentsDTO.implantFailed = false),
                      value: widget.searchTreatmentsDTO.implantFailed == false)
                ],
              ),
            ),
            AdvancedSearchFilterChildWidget(
              title: "Used Implant",
              child: Column(
                children: [
                  CIA_DropDownSearchBasicIdName(
                    label: "Company",
                    asyncUseCase: sl<GetImplantCompaniesUseCase>(),
                    selectedItem: widget.searchTreatmentsDTO.implantCompanyId,
                    onSelect: (value) {
                      widget.searchTreatmentsDTO.implantCompanyId = value;
                      widget.searchTreatmentsDTO.implantLineId = null;
                      widget.searchTreatmentsDTO.implantId = null;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 10),
                  CIA_DropDownSearchBasicIdName(
                    label: "Line",
                    emptyString: widget.searchTreatmentsDTO.implantCompanyId == null ? "Please select company first" : "",
                    asyncUseCase: widget.searchTreatmentsDTO.implantCompanyId == null ? null : sl<GetImplantLinesUseCase>(),
                    selectedItem: widget.searchTreatmentsDTO.implantLineId,
                    searchParams: widget.searchTreatmentsDTO.implantCompanyId?.id,
                    onSelect: (value) {
                      widget.searchTreatmentsDTO.implantLineId = value;
                      widget.searchTreatmentsDTO.implantId = null;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 10),
                  CIA_DropDownSearchBasicIdName(
                    label: "Implant",
                    emptyString: widget.searchTreatmentsDTO.implantLineId == null ? "Please select line first" : "",
                    asyncUseCase: widget.searchTreatmentsDTO.implantLineId == null ? null : sl<GetImplantSizesUseCase>(),
                    selectedItem: widget.searchTreatmentsDTO.implantId,
                    searchParams: widget.searchTreatmentsDTO.implantLineId?.id,
                    onSelect: (value) {
                      widget.searchTreatmentsDTO.implantId = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Visibility(
              visible: widget.searchTreatmentsDTO.noTreatmentPlan != true,
              child: AdvancedSearchFilterChildWidget(
                title: "Teeth",
                child: CIA_DropDownSearchBasicIdName(
                  items: [
                    BasicNameIdObjectEntity(
                      name: "All",
                    ),
                    BasicNameIdObjectEntity(name: "Upper Anterior", id: 0),
                    BasicNameIdObjectEntity(name: "Lower Anterior", id: 1),
                    BasicNameIdObjectEntity(name: "Upper Posterior", id: 2),
                    BasicNameIdObjectEntity(name: "Lower Posterior", id: 3),
                  ],
                  selectedItem: BasicNameIdObjectEntity(
                      name: widget.searchTreatmentsDTO.teethClassification?.name ?? "All", id: widget.searchTreatmentsDTO.teethClassification?.index),
                  onSelect: (value) {
                    widget.searchTreatmentsDTO.teethClassification =
                        EnumTeethClassification.values.firstWhereOrNull((element) => element.index == value.id);
                  },
                ),
              ),
            ),
            Visibility(
              visible: widget.searchTreatmentsDTO.noTreatmentPlan != true,
              child: AdvancedSearchFilterChildWidget(
                  title: "Post Surgery Complications (One of the following)",
                  child: Column(
                    children: [
                      CIA_CheckBoxWidget(
                        text: "All",
                        value: widget.searchTreatmentsDTO.complicationsAfterSurgeryIdsOr == null,
                        onChange: (value) {
                          setState(() {
                            widget.searchTreatmentsDTO.complicationsAfterSurgeryIdsOr = null;
                          });
                        },
                      ),
                      ...(complicationsItems
                          .map(
                            (e) => CIA_CheckBoxWidget(
                              text: e.name ?? "",
                              value: widget.searchTreatmentsDTO.complicationsAfterSurgeryIdsOr?.contains(e.id!) ?? false,
                              onChange: (value) {
                                if (value == true) {
                                  widget.searchTreatmentsDTO.complicationsAfterSurgeryIdsOr ??= [];
                                  widget.searchTreatmentsDTO.complicationsAfterSurgeryIdsOr?.add(e.id!);
                                  widget.searchTreatmentsDTO.complicationsAfterSurgeryIds?.remove(e.id!);
                                } else {
                                  widget.searchTreatmentsDTO.complicationsAfterSurgeryIdsOr?.remove(e.id!);
                                }

                                widget.searchTreatmentsDTO.complicationsAfterSurgeryIdsOr =
                                    widget.searchTreatmentsDTO.complicationsAfterSurgeryIdsOr?.toSet().toList();
                                widget.searchTreatmentsDTO.complicationsAfterSurgeryIds =
                                    widget.searchTreatmentsDTO.complicationsAfterSurgeryIds?.toSet().toList();

                                setState(() {});
                              },
                            ),
                          )
                          .toList()),
                    ],
                  )),
            ),
            Visibility(
              visible: widget.searchTreatmentsDTO.noTreatmentPlan != true,
              child: AdvancedSearchFilterChildWidget(
                  title: "Post Surgery Complications (All of the following)",
                  child: Column(
                    children: [
                      CIA_CheckBoxWidget(
                        text: "All",
                        value: widget.searchTreatmentsDTO.complicationsAfterSurgeryIds == null,
                        onChange: (value) {
                          setState(() {
                            widget.searchTreatmentsDTO.complicationsAfterSurgeryIds = null;
                          });
                        },
                      ),
                      ...(complicationsItems
                          .map(
                            (e) => CIA_CheckBoxWidget(
                              text: e.name ?? "",
                              value: widget.searchTreatmentsDTO.complicationsAfterSurgeryIds?.contains(e.id!) ?? false,
                              onChange: (value) {
                                if (value == true) {
                                  widget.searchTreatmentsDTO.complicationsAfterSurgeryIds ??= [];
                                  widget.searchTreatmentsDTO.complicationsAfterSurgeryIds?.add(e.id!);
                                  widget.searchTreatmentsDTO.complicationsAfterSurgeryIdsOr?.remove(e.id!);
                                } else {
                                  widget.searchTreatmentsDTO.complicationsAfterSurgeryIds?.remove(e.id!);
                                }

                                widget.searchTreatmentsDTO.complicationsAfterSurgeryIdsOr =
                                    widget.searchTreatmentsDTO.complicationsAfterSurgeryIdsOr?.toSet().toList();
                                widget.searchTreatmentsDTO.complicationsAfterSurgeryIds =
                                    widget.searchTreatmentsDTO.complicationsAfterSurgeryIds?.toSet().toList();

                                setState(() {});
                              },
                            ),
                          )
                          .toList()),
                    ],
                  )),
            ),
            CIA_CheckBoxWidget(
              text: "Clearance Upper",
              value: widget.searchTreatmentsDTO.clearnaceUpper == true,
              onChange: (value) {
                widget.searchTreatmentsDTO.clearnaceUpper = value;
              },
            ),
            SizedBox(height: 10),
            CIA_CheckBoxWidget(
              text: "Clearance Lower",
              value: widget.searchTreatmentsDTO.clearnaceLower == true,
              onChange: (value) {
                widget.searchTreatmentsDTO.clearnaceLower = value;
              },
            ),
            Visibility(
              visible: widget.searchTreatmentsDTO.noTreatmentPlan != true,
              child: AdvancedSearchFilterChildWidget(
                  title: "Treatment Type (One of the following)",
                  child: Column(
                    children: [
                      CIA_CheckBoxWidget(
                        text: "All",
                        value: widget.searchTreatmentsDTO.or_treatmentIds == null,
                        onChange: (value) {
                          setState(() {
                            widget.searchTreatmentsDTO.or_treatmentIds = null;
                          });
                        },
                      ),
                      ...widget.treatmentItems
                          .map(
                            (e) => CIA_CheckBoxWidget(
                              text: e.name!,
                              value: widget.searchTreatmentsDTO.or_treatmentIds!.contains(e.id),
                              onChange: (value) {
                                if (value) {
                                  widget.searchTreatmentsDTO.or_treatmentIds!.add(e.id!);
                                  widget.searchTreatmentsDTO.and_treatmentIds!.remove(e.id!);
                                } else
                                  widget.searchTreatmentsDTO.or_treatmentIds!.remove(e.id!);

                                widget.searchTreatmentsDTO.or_treatmentIds = widget.searchTreatmentsDTO.or_treatmentIds!.toSet().toList();
                                widget.searchTreatmentsDTO.and_treatmentIds = widget.searchTreatmentsDTO.and_treatmentIds!.toSet().toList();
                                setState(() => null);
                              },
                            ),
                          )
                          .toList()
                    ],
                  )),
            ),
            Visibility(
              visible: widget.searchTreatmentsDTO.noTreatmentPlan != true,
              child: AdvancedSearchFilterChildWidget(
                  title: "Treatment Type (All of the following)",
                  child: Column(children: [
                    CIA_CheckBoxWidget(
                      text: "All",
                      value: widget.searchTreatmentsDTO.and_treatmentIds == null,
                      onChange: (value) {
                        setState(() {
                          widget.searchTreatmentsDTO.and_treatmentIds = null;
                        });
                      },
                    ),
                    ...widget.treatmentItems
                        .map(
                          (e) => CIA_CheckBoxWidget(
                            text: e.name!,
                            value: widget.searchTreatmentsDTO.and_treatmentIds!.contains(e.id),
                            onChange: (value) {
                              if (value) {
                                widget.searchTreatmentsDTO.and_treatmentIds!.add(e.id!);
                                widget.searchTreatmentsDTO.or_treatmentIds!.remove(e.id!);
                              } else
                                widget.searchTreatmentsDTO.and_treatmentIds!.remove(e.id!);

                              widget.searchTreatmentsDTO.or_treatmentIds = widget.searchTreatmentsDTO.or_treatmentIds!.toSet().toList();
                              widget.searchTreatmentsDTO.and_treatmentIds = widget.searchTreatmentsDTO.and_treatmentIds!.toSet().toList();
                              setState(() => null);
                            },
                          ),
                        )
                        .toList(),
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
