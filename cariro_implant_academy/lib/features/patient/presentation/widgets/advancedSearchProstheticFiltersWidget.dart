import 'package:cariro_implant_academy/Widgets/CIA_CheckBoxWidget.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getProstheticNextVisitUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getProstheticStatusUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc_Events.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc_States.dart';
import 'package:cariro_implant_academy/core/helpers/spaceToString.dart';
import 'package:cariro_implant_academy/core/injection_contianer.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedProstheticSearchRequestEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterProsthesisEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/biteModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/diagnosticImpressionModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisDeliveryModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisHeallingCollarModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisImporessionModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisTryInModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/prostheticModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/prostheticTreatmentFinalModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/scanApplianceModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import 'advancedSearchFilterChildWidgert.dart';

class AdvancedSearchProstheticFilterWidget extends StatefulWidget {
  AdvancedSearchProstheticFilterWidget({
    Key? key,
    required this.searchProstheticDTO,
  }) : super(key: key);

  AdvancedProstheticSearchRequestEntity searchProstheticDTO;

  @override
  State<AdvancedSearchProstheticFilterWidget> createState() => _AdvancedSearchProstheticFilterWidgetState();
}

class _AdvancedSearchProstheticFilterWidgetState extends State<AdvancedSearchProstheticFilterWidget> {
  late SettingsBloc settingsBloc;
  List<BasicNameIdObjectEntity> complicationsItems = [];

  List<BasicNameIdObjectEntity> prostheticItems = [];
  @override
  void initState() {
    settingsBloc = BlocProvider.of<SettingsBloc>(context);
    settingsBloc.add(SettingsBloc_GetProstheticItemsEvent(type: widget.searchProstheticDTO.type));
    settingsBloc.add(SettingsBloc_LoadDefaultProstheticComplicationsEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsBloc_States>(
      bloc: settingsBloc,
      listener: (context, state) {
        if (state is SettingsBloc_LoadedDefaultProstheticComplicationsSuccessfullyState) {
          complicationsItems = state.data;
          setState(() {});
        }
      },
      child: SingleChildScrollView(
        child: ExpansionTile(
          title: Text("Prosthetic Filter"),
          children: [
            AdvancedSearchFilterChildWidget(
              title: "Prostheic Type",
              child: BlocBuilder<SettingsBloc, SettingsBloc_States>(
                  buildWhen: (previous, current) =>
                      current is SettingsBloc_LoadingProstheticItemsErrorState ||
                      current is SettingsBloc_LoadingProstheticItemsState ||
                      current is SettingsBloc_LoadedProstheticItemsSuccessfullyState,
                  builder: (context, state) {
                    if (state is SettingsBloc_LoadingProstheticItemsErrorState)
                      return BigErrorPageWidget(message: state.message);
                    else if (state is SettingsBloc_LoadingProstheticItemsState)
                      return LoadingWidget();
                    else if (state is SettingsBloc_LoadedProstheticItemsSuccessfullyState) {
                      prostheticItems = state.data;
                    }
                    return Column(
                      children: [
                        Column(
                          children: [
                            CIA_CheckBoxWidget(
                              text: "Diagnostic",
                              value: widget.searchProstheticDTO.type == EnumProstheticType.Diagnostic,
                              onChange: (value) {
                                if (value == true) {
                                  widget.searchProstheticDTO.type = EnumProstheticType.Diagnostic;
                                  widget.searchProstheticDTO.cementRetained = false;
                                  widget.searchProstheticDTO.screwRetained = false;
                                  widget.searchProstheticDTO.fullArch = null;
                                  widget.searchProstheticDTO.itemId = null;
                                  widget.searchProstheticDTO.statusId = null;
                                  widget.searchProstheticDTO.nextId = null;
                                  settingsBloc.add(SettingsBloc_GetProstheticItemsEvent(type: widget.searchProstheticDTO.type));
                                }
                              },
                            ),
                            CIA_CheckBoxWidget(
                              text: "Sinlge And Bridge",
                              value: widget.searchProstheticDTO.type == EnumProstheticType.Final && widget.searchProstheticDTO.fullArch != true,
                              onChange: (value) {
                                if (value == true) {
                                  widget.searchProstheticDTO.type = EnumProstheticType.Final;
                                  widget.searchProstheticDTO.cementRetained = false;
                                  widget.searchProstheticDTO.screwRetained = false;
                                  widget.searchProstheticDTO.fullArch = null;
                                  widget.searchProstheticDTO.itemId = null;
                                  widget.searchProstheticDTO.statusId = null;
                                  widget.searchProstheticDTO.nextId = null;
                                  settingsBloc.add(SettingsBloc_GetProstheticItemsEvent(type: widget.searchProstheticDTO.type));
                                }
                              },
                            ),
                            CIA_CheckBoxWidget(
                              text: "Full Arch",
                              value: widget.searchProstheticDTO.type == EnumProstheticType.Final && widget.searchProstheticDTO.fullArch == true,
                              onChange: (value) {
                                if (value == true) {
                                  widget.searchProstheticDTO.type = EnumProstheticType.Final;
                                  widget.searchProstheticDTO.cementRetained = false;
                                  widget.searchProstheticDTO.screwRetained = false;
                                  widget.searchProstheticDTO.fullArch = true;
                                  widget.searchProstheticDTO.itemId = null;
                                  widget.searchProstheticDTO.statusId = null;
                                  widget.searchProstheticDTO.nextId = null;
                                  settingsBloc.add(SettingsBloc_GetProstheticItemsEvent(type: widget.searchProstheticDTO.type));
                                }
                              },
                            ),
                            Visibility(
                              visible: widget.searchProstheticDTO.type == EnumProstheticType.Final && widget.searchProstheticDTO.fullArch == true,
                              child: Row(
                                children: [
                                  CIA_CheckBoxWidget(
                                    text: "Screw Retained",
                                    value: widget.searchProstheticDTO.type == EnumProstheticType.Final &&
                                        widget.searchProstheticDTO.fullArch == true &&
                                        widget.searchProstheticDTO.screwRetained == true,
                                    onChange: (value) {
                                      widget.searchProstheticDTO.screwRetained = value;
                                      setState(() {});
                                    },
                                  ),
                                  CIA_CheckBoxWidget(
                                    text: "Cement Retained",
                                    value: widget.searchProstheticDTO.type == EnumProstheticType.Final &&
                                        widget.searchProstheticDTO.fullArch == true &&
                                        widget.searchProstheticDTO.cementRetained == true,
                                    onChange: (value) {
                                      widget.searchProstheticDTO.cementRetained = value;
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "${widget.searchProstheticDTO.type.name} Items",
                            ),
                            ...prostheticItems
                                .map(
                                  (e) => CIA_CheckBoxWidget(
                                    text: AddSpacesToSentence(e.name ?? ""),
                                    value: widget.searchProstheticDTO.itemId == e.id,
                                    onChange: (value) {
                                      widget.searchProstheticDTO.itemId = e.id;
                                      widget.searchProstheticDTO.statusId = null;
                                      widget.searchProstheticDTO.nextId = null;
                                      settingsBloc.emit(SettingsBloc_LoadedProstheticItemsSuccessfullyState(
                                        data: prostheticItems,
                                        type: widget.searchProstheticDTO.type,
                                      ));
                                    },
                                  ),
                                )
                                .toList()
                          ],
                        ),
                        widget.searchProstheticDTO.itemId == null
                            ? Container()
                            : Column(
                                children: [
                                  CIA_DropDownSearchBasicIdName(
                                    label:
                                        "${prostheticItems.firstWhere((element) => element.id == widget.searchProstheticDTO.itemId).name ?? ""} Procedure",
                                    asyncUseCase: sl<GetProstheticStatusUseCase>(),
                                    selectedItem: widget.searchProstheticDTO.status,
                                    searchParams:
                                        GetProstheticStatusParams(itemId: widget.searchProstheticDTO.itemId!, type: widget.searchProstheticDTO.type),
                                    onSelect: (value) {
                                      widget.searchProstheticDTO.statusId = value.id;
                                      widget.searchProstheticDTO.status = value;
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  CIA_DropDownSearchBasicIdName(
                                    label:
                                        "${prostheticItems.firstWhere((element) => element.id == widget.searchProstheticDTO.itemId).name ?? ""} Next Step",
                                    asyncUseCase: sl<GetProstheticNextVisitUseCase>(),
                                    searchParams: GetProstheticNextVisitParams(
                                        itemId: widget.searchProstheticDTO.itemId!, type: widget.searchProstheticDTO.type),
                                    selectedItem: widget.searchProstheticDTO.nextVisit,
                                    onSelect: (value) {
                                      widget.searchProstheticDTO.nextId = value.id;
                                      widget.searchProstheticDTO.nextVisit = value;
                                    },
                                  ),
                                ],
                              )
                      ],
                    );
                  }),
            ),
            AdvancedSearchFilterChildWidget(
                title: "Post Prosthesis Complications (One of the following)",
                child: Column(
                  children: [
                    CIA_CheckBoxWidget(
                      text: "All",
                      value: widget.searchProstheticDTO.complicationsAfterProstheticIdsOr == null,
                      onChange: (value) {
                        setState(() {
                          widget.searchProstheticDTO.complicationsAfterProstheticIdsOr = null;
                        });
                      },
                    ),
                    ...(complicationsItems
                        .map(
                          (e) => CIA_CheckBoxWidget(
                            text: e.name ?? "",
                            value: widget.searchProstheticDTO.complicationsAfterProstheticIdsOr?.contains(e.id!) ?? false,
                            onChange: (value) {
                              if (value == true) {
                                widget.searchProstheticDTO.complicationsAfterProstheticIdsOr ??= [];
                                widget.searchProstheticDTO.complicationsAfterProstheticIdsOr?.add(e.id!);
                                widget.searchProstheticDTO.complicationsAfterProstheticIds?.remove(e.id!);
                              } else {
                                widget.searchProstheticDTO.complicationsAfterProstheticIdsOr?.remove(e.id!);
                              }

                              widget.searchProstheticDTO.complicationsAfterProstheticIdsOr =
                                  widget.searchProstheticDTO.complicationsAfterProstheticIdsOr?.toSet().toList();
                              widget.searchProstheticDTO.complicationsAfterProstheticIds =
                                  widget.searchProstheticDTO.complicationsAfterProstheticIds?.toSet().toList();

                              setState(() {});
                            },
                          ),
                        )
                        .toList()),
                  ],
                )),
            AdvancedSearchFilterChildWidget(
                title: "Post Prosthesis Complications (All of the following)",
                child: Column(
                  children: [
                    CIA_CheckBoxWidget(
                      text: "All",
                      value: widget.searchProstheticDTO.complicationsAfterProstheticIds == null,
                      onChange: (value) {
                        setState(() {
                          widget.searchProstheticDTO.complicationsAfterProstheticIds = null;
                        });
                      },
                    ),
                    ...(complicationsItems
                        .map(
                          (e) => CIA_CheckBoxWidget(
                            text: e.name ?? "",
                            value: widget.searchProstheticDTO.complicationsAfterProstheticIds?.contains(e.id!) ?? false,
                            onChange: (value) {
                              if (value == true) {
                                widget.searchProstheticDTO.complicationsAfterProstheticIds ??= [];
                                widget.searchProstheticDTO.complicationsAfterProstheticIds?.add(e.id!);
                                widget.searchProstheticDTO.complicationsAfterProstheticIdsOr?.remove(e.id!);
                              } else {
                                widget.searchProstheticDTO.complicationsAfterProstheticIds?.remove(e.id!);
                              }

                              widget.searchProstheticDTO.complicationsAfterProstheticIdsOr =
                                  widget.searchProstheticDTO.complicationsAfterProstheticIdsOr?.toSet().toList();
                              widget.searchProstheticDTO.complicationsAfterProstheticIds =
                                  widget.searchProstheticDTO.complicationsAfterProstheticIds?.toSet().toList();

                              setState(() {});
                            },
                          ),
                        )
                        .toList()),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
