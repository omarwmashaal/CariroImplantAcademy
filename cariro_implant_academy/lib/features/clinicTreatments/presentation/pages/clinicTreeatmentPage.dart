import 'dart:math';

import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TeethChart.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/implantEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getImplantCompaniesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getImplantLinesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getImplantSizesUseCase.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/rootCanalTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/scalingEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/tmdEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/useCases/updateTreatmentsUseCase.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc_Events.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../Widgets/MultiSelectChipWidget.dart';
import '../../../../core/injection_contianer.dart';
import '../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import '../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc_Events.dart';
import '../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc_States.dart';
import '../../../patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc.dart';
import '../../../patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc_States.dart';
import '../bloc/clinicTreatmentBloc_States.dart';

class ClinicTreatmentPage extends StatefulWidget {
  const ClinicTreatmentPage({
    Key? key,
    required this.patientId,
  }) : super(key: key);
  static const routeName = "ClinicTreatments";
  static const routePath = ":id/ClinicTreatments";
  final int patientId;

  @override
  State<ClinicTreatmentPage> createState() => _ClinicTreatmentPageState();
}

class _ClinicTreatmentPageState extends State<ClinicTreatmentPage> {
  late ClinicTreatmentBloc bloc;
  List<int> selectedTeeth = [];
  List<EnumClinicPedoTooth> selectedPedoTeeth = [];
  SelectedTreatmentEnum? selectedTreatment;
  EnumClinicImplantTypes? selectedImplantType;
  List<ExpansionTileController> expansionControllers = [];
  late MedicalInfoShellBloc medicalShellBloc;
  bool edit = false;
  late ClinicTreatmentEntity clinicTreatmentEntity;

  @override
  void initState() {
    bloc = BlocProvider.of<ClinicTreatmentBloc>(context);
    bloc.add(ClinicTreatmentBloc_LoadTreatmentsEvent(id: widget.patientId));
    expansionControllers.add(ExpansionTileController());
    expansionControllers.add(ExpansionTileController());
    expansionControllers.add(ExpansionTileController());
    expansionControllers.add(ExpansionTileController());
    expansionControllers.add(ExpansionTileController());
    expansionControllers.add(ExpansionTileController());
    expansionControllers.add(ExpansionTileController());
    medicalShellBloc = context.read<MedicalInfoShellBloc>();
    medicalShellBloc.add(MedicalInfoShell_ChangeTitleEvent(title: "Treatment"));
    super.initState();
  }

  @override
  void dispose() {
    if (edit == true && bloc.isInitialized) {
      bloc.add(ClinicTreatmentBloc_UpdateTreatmentsEvent(
          data: UpdateClinicTreatmentsParams(
        id: widget.patientId,
        data: clinicTreatmentEntity,
      )));
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
      listener: (context, state) {
        print("Current State $state");
        if (state is ClinicTreatmentBloc_SelectedTeethState) selectedTeeth = state.teeth;
      },
      buildWhen: (previous, current) =>
          current is ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState ||
          current is ClinicTreatmentBloc_LoadingTreatmentsState ||
          current is ClinicTreatmentBloc_LoadingTreatmentsErrorState,
      builder: (context, state) {
        if (state is ClinicTreatmentBloc_LoadingTreatmentsState)
          return LoadingWidget();
        else if (state is ClinicTreatmentBloc_LoadingTreatmentsErrorState)
          return BigErrorPageWidget(message: state.message);
        else if (state is ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState) {
          clinicTreatmentEntity = state.data;
          bloc.isInitialized = true;
          selectedTeeth.clear();
          selectedPedoTeeth.clear();
          selectedTreatment = null;
          selectedImplantType = null;
          return ListView(
            children: [
              Center(
                key: GlobalKey(),
                child: BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
                  buildWhen: (previous, current) => current is ClinicTreatmentBloc_SelectedTreatmentState,
                  builder: (context, state) {
                    if (state is ClinicTreatmentBloc_SelectedTreatmentState) selectedTreatment = state.selectedTreatment;
                    return CIA_MultiSelectChipWidget(
                      key: GlobalKey(),
                      singleSelect: true,
                      onChange: (item, isSelected) {
                        bloc.emit(
                          ClinicTreatmentBloc_SelectedTreatmentState(
                            selectedTreatment: SelectedTreatmentEnum.values.firstWhereOrNull(
                              (element) => element.name.toLowerCase().removeAllWhitespace == item.removeAllWhitespace.toLowerCase(),
                            ),
                          ),
                        );
                      },
                      labels: [
                        CIA_MultiSelectChipWidgeModel(
                          label: "Restoration",
                          isSelected: selectedTreatment == SelectedTreatmentEnum.restoration,
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "Implants",
                          isSelected: selectedTreatment == SelectedTreatmentEnum.implants,
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "Ortho",
                          isSelected: selectedTreatment == SelectedTreatmentEnum.ortho,
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "TMD",
                          isSelected: selectedTreatment == SelectedTreatmentEnum.tmd,
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "Pedo",
                          isSelected: selectedTreatment == SelectedTreatmentEnum.pedo,
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "Root Canal Treatment",
                          isSelected: selectedTreatment == SelectedTreatmentEnum.rootCanalTreatment,
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "Scaling",
                          isSelected: selectedTreatment == SelectedTreatmentEnum.scaling,
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                key: GlobalKey(),
                child: BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
                  buildWhen: (previous, current) => current is ClinicTreatmentBloc_SelectedTreatmentState,
                  builder: (context, state) {
                    if (state is ClinicTreatmentBloc_SelectedTreatmentState) selectedTreatment = state.selectedTreatment;
                    print("Got here");
                    return selectedTreatment == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: CIA_TeethChart(
                              onChange: (selectedTeethList) {
                                selectedTeeth = selectedTeethList;
                                bloc.emit(ClinicTreatmentBloc_SelectedTeethState(teeth: selectedTeeth));
                              },
                            ),
                          );
                  },
                ),
              ),
              Center(
                key: GlobalKey(),
                child: BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
                  buildWhen: (previous, current) => current is ClinicTreatmentBloc_SelectedTeethState,
                  builder: (context, state) {
                    bool show = false;
                    if (state is ClinicTreatmentBloc_SelectedTeethState) {
                      if (state.teeth.isNotEmpty && selectedTreatment == SelectedTreatmentEnum.implants)
                        show = true;
                      else
                        show = false;
                    }
                    return Visibility(
                      visible: show,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CIA_MultiSelectChipWidget(
                          key: GlobalKey(),
                          singleSelect: true,
                          onChange: (item, isSelected) {
                            selectedImplantType = EnumClinicImplantTypes.values.firstWhere((element) => element.name == item);
                            bloc.emit(ClinicTreatmentBloc_SelectedImplantTypeState(
                              implantType: EnumClinicImplantTypes.values.firstWhere((element) => element.name == item),
                            ));
                          },
                          labels: [
                            CIA_MultiSelectChipWidgeModel(
                              label: "Simple",
                              isSelected: selectedImplantType == EnumClinicImplantTypes.Simple,
                            ),
                            CIA_MultiSelectChipWidgeModel(
                              label: "Immediate",
                              isSelected: selectedTreatment == EnumClinicImplantTypes.Immediate,
                            ),
                            CIA_MultiSelectChipWidgeModel(
                              label: "Guided",
                              isSelected: selectedTreatment == EnumClinicImplantTypes.Guided,
                            ),
                            CIA_MultiSelectChipWidgeModel(
                              label: "Expansion",
                              isSelected: selectedTreatment == EnumClinicImplantTypes.Expansion,
                            ),
                            CIA_MultiSelectChipWidgeModel(
                              label: "Splitting",
                              isSelected: selectedTreatment == EnumClinicImplantTypes.Splitting,
                            ),
                            CIA_MultiSelectChipWidgeModel(
                              label: "GBR",
                              isSelected: selectedTreatment == EnumClinicImplantTypes.GBR,
                            ),
                            CIA_MultiSelectChipWidgeModel(
                              label: "OpenSinus",
                              isSelected: selectedTreatment == EnumClinicImplantTypes.OpenSinus,
                            ),
                            CIA_MultiSelectChipWidgeModel(
                              label: "ClosedSinus",
                              isSelected: selectedTreatment == EnumClinicImplantTypes.ClosedSinus,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Center(
                key: GlobalKey(),
                child: BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
                  buildWhen: (previous, current) => current is ClinicTreatmentBloc_SelectedTreatmentState,
                  builder: (context, state) {
                    bool show = false;
                    if (state is ClinicTreatmentBloc_SelectedTreatmentState) {
                      if (state.selectedTreatment == SelectedTreatmentEnum.pedo)
                        show = true;
                      else
                        show = false;
                    }
                    return Visibility(
                      visible: show,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CIA_TeethPedoChart(
                          onChange: (selectedTeethList) {
                            selectedPedoTeeth = selectedTeethList;
                            bloc.emit(ClinicTreatmentBloc_SelectedPedoTeethState(teeth: selectedPedoTeeth));
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                  bloc: medicalShellBloc,
                  buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
                  builder: (context, stateShell) {
                    return AbsorbPointer(
                      absorbing: () {
                        if (stateShell is MedicalInfoBlocChangeViewEditState) {
                          edit = stateShell.edit;
                          return !edit;
                        } else {
                          edit = false;
                          return true;
                        }
                      }(),
                      child: Center(
                        key: GlobalKey(),
                        child: !edit
                            ? Text("Please enable edit mode to modify")
                            : BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
                                buildWhen: (previous, current) =>
                                    current is ClinicTreatmentBloc_SelectedPedoTeethState ||
                                    current is ClinicTreatmentBloc_SelectedTeethState ||
                                    current is ClinicTreatmentBloc_SelectedImplantTypeState,
                                builder: (context, state) {
                                  return Visibility(
                                      visible: (state is ClinicTreatmentBloc_SelectedPedoTeethState && (state.teeth.isNotEmpty || selectedTeeth.isNotEmpty)) ||
                                          state is ClinicTreatmentBloc_SelectedImplantTypeState ||
                                          (state is ClinicTreatmentBloc_SelectedTeethState &&
                                              (state.teeth.isNotEmpty || selectedPedoTeeth.isNotEmpty) &&
                                              selectedTreatment != SelectedTreatmentEnum.implants),
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  bloc.add(ClinicTreatmentBloc_BuildPageEvent(
                                                      data: clinicTreatmentEntity,
                                                      selectedTeeth: selectedTeeth,
                                                      selectedTreatmentEnum: selectedTreatment!,
                                                      selectedPedoTeeth: selectedPedoTeeth,
                                                      implantType: selectedImplantType));
                                                },
                                                icon: Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(
                                                    data: clinicTreatmentEntity,
                                                  ));
                                                },
                                                icon: Icon(
                                                  Icons.remove,
                                                  color: Colors.red,
                                                )),
                                          ],
                                        ),
                                      ));
                                },
                              ),
                      ),
                    );
                  }),
              Visibility(
                visible: clinicTreatmentEntity.restorations!.isNotEmpty,
                child: ExpansionTile(
                  controller: expansionControllers[0],
                  onExpansionChanged: (value) {
                    int index = 0;
                    if (value)
                      for (var c in expansionControllers) {
                        if (index != 0) c.collapse();
                        index++;
                      }
                  },
                  title: Text("Restoration"),
                  maintainState: true,
                  children: clinicTreatmentEntity.restorations!
                      .map((e) => BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                          bloc: medicalShellBloc,
                          buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
                          builder: (context, stateShell) {
                            return AbsorbPointer(
                              absorbing: () {
                                if (stateShell is MedicalInfoBlocChangeViewEditState) {
                                  edit = stateShell.edit;
                                  return !edit;
                                } else {
                                  edit = false;
                                  return true;
                                }
                              }(),
                              child: Container(
                                height: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FormTextKeyWidget(text: "Tooth: ${e.tooth!}"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Flexible(
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                clinicTreatmentEntity.restorations!.remove(e);
                                                bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              )),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: CIA_DropDownSearchBasicIdName(
                                              label: "Status",
                                              selectedItem: () {
                                                var t = e.status == null ? null : BasicNameIdObjectEntity(name: e.status!.name);
                                                return t;
                                              }(),
                                              items: EnumClinicRestorationStatus.values.map((e) => BasicNameIdObjectEntity(name: e.name)).toList(),
                                              onSelect: (v) {
                                                e.status = EnumClinicRestorationStatus.values.firstWhere((element) => element.name == v.name);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: CIA_DropDownSearch(
                                              label: "Type",
                                              selectedItem: e.type == null ? null : DropDownDTO(name: e.type!.name),
                                              items: EnumClinicRestorationType.values.map((e) => DropDownDTO(name: e.name)).toList(),
                                              onSelect: (v) {
                                                e.type = EnumClinicRestorationType.values.firstWhere((element) => element.name == v.name);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: CIA_DropDownSearch(
                                              label: "Class",
                                              selectedItem: e.restorationClass == null ? null : DropDownDTO(name: e.restorationClass!.name),
                                              items: EnumClinicRestorationClass.values.map((e) => DropDownDTO(name: e.name)).toList(),
                                              onSelect: (v) {
                                                e.restorationClass = EnumClinicRestorationClass.values.firstWhere((element) => element.name == v.name);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }))
                      .toList(),
                ),
              ),
              Visibility(
                visible: clinicTreatmentEntity.clinicImplants!.isNotEmpty,
                child: ExpansionTile(
                  controller: expansionControllers[1],
                  onExpansionChanged: (value) {
                    int index = 0;
                    if (value)
                      for (var c in expansionControllers) {
                        if (index != 1) c.collapse();
                        index++;
                      }
                  },
                  title: Text("Implants"),
                  maintainState: true,
                  children: clinicTreatmentEntity.clinicImplants!
                      .map(
                        (e) => BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                            bloc: medicalShellBloc,
                            buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
                            builder: (context, stateShell) {
                              return AbsorbPointer(
                                  absorbing: () {
                                    if (stateShell is MedicalInfoBlocChangeViewEditState) {
                                      edit = stateShell.edit;
                                      return !edit;
                                    } else {
                                      edit = false;
                                      return true;
                                    }
                                  }(),
                                  child: Container(
                                    height: 100,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        FormTextKeyWidget(text: "Tooth: ${e.tooth!} || ${e.type!.name} Implant"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        StatefulBuilder(builder: (context, _setState) {
                                          return Flexible(
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      clinicTreatmentEntity.clinicImplants!.remove(e);
                                                      bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    )),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: CIA_TextFormField(
                                                    controller: TextEditingController(text: e.notes ?? ""),
                                                    label: "Notes",
                                                    onChange: (value) => e.notes = value,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: CIA_DropDownSearchBasicIdName(
                                                    asyncUseCase: sl<GetImplantCompaniesUseCase>(),
                                                    label: "Implant Companies",
                                                    selectedItem: e.implantCompany_,
                                                    onSelect: (v) {
                                                      e.implantCompany_ = v;
                                                      e.implantCompanyId = v.id;
                                                      _setState(() {});
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: CIA_DropDownSearchBasicIdName<int>(
                                                    asyncUseCase: e.implantCompanyId == null ? null : sl<GetImplantLinesUseCase>(),
                                                    searchParams: e.implantCompanyId,
                                                    emptyString: "Please choose Implant Company First",
                                                    label: "Implant Lines",
                                                    selectedItem: e.implantLine_,
                                                    onSelect: (v) {
                                                      e.implantLine_ = v;
                                                      e.implantLineId = v.id;
                                                      _setState(() {});
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: CIA_DropDownSearchBasicIdName<int>(
                                                    asyncUseCase: e.implantLineId == null ? null : sl<GetImplantSizesUseCase>(),
                                                    searchParams: e.implantLineId,
                                                    emptyString: "Please choose Implant Line First",
                                                    label: "Implant Sizes",
                                                    selectedItem: e.implant_,
                                                    onSelect: (v) {
                                                      e.implant_ = ImplantEntity(id: v.id, name: v.name);
                                                      e.implantId = v.id;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ));
                            }),
                      )
                      .toList(),
                ),
              ),
              Visibility(
                visible: clinicTreatmentEntity.orthoTreatments!.isNotEmpty,
                child: ExpansionTile(
                  controller: expansionControllers[2],
                  onExpansionChanged: (value) {
                    int index = 0;
                    if (value)
                      for (var c in expansionControllers) {
                        if (index != 2) c.collapse();
                        index++;
                      }
                  },
                  title: Text("Ortho"),
                  maintainState: true,
                  children: clinicTreatmentEntity.orthoTreatments!
                      .map(
                        (e) => BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                            bloc: medicalShellBloc,
                            buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
                            builder: (context, stateShell) {
                              return AbsorbPointer(
                                  absorbing: () {
                                    if (stateShell is MedicalInfoBlocChangeViewEditState) {
                                      edit = stateShell.edit;
                                      return !edit;
                                    } else {
                                      edit = false;
                                      return true;
                                    }
                                  }(),
                                  child: Container(
                                    height: 100,
                                    child: Row(
                                      children: [
                                        FormTextValueWidget(text: "Tooth: ${e.tooth ?? ""}"),
                                        SizedBox(width: 10),
                                        IconButton(
                                            onPressed: () {
                                              clinicTreatmentEntity.orthoTreatments!.remove(e);
                                              bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            )),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: CIA_TextFormField(
                                            controller: TextEditingController(text: e.notes ?? ""),
                                            label: "Notes",
                                            onChange: (value) => e.notes = value,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            }),
                      )
                      .toList(),
                ),
              ),
              Visibility(
                visible: clinicTreatmentEntity.tmds!.isNotEmpty,
                child: ExpansionTile(
                    controller: expansionControllers[3],
                    onExpansionChanged: (value) {
                      int index = 0;
                      if (value)
                        for (var c in expansionControllers) {
                          if (index != 3) c.collapse();
                          index++;
                        }
                    },
                    title: Text("TMD"),
                    maintainState: true,
                    children: () {
                      //   clinicTreatmentEntity.tmds = [...clinicTreatmentEntity.tmds!,TMDEntity()];
                      List<Widget> r = [];
                      List<int> teeth = clinicTreatmentEntity.tmds!.map((e) => e.tooth!).toSet().toList();
                      teeth.sort();
                      for (var tooth in teeth) {
                        var steps = clinicTreatmentEntity.tmds!.where((element) => element.tooth == tooth && element.type != null).toList();
                        steps.sort((a, b) => a.stepNumber!.compareTo(b.stepNumber!));
                        List<Widget> internalSteps = [];
                        for (var step in steps) {
                          internalSteps.add(Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Visibility(
                                          visible: step.stepNumber != 1,
                                          child: IconButton(
                                              onPressed: () {
                                                step.stepNumber = step.stepNumber! - 1;
                                                (steps.firstWhere((element) => element.stepNumber == step.stepNumber)).stepNumber =
                                                    (steps.firstWhere((element) => element.stepNumber == step.stepNumber)).stepNumber! + 1;
                                                bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                              },
                                              icon: Icon(Icons.arrow_upward_rounded))),
                                    ),
                                    Expanded(
                                        child: Visibility(
                                            visible: step.stepNumber != steps.last.stepNumber,
                                            child: IconButton(
                                                onPressed: () {
                                                  step.stepNumber = step.stepNumber! + 1;
                                                  (steps.lastWhere((element) => element.stepNumber == step.stepNumber)).stepNumber =
                                                      (steps.lastWhere((element) => element.stepNumber == step.stepNumber)).stepNumber! - 1;
                                                  bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                                },
                                                icon: Icon(Icons.arrow_downward_rounded)))),
                                    Expanded(
                                        child: IconButton(
                                            onPressed: () {
                                              int stepNumber = step.stepNumber!;
                                              clinicTreatmentEntity.tmds!.remove(step);
                                              for (var s in steps.where((element) => element.type != null && (element.stepNumber!) > stepNumber)) {
                                                s.stepNumber = (s.stepNumber!) - 1;
                                              }
                                              bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))),
                                    Expanded(child: FormTextValueWidget(text: "${step?.stepNumber ?? ""}. ")),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 8,
                                  child: Row(
                                    children: [
                                      Expanded(child: FormTextValueWidget(text: step?.type?.name ?? "")),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 9,
                                        child: CIA_TextFormField(
                                          label: "Notes",
                                          controller: TextEditingController(text: step.notes ?? ""),
                                          onChange: (value) => step.notes = value,
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ));
                          internalSteps.add(SizedBox(height: 10));
                        }
                        r.add(Container(
                          height: 40 + 30 * (internalSteps.length) as double,
                          child: BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                              bloc: medicalShellBloc,
                              buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
                              builder: (context, stateShell) {
                                return AbsorbPointer(
                                    absorbing: () {
                                      if (stateShell is MedicalInfoBlocChangeViewEditState) {
                                        edit = stateShell.edit;
                                        return !edit;
                                      } else {
                                        edit = false;
                                        return true;
                                      }
                                    }(),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            FormTextKeyWidget(text: "Tooth: $tooth"),
                                            CIA_SecondaryButton(
                                              label: "Add Step",
                                              onTab: () {
                                                CIA_ShowPopUp(
                                                    height: 100,
                                                    width: 700,
                                                    context: context,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        CIA_SecondaryButton(
                                                            label: "Diagnosis",
                                                            onTab: () {
                                                              if (clinicTreatmentEntity.tmds!
                                                                  .where((element) => element.tooth == tooth && element.type == EnumClinicTMDtypes.Diagnosis)
                                                                  .isNotEmpty) {
                                                                dialogHelper.dismissSingle(context);
                                                                ShowSnackBar(context, isSuccess: false, message: "This tooth has already been diagnosed");
                                                                return;
                                                              }
                                                              int stepNumber = 1;
                                                              var numbers = clinicTreatmentEntity.tmds!
                                                                  .where((element) => element.tooth == tooth)
                                                                  .map((e) => e.stepNumber ?? 0)
                                                                  .toSet()
                                                                  .toList()
                                                                ..remove(0);
                                                              if (numbers.isNotEmpty) {
                                                                numbers.sort();
                                                                stepNumber = numbers.last! + 1;
                                                              }
                                                              clinicTreatmentEntity.tmds = [
                                                                ...clinicTreatmentEntity.tmds!,
                                                                TMDEntity(
                                                                  tooth: tooth,
                                                                  patientId: widget.patientId,
                                                                  type: EnumClinicTMDtypes.Diagnosis,
                                                                  stepNumber: stepNumber,
                                                                )
                                                              ];
                                                              bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                                              dialogHelper.dismissSingle(context);
                                                            }),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        CIA_SecondaryButton(
                                                            label: "Injection",
                                                            onTab: () {
                                                              int stepNumber = 1;
                                                              var numbers = clinicTreatmentEntity.tmds!
                                                                  .where((element) => element.tooth == tooth)
                                                                  .map((e) => e.stepNumber ?? 0)
                                                                  .toSet()
                                                                  .toList()
                                                                ..remove(0);
                                                              if (numbers.isNotEmpty) {
                                                                numbers.sort();
                                                                stepNumber = numbers.last! + 1;
                                                              }
                                                              clinicTreatmentEntity.tmds = [
                                                                ...clinicTreatmentEntity.tmds!,
                                                                TMDEntity(
                                                                  tooth: tooth,
                                                                  patientId: widget.patientId,
                                                                  type: EnumClinicTMDtypes.Injection,
                                                                  stepNumber: stepNumber,
                                                                )
                                                              ];
                                                              bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                                              dialogHelper.dismissSingle(context);
                                                            }),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        CIA_SecondaryButton(
                                                            label: "SRS",
                                                            onTab: () {
                                                              int stepNumber = 1;
                                                              var numbers = clinicTreatmentEntity.tmds!
                                                                  .where((element) => element.tooth == tooth)
                                                                  .map((e) => e.stepNumber ?? 0)
                                                                  .toSet()
                                                                  .toList()
                                                                ..remove(0);
                                                              if (numbers.isNotEmpty) {
                                                                numbers.sort();
                                                                stepNumber = numbers.last! + 1;
                                                              }
                                                              clinicTreatmentEntity.tmds = [
                                                                ...clinicTreatmentEntity.tmds!,
                                                                TMDEntity(
                                                                  tooth: tooth,
                                                                  patientId: widget.patientId,
                                                                  type: EnumClinicTMDtypes.SRS,
                                                                  stepNumber: stepNumber,
                                                                )
                                                              ];
                                                              bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                                              dialogHelper.dismissSingle(context);
                                                            }),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        CIA_SecondaryButton(
                                                            label: "Night Guard Hard",
                                                            onTab: () {
                                                              int stepNumber = 1;
                                                              var numbers = clinicTreatmentEntity.tmds!
                                                                  .where((element) => element.tooth == tooth)
                                                                  .map((e) => e.stepNumber ?? 0)
                                                                  .toSet()
                                                                  .toList()
                                                                ..remove(0);
                                                              if (numbers.isNotEmpty) {
                                                                numbers.sort();
                                                                stepNumber = numbers.last! + 1;
                                                              }
                                                              clinicTreatmentEntity.tmds = [
                                                                ...clinicTreatmentEntity.tmds!,
                                                                TMDEntity(
                                                                  tooth: tooth,
                                                                  patientId: widget.patientId,
                                                                  type: EnumClinicTMDtypes.NightGuardHard,
                                                                  stepNumber: stepNumber,
                                                                )
                                                              ];
                                                              bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                                              dialogHelper.dismissSingle(context);
                                                            }),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        CIA_SecondaryButton(
                                                            label: "Night Guard Soft",
                                                            onTab: () {
                                                              int stepNumber = 1;
                                                              var numbers = clinicTreatmentEntity.tmds!
                                                                  .where((element) => element.tooth == tooth)
                                                                  .map((e) => e.stepNumber ?? 0)
                                                                  .toSet()
                                                                  .toList()
                                                                ..remove(0);
                                                              if (numbers.isNotEmpty) {
                                                                numbers.sort();
                                                                stepNumber = numbers.last! + 1;
                                                              }
                                                              clinicTreatmentEntity.tmds = [
                                                                ...clinicTreatmentEntity.tmds!,
                                                                TMDEntity(
                                                                  tooth: tooth,
                                                                  patientId: widget.patientId,
                                                                  type: EnumClinicTMDtypes.NightGuardSoft,
                                                                  stepNumber: stepNumber,
                                                                )
                                                              ];
                                                              bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                                              dialogHelper.dismissSingle(context);
                                                            }),
                                                      ],
                                                    ));
                                              },
                                              icon: Icon(Icons.add),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ]..addAll(internalSteps),
                                    ));
                              }),
                        ));
                      }
                      return r;
                    }()),
              ),
              Visibility(
                visible: clinicTreatmentEntity.pedos!.isNotEmpty,
                child: ExpansionTile(
                  controller: expansionControllers[4],
                  onExpansionChanged: (value) {
                    int index = 0;
                    if (value)
                      for (var c in expansionControllers) {
                        if (index != 4) c.collapse();
                        index++;
                      }
                  },
                  title: Text("Pedo"),
                  maintainState: true,
                  children: clinicTreatmentEntity.pedos!
                      .map(
                        (e) => BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                            bloc: medicalShellBloc,
                            buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
                            builder: (context, stateShell) {
                              return AbsorbPointer(
                                  absorbing: () {
                                    if (stateShell is MedicalInfoBlocChangeViewEditState) {
                                      edit = stateShell.edit;
                                      return !edit;
                                    } else {
                                      edit = false;
                                      return true;
                                    }
                                  }(),
                                  child: Container(
                                    height: 100,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        FormTextKeyWidget(text: "Tooth: ${e.tooth == null ? e.toothPedo!.name : e.tooth!}"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Flexible(
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    clinicTreatmentEntity.pedos!.remove(e);
                                                    bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  )),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: CIA_DropDownSearchBasicIdName(
                                                  label: "First Step",
                                                  selectedItem: e.firstStep == null ? null : BasicNameIdObjectEntity(name: e.firstStep!.name),
                                                  items: EnumClinicPedoFirstStep.values.map((e) => BasicNameIdObjectEntity(name: e.name)).toList(),
                                                  onSelect: (v) {
                                                    if (v?.name == "NotSelected") {
                                                      e.firstStep = null;
                                                      return;
                                                    }
                                                    e.firstStep = EnumClinicPedoFirstStep.values.firstWhere((element) => element.name == v.name);
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: CIA_DropDownSearchBasicIdName(
                                                  label: "Second Step",
                                                  selectedItem: e.secondStep == null ? null : BasicNameIdObjectEntity(name: e.secondStep!.name),
                                                  items: EnumClinicPedoSecondStep.values.map((e) => BasicNameIdObjectEntity(name: e.name)).toList(),
                                                  onSelect: (v) {
                                                    if (v?.name == "NotSelected") {
                                                      e.secondStep = null;
                                                      return;
                                                    }
                                                    e.secondStep = EnumClinicPedoSecondStep.values.firstWhere((element) => element.name == v.name);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            }),
                      )
                      .toList(),
                ),
              ),
              Visibility(
                visible: clinicTreatmentEntity.rootCanalTreatments!.isNotEmpty,
                child: ExpansionTile(
                    controller: expansionControllers[5],
                    onExpansionChanged: (value) {
                      int index = 0;
                      if (value)
                        for (var c in expansionControllers) {
                          if (index != 5) c.collapse();
                          index++;
                        }
                    },
                    title: Text("Root Canal Treatment"),
                    maintainState: true,
                    children: () {
                      List<Widget> r = [];
                      List<int> teeth = clinicTreatmentEntity.rootCanalTreatments!.map((e) => e.tooth!).toSet().toList();
                      teeth.sort();
                      for (var tooth in teeth) {
                        var canals = clinicTreatmentEntity.rootCanalTreatments!.where((element) => element.tooth == tooth).toList();
                        canals.sort((a, b) => a.canalNumber!.compareTo(b.canalNumber!));
                        List<Widget> internalCanals = [];
                        for (var canal in canals) {
                          internalCanals.add(Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Visibility(
                                          visible: canal.canalNumber != 1,
                                          child: IconButton(
                                              onPressed: () {
                                                canal.canalNumber = canal.canalNumber! - 1;
                                                (canals.firstWhere((element) => element.canalNumber == canal.canalNumber)).canalNumber =
                                                    (canals.firstWhere((element) => element.canalNumber == canal.canalNumber)).canalNumber! + 1;
                                                bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                              },
                                              icon: Icon(Icons.arrow_upward_rounded))),
                                    ),
                                    Expanded(
                                        child: Visibility(
                                            visible: canal.canalNumber != canals.last.canalNumber,
                                            child: IconButton(
                                                onPressed: () {
                                                  canal.canalNumber = canal.canalNumber! + 1;
                                                  (canals.lastWhere((element) => element.canalNumber == canal.canalNumber)).canalNumber =
                                                      (canals.lastWhere((element) => element.canalNumber == canal.canalNumber)).canalNumber! - 1;
                                                  bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                                },
                                                icon: Icon(Icons.arrow_downward_rounded)))),
                                    Expanded(
                                        child: IconButton(
                                            onPressed: () {
                                              int canalNumber = canal.canalNumber!;
                                              clinicTreatmentEntity.rootCanalTreatments!.remove(canal);
                                              for (var s in canals.where((element) => element.type != null && (element.canalNumber!) > canalNumber)) {
                                                s.canalNumber = (s.canalNumber!) - 1;
                                              }
                                              bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))),
                                    Expanded(child: FormTextValueWidget(text: "${canal?.canalNumber ?? ""}. ")),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 8,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: CIA_MultiSelectChipWidget(
                                        labels: () {
                                          List<CIA_MultiSelectChipWidgeModel> r = [];
                                          var allowedEnum = EnumClinicRootCanalTreatmentType.values;
                                          switch (tooth % 10) {
                                            case 1:
                                              {
                                                allowedEnum = [EnumClinicRootCanalTreatmentType.SingleCanal];
                                                break;
                                              }
                                            case 2:
                                              {
                                                allowedEnum = [
                                                  EnumClinicRootCanalTreatmentType.B,
                                                  EnumClinicRootCanalTreatmentType.L,
                                                ];
                                                break;
                                              }
                                            case 3:
                                              {
                                                allowedEnum = [
                                                  EnumClinicRootCanalTreatmentType.B,
                                                  EnumClinicRootCanalTreatmentType.L,
                                                ];
                                                break;
                                              }
                                            case 4:
                                              {
                                                allowedEnum = [
                                                  EnumClinicRootCanalTreatmentType.B,
                                                  EnumClinicRootCanalTreatmentType.L,
                                                  EnumClinicRootCanalTreatmentType.Other,
                                                ];
                                                break;
                                              }
                                            case 5:
                                              {
                                                allowedEnum = [
                                                  EnumClinicRootCanalTreatmentType.B,
                                                  EnumClinicRootCanalTreatmentType.L,
                                                  EnumClinicRootCanalTreatmentType.Other,
                                                ];
                                                break;
                                              }
                                            case 6:
                                              {
                                                if (tooth < 30) {
                                                  allowedEnum = [
                                                    EnumClinicRootCanalTreatmentType.MB,
                                                    EnumClinicRootCanalTreatmentType.DB,
                                                    EnumClinicRootCanalTreatmentType.MB2,
                                                    EnumClinicRootCanalTreatmentType.P,
                                                  ];
                                                } else
                                                  allowedEnum = [
                                                    EnumClinicRootCanalTreatmentType.MB,
                                                    EnumClinicRootCanalTreatmentType.DB,
                                                    EnumClinicRootCanalTreatmentType.DL,
                                                    EnumClinicRootCanalTreatmentType.Other,
                                                  ];
                                                break;
                                              }
                                            case 7:
                                              {
                                                if (tooth < 30) {
                                                  allowedEnum = [
                                                    EnumClinicRootCanalTreatmentType.MB,
                                                    EnumClinicRootCanalTreatmentType.DB,
                                                    EnumClinicRootCanalTreatmentType.MB2,
                                                    EnumClinicRootCanalTreatmentType.P,
                                                  ];
                                                } else
                                                  allowedEnum = [
                                                    EnumClinicRootCanalTreatmentType.MB,
                                                    EnumClinicRootCanalTreatmentType.DB,
                                                    EnumClinicRootCanalTreatmentType.DL,
                                                    EnumClinicRootCanalTreatmentType.Other,
                                                  ];
                                                break;
                                              }
                                            case 8:
                                              {
                                                if (tooth < 30) {
                                                  allowedEnum = [
                                                    EnumClinicRootCanalTreatmentType.MB,
                                                    EnumClinicRootCanalTreatmentType.DB,
                                                    EnumClinicRootCanalTreatmentType.MB2,
                                                    EnumClinicRootCanalTreatmentType.P,
                                                  ];
                                                } else
                                                  allowedEnum = [
                                                    EnumClinicRootCanalTreatmentType.MB,
                                                    EnumClinicRootCanalTreatmentType.DB,
                                                    EnumClinicRootCanalTreatmentType.DL,
                                                    EnumClinicRootCanalTreatmentType.Other,
                                                  ];
                                                break;
                                              }
                                          }
                                          for (var allowed in allowedEnum) {
                                            r.add(CIA_MultiSelectChipWidgeModel(label: allowed.name, isSelected: canal.type == allowed));
                                          }
                                          return r;
                                        }(),
                                        singleSelect: true,
                                        onChange: (item, isSelected) {
                                          if (isSelected)
                                            canal.type = EnumClinicRootCanalTreatmentType.values.firstWhere((element) => element.name == item);
                                          else
                                            canal.type = null;
                                        },
                                      )),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CIA_TextFormField(
                                          label: "Notes",
                                          controller: TextEditingController(text: canal.notes ?? ""),
                                          onChange: (value) => canal.notes = value,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CIA_TextFormField(
                                          label: "Length",
                                          controller: TextEditingController(text: canal.length?.toString() ?? ""),
                                          suffix: "mm",
                                          isNumber: true,
                                          onChange: (value) => canal.length = int.parse(value == "" || value == null ? "0" : value!),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ));
                          internalCanals.add(SizedBox(height: 10));
                        }
                        r.add(Container(
                          height: 40 + 30 * (internalCanals.length) as double,
                          child: BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                              bloc: medicalShellBloc,
                              buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
                              builder: (context, stateShell) {
                                return AbsorbPointer(
                                    absorbing: () {
                                      if (stateShell is MedicalInfoBlocChangeViewEditState) {
                                        edit = stateShell.edit;
                                        return !edit;
                                      } else {
                                        edit = false;
                                        return true;
                                      }
                                    }(),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            FormTextKeyWidget(text: "Tooth: $tooth"),
                                            SizedBox(width: 10),
                                            CIA_SecondaryButton(
                                              label: "Add Step",
                                              onTab: () {
                                                clinicTreatmentEntity.rootCanalTreatments = [
                                                  ...clinicTreatmentEntity.rootCanalTreatments!,
                                                  RootCanalTreatmentEntity(
                                                      patientId: widget.patientId,
                                                      tooth: tooth,
                                                      canalNumber: (clinicTreatmentEntity.rootCanalTreatments!
                                                                  .where((element) => element.tooth == tooth)
                                                                  .map((e) => e.canalNumber!)
                                                                  .toList()
                                                                ..sort(
                                                                  (a, b) => a.compareTo(b),
                                                                ))
                                                              .last +
                                                          1)
                                                ];
                                                bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                              },
                                              icon: Icon(Icons.add),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ]..addAll(internalCanals),
                                    ));
                              }),
                        ));
                      }
                      return r;
                    }()),
              ),
              Visibility(
                visible: clinicTreatmentEntity.scalings!.isNotEmpty,
                child: ExpansionTile(
                    controller: expansionControllers[6],
                    onExpansionChanged: (value) {
                      int index = 0;
                      if (value)
                        for (var c in expansionControllers) {
                          if (index != 6) c.collapse();
                          index++;
                        }
                    },
                    title: Text("Scaling"),
                    maintainState: true,
                    children: () {
                      List<Widget> r = [];
                      List<int> teeth = clinicTreatmentEntity.scalings!.map((e) => e.tooth!).toSet().toList();
                      teeth.sort();
                      for (var tooth in teeth) {
                        var steps = clinicTreatmentEntity.scalings!.where((element) => element.tooth == tooth).toList();
                        steps.sort((a, b) => a.stepNumber!.compareTo(b.stepNumber!));
                        List<Widget> internalSteps = [];
                        for (var step in steps) {
                          internalSteps.add(Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded  (
                                      child: Visibility(
                                          visible: step.stepNumber != 1,
                                          child: IconButton(
                                              onPressed: () {
                                                step.stepNumber = step.stepNumber! - 1;
                                                (steps.firstWhere((element) => element.stepNumber == step.stepNumber)).stepNumber =
                                                    (steps.firstWhere((element) => element.stepNumber == step.stepNumber)).stepNumber! + 1;
                                                bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                              },
                                              icon: Icon(Icons.arrow_upward_rounded))),
                                    ),
                                    Expanded(
                                        child: Visibility(
                                            visible: step.stepNumber != steps.last.stepNumber,
                                            child: IconButton(
                                                onPressed: () {
                                                  step.stepNumber = step.stepNumber! + 1;
                                                  (steps.lastWhere((element) => element.stepNumber == step.stepNumber)).stepNumber =
                                                      (steps.lastWhere((element) => element.stepNumber == step.stepNumber)).stepNumber! - 1;
                                                  bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                                },
                                                icon: Icon(Icons.arrow_downward_rounded)))),
                                    Expanded(
                                        child: IconButton(
                                            onPressed: () {
                                              int stepNumber = step.stepNumber!;
                                              clinicTreatmentEntity.scalings!.remove(step);
                                              for (var s in steps.where((element) => element.type != null && (element.stepNumber!) > stepNumber)) {
                                                s.stepNumber = (s.stepNumber!) - 1;
                                              }
                                              bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))),
                                    Expanded(child: FormTextValueWidget(text: "${step?.stepNumber ?? ""}. ")),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 8,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child:CIA_DropDownSearchBasicIdName(
                                          selectedItem: step.type==null?null:BasicNameIdObjectEntity(name: step.type?.name),
                                          items: EnumClinicScalingType.values.map((e) => BasicNameIdObjectEntity(name: e.name)).toList(),
                                          label: "Type",
                                          onSelect: (value) {
                                            step.type = EnumClinicScalingType.values.firstWhere((element) => element.name==value.name);
                                          },
                                        ) ,

                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CIA_TextFormField(
                                          label: "Notes",
                                          controller: TextEditingController(text: step.notes ?? ""),
                                          onChange: (value) => step.notes = value,
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ));
                          internalSteps.add(SizedBox(height: 10));
                        }
                        r.add(Container(
                          height: 40 + 30 * (internalSteps.length) as double,
                          child: BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                              bloc: medicalShellBloc,
                              buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
                              builder: (context, stateShell) {
                                return AbsorbPointer(
                                    absorbing: () {
                                      if (stateShell is MedicalInfoBlocChangeViewEditState) {
                                        edit = stateShell.edit;
                                        return !edit;
                                      } else {
                                        edit = false;
                                        return true;
                                      }
                                    }(),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          children: [
                                            FormTextKeyWidget(text: "Tooth: $tooth"),
                                            SizedBox(width: 10),
                                            CIA_SecondaryButton(
                                              label: "Add Step",
                                              onTab: () {
                                                if(steps.where((element) => element.type==EnumClinicScalingType.Regular).isNotEmpty)
                                                  ShowSnackBar(context, isSuccess: false,message: "Regular Scaling already done!");
                                                else {
                                                  clinicTreatmentEntity.scalings = [
                                                    ...clinicTreatmentEntity.scalings!,
                                                    ScalingEntity(
                                                        patientId: widget.patientId,
                                                        tooth: tooth,
                                                        stepNumber: (clinicTreatmentEntity.scalings!
                                                                    .where((element) => element.tooth == tooth)
                                                                    .map((e) => e.stepNumber!)
                                                                    .toList()
                                                                  ..sort(
                                                                    (a, b) => a.compareTo(b),
                                                                  ))
                                                                .last +
                                                            1)
                                                  ];
                                                  bloc.emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: clinicTreatmentEntity));
                                                }
                                              },
                                              icon: Icon(Icons.add),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ]..addAll(internalSteps),
                                    ));
                              }),
                        ));
                      }
                      return r;
                    }()),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
