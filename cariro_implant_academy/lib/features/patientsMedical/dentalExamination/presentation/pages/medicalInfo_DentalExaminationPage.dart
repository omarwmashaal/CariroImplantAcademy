import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/presentation/bloc/bloc_constants.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/presentation/bloc/dentalExaminationBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/presentation/bloc/dentalExaminationBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/presentation/bloc/dentalExaminationBloc_States.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/presentaion/bloc/dentalHistoryBloc_States.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc_States.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc_Events.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../Constants/Controllers.dart';
import '../../../../../Widgets/CIA_TagsInputWidget.dart';
import '../../../../../Widgets/CIA_TeethChart.dart';
import '../../../../../Widgets/CIA_TextFormField.dart';
import '../../../../../Widgets/FormTextWidget.dart';
import '../../../../../Widgets/MultiSelectChipWidget.dart';
import '../../../../../core/constants/enums/enums.dart';
import '../../domain/entities/dentalExaminationBaseEntity.dart';
import '../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import '../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc_States.dart';
import '../../domain/entities/dentalExaminationEntity.dart';

class DentalExaminationPage extends StatefulWidget {
  DentalExaminationPage({Key? key, required this.patientId}) : super(key: key);

  static String routePath = ":id/DentalExamination";
  int patientId;
  static String getRouteName({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicDentalExamination";
      default:
        return "DentalExamination";
    }
  }
  @override
  State<DentalExaminationPage> createState() => _PatientDentalExaminationState();
}

class _PatientDentalExaminationState extends State<DentalExaminationPage> {
  List<int> selectedTeeth = [];
  String selectedTooth = "";
  String selectedStatus = "";
  late DentalExaminationBaseEntity dentalExaminationEntity;

  //late Future load;

  @override
  void dispose() {
    if (bloc.isInitialized && medicalShellBloc.allowEdit) {
      bloc.add(DentalExaminationBloc_SaveDataEvent(dentalExaminationEntity: dentalExaminationEntity));
    }

    super.dispose();
  }

  late DentalExaminationBloc bloc;
  late MedicalInfoShellBloc medicalShellBloc;

  @override
  void initState() {
    bloc = BlocProvider.of<DentalExaminationBloc>(context);
    medicalShellBloc = BlocProvider.of<MedicalInfoShellBloc>(context);
    bloc.add(DentalExaminationBloc_GetDataEvent(patientId: widget.patientId));
    medicalShellBloc.add(MedicalInfoShell_ChangeTitleEvent(title: "Dental Examination"));
    medicalShellBloc.saveChanges = (){
      bloc.add(DentalExaminationBloc_SaveDataEvent(dentalExaminationEntity: dentalExaminationEntity));
    };
    // load = MedicalAPI.GetPatientDentalExamination(widget.patientId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DentalExaminationBloc, DentalExaminationBloc_States>(
      buildWhen: (previous, current) =>
      current is DentalExaminationBloc_LoadingDataState ||
          current is DentalExaminationBloc_LoadedSuccessfullyState ||
          current is DentalExaminationBloc_ErrorState
      ,
      builder: (context, state) {
        if (state is DentalExaminationBloc_LoadingDataState)
          return LoadingWidget();
        else if (state is DentalExaminationBloc_LoadedSuccessfullyState)
        {
          dentalExaminationEntity = state.dentalExaminationEntity;
          medicalShellBloc.emit(MedicalInfoBlocChangeDateState(date: state.dentalExaminationEntity.date,data: dentalExaminationEntity));

          bloc.isInitialized = true;
          return ListView(
            shrinkWrap: false,
            children: [
              FocusTraversalGroup(
                policy: OrderedTraversalPolicy(),
                child: BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                  bloc: medicalShellBloc,
                  buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
                  builder: (context, stateShell) {
                    return AbsorbPointer(
                      absorbing: () {
                        if (stateShell is MedicalInfoBlocChangeViewEditState) {
                          //   edit = stateShell.edit;
                          return !stateShell.edit;
                        } else {
                          // edit = false;
                          return true;
                        }
                      }(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          BlocBuilder<DentalExaminationBloc, DentalExaminationBloc_States>(
                              buildWhen: (previous, current) => current is DentalExaminationBloc_TeethStatusChanged,
                              builder: (context, state) {
                                return CIA_TeethChart(
                                  onChange: (selectedTeethList) => selectedTeeth = selectedTeethList,
                                );
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<DentalExaminationBloc, DentalExaminationBloc_States>(
                              buildWhen: (previous, current) => current is DentalExaminationBloc_TeethStatusChanged,
                              builder: (context, state) {
                                return CIA_MultiSelectChipWidget(
                                  key: GlobalKey(),
                                  onChange: (value, isSelected) {
                                    if (dentalExaminationEntity.dentalExaminations == null) dentalExaminationEntity.dentalExaminations = [];
                                    for (var tooth in selectedTeeth) {
                                      var t = dentalExaminationEntity.dentalExaminations!.firstWhereOrNull((element) => element.tooth.toString() == tooth);
                                      if (t == null) {
                                        dentalExaminationEntity.dentalExaminations!.add(DentalExaminationEntity(tooth: tooth));
                                      }
                                    }
                                    if (isSelected) {
                                      if (value == "Mobility") {
                                        bloc.emit(DentalExaminationBloc_MobilityVisiblityChangedState(show: true));
                                      } else {
                                        selectedTeeth.forEach((element) {
                                          dentalExaminationEntity.dentalExaminations!.firstWhere((x) => x.tooth == element).updateToothStatus(value);
                                        });
                                        selectedTeeth.clear();
                                        try {
                                          TeethStatus teethStatus = getEnumFromName<TeethStatus>(TeethStatus.values, value);
                                          bloc.emit(DentalExaminationBloc_TeethStatusChanged(teethStatus: teethStatus));
                                        } on Exception catch (e) {}
                                      }
                                    }
                                  },
                                  singleSelect: true,
                                  labels: [
                                    CIA_MultiSelectChipWidgeModel(
                                      label: "Carious",
                                    ),
                                    CIA_MultiSelectChipWidgeModel(
                                      label: "Filled",
                                    ),
                                    CIA_MultiSelectChipWidgeModel(
                                      label: "Missed",
                                    ),
                                    CIA_MultiSelectChipWidgeModel(
                                      label: "Not Sure",
                                    ),
                                    CIA_MultiSelectChipWidgeModel(
                                      label: "Mobility",
                                    ),
                                    CIA_MultiSelectChipWidgeModel(
                                      label: "Hopeless teeth",
                                    ),
                                    CIA_MultiSelectChipWidgeModel(
                                      label: "Implant Placed",
                                    ),
                                    CIA_MultiSelectChipWidgeModel(
                                      label: "Implant Failed",
                                    ),
                                  ],
                                );
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<DentalExaminationBloc, DentalExaminationBloc_States>(
                              buildWhen: (previous, current) => current is DentalExaminationBloc_MobilityVisiblityChangedState,
                              builder: (context, state) {
                                bool show = false;
                                if (state is DentalExaminationBloc_MobilityVisiblityChangedState) show = state.show;
                                return Visibility(
                                  visible: show,
                                  child: CIA_MultiSelectChipWidget(
                                    key: GlobalKey(),
                                    onChange: (value, isSelected) {
                                      if (isSelected) {
                                        if (value == "I")
                                          selectedTeeth.forEach((element) {
                                            dentalExaminationEntity.dentalExaminations!.firstWhere((x) => x.tooth == element).updateToothStatus("Mobility I");
                                          });
                                        else if (value == "II")
                                          selectedTeeth.forEach((element) {
                                            dentalExaminationEntity.dentalExaminations!.firstWhere((x) => x.tooth == element).updateToothStatus("Mobility II");
                                          });
                                        else if (value == "III")
                                          selectedTeeth.forEach((element) {
                                            dentalExaminationEntity.dentalExaminations!.firstWhere((x) => x.tooth == element).updateToothStatus("Mobility III");
                                          });
                                        selectedTeeth.clear();

                                        bloc.emit(DentalExaminationBloc_MobilityVisiblityChangedState(show: false));
                                        bloc.emit(DentalExaminationBloc_TeethStatusChanged(teethStatus: TeethStatus.mobility));
                                      }
                                    },
                                    singleSelect: true,
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(label: "I", isSelected: false),
                                      CIA_MultiSelectChipWidgeModel(label: "II", isSelected: false),
                                      CIA_MultiSelectChipWidgeModel(label: "III", isSelected: false),
                                    ],
                                  ),
                                );
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<DentalExaminationBloc, DentalExaminationBloc_States>(
                              buildWhen: (previous, current) => current is DentalExaminationBloc_TeethStatusChanged,
                              builder: (context, state) {
                                return CIA_TagsInputWidget(
                                  dynamicVisibility: true,
                                  key: GlobalKey(),
                                  label: "Carious",
                                  initialValue: dentalExaminationEntity.dentalExaminations!
                                      .where((element) => element.carious == true)
                                      .toList()
                                      .map((e) => e.tooth.toString())
                                      .toList(),
                                  strikeValues: dentalExaminationEntity.dentalExaminations!.where((element) => element.previousState == "carious") != null
                                      ? dentalExaminationEntity.dentalExaminations!
                                          .where((element) => element.previousState == "carious")
                                          .toList()
                                          .map((e) => e.tooth.toString())
                                          .toList()
                                      : null,
                                  onDelete: (value) {
                                    dentalExaminationEntity.dentalExaminations!.firstWhere((element) => element.tooth.toString() == value).carious = false;
                                    setState(() {});
                                  },
                                );
                              }),
                          BlocBuilder<DentalExaminationBloc, DentalExaminationBloc_States>(
                              buildWhen: (previous, current) => current is DentalExaminationBloc_TeethStatusChanged,
                              builder: (context, state) {
                                return CIA_TagsInputWidget(
                                  dynamicVisibility: true,
                                  key: GlobalKey(),
                                  label: "Filled",
                                  initialValue: dentalExaminationEntity.dentalExaminations!
                                      .where((element) => element.filled == true)
                                      .toList()
                                      .map((e) => e.tooth.toString())
                                      .toList(),
                                  strikeValues: dentalExaminationEntity.dentalExaminations!.where((element) => element.previousState == "filled") != null
                                      ? dentalExaminationEntity.dentalExaminations!
                                          .where((element) => element.previousState == "filled")
                                          .toList()
                                          .map((e) => e.tooth.toString())
                                          .toList()
                                      : null,
                                  onDelete: (value) {
                                    dentalExaminationEntity.dentalExaminations!.firstWhere((element) => element.tooth.toString() == value).filled = false;
                                    setState(() {});
                                  },
                                );
                              }),
                          BlocBuilder<DentalExaminationBloc, DentalExaminationBloc_States>(
                              buildWhen: (previous, current) => current is DentalExaminationBloc_TeethStatusChanged,
                              builder: (context, state) {
                                return CIA_TagsInputWidget(
                                  dynamicVisibility: true,
                                  key: GlobalKey(),
                                  label: "Missed",
                                  initialValue: dentalExaminationEntity.dentalExaminations!
                                      .where((element) => element.missed == true)
                                      .toList()
                                      .map((e) => e.tooth.toString())
                                      .toList(),
                                  strikeValues: dentalExaminationEntity.dentalExaminations!.where((element) => element.previousState == "missed") != null
                                      ? dentalExaminationEntity.dentalExaminations!
                                          .where((element) => element.previousState == "missed")
                                          .toList()
                                          .map((e) => e.tooth.toString())
                                          .toList()
                                      : null,
                                  onDelete: (value) {
                                    dentalExaminationEntity.dentalExaminations!.firstWhere((element) => element.tooth.toString() == value).missed = false;
                                    setState(() {});
                                  },
                                );
                              }),
                          BlocBuilder<DentalExaminationBloc, DentalExaminationBloc_States>(
                              buildWhen: (previous, current) => current is DentalExaminationBloc_TeethStatusChanged,
                              builder: (context, state) {
                                return CIA_TagsInputWidget(
                                  dynamicVisibility: true,
                                  key: GlobalKey(),
                                  label: "Not Sure",
                                  initialValue: dentalExaminationEntity.dentalExaminations!
                                      .where((element) => element.notSure == true)
                                      .toList()
                                      .map((e) => e.tooth.toString())
                                      .toList(),
                                  strikeValues: dentalExaminationEntity.dentalExaminations!.where((element) => element.previousState == "notSure") != null
                                      ? dentalExaminationEntity.dentalExaminations!
                                          .where((element) => element.previousState == "notSure")
                                          .toList()
                                          .map((e) => e.tooth.toString())
                                          .toList()
                                      : null,
                                  onDelete: (value) {
                                    dentalExaminationEntity.dentalExaminations!.firstWhere((element) => element.tooth.toString() == value).notSure = false;
                                    setState(() {});
                                  },
                                );
                              }),
                          Row(
                            children: [
                              Flexible(
                                key: GlobalKey(),
                                child: BlocBuilder<DentalExaminationBloc, DentalExaminationBloc_States>(
                                    buildWhen: (previous, current) => current is DentalExaminationBloc_TeethStatusChanged,
                                    builder: (context, state) {
                                      return CIA_TagsInputWidget(
                                        dynamicVisibility: true,
                                        key: GlobalKey(),
                                        label: "Mobility I",
                                        initialValue: dentalExaminationEntity.dentalExaminations!
                                            .where((element) => element.mobilityI == true)
                                            .toList()
                                            .map((e) => e.tooth.toString())
                                            .toList(),
                                        strikeValues:
                                            dentalExaminationEntity.dentalExaminations!.where((element) => element.previousState == "mobilityI") != null
                                                ? dentalExaminationEntity.dentalExaminations!
                                                    .where((element) => element.previousState == "mobilityI")
                                                    .toList()
                                                    .map((e) => e.tooth.toString())
                                                    .toList()
                                                : null,
                                        onDelete: (value) {
                                          dentalExaminationEntity.dentalExaminations!.firstWhere((element) => element.tooth.toString() == value).mobilityI =
                                              false;
                                          setState(() {});
                                        },
                                      );
                                    }),
                              ),
                              SizedBox(
                                width: dentalExaminationEntity.dentalExaminations != null &&
                                        dentalExaminationEntity.dentalExaminations!.where((element) => element.mobilityI == true).isNotEmpty
                                    ? 10
                                    : 0,
                              ),
                              Flexible(
                                child: BlocBuilder<DentalExaminationBloc, DentalExaminationBloc_States>(
                                    buildWhen: (previous, current) => current is DentalExaminationBloc_TeethStatusChanged,
                                    builder: (context, state) {
                                      return CIA_TagsInputWidget(
                                        dynamicVisibility: true,
                                        key: GlobalKey(),
                                        label: "Mobility II",
                                        initialValue: dentalExaminationEntity.dentalExaminations!
                                            .where((element) => element.mobilityII == true)
                                            .toList()
                                            .map((e) => e.tooth.toString())
                                            .toList(),
                                        strikeValues:
                                            dentalExaminationEntity.dentalExaminations!.where((element) => element.previousState == "mobilityII") != null
                                                ? dentalExaminationEntity.dentalExaminations!
                                                    .where((element) => element.previousState == "mobilityII")
                                                    .toList()
                                                    .map((e) => e.tooth.toString())
                                                    .toList()
                                                : null,
                                        onDelete: (value) {
                                          dentalExaminationEntity.dentalExaminations!.firstWhere((element) => element.tooth.toString() == value).mobilityII =
                                              false;
                                          setState(() {});
                                        },
                                      );
                                    }),
                              ),
                              SizedBox(
                                width: dentalExaminationEntity.dentalExaminations != null &&(
                                    dentalExaminationEntity.dentalExaminations!.where((element) => element.mobilityII == true).isNotEmpty ||
                                    dentalExaminationEntity.dentalExaminations!.where((element) => element.mobilityI == true).isNotEmpty)

                                    ? 10
                                    : 0,
                              ),
                              Flexible(
                                key: GlobalKey(),
                                child: BlocBuilder<DentalExaminationBloc, DentalExaminationBloc_States>(
                                    buildWhen: (previous, current) => current is DentalExaminationBloc_TeethStatusChanged,
                                    builder: (context, state) {
                                      return CIA_TagsInputWidget(
                                        dynamicVisibility: true,
                                        key: GlobalKey(),
                                        label: "Mobility III",
                                        initialValue: dentalExaminationEntity.dentalExaminations!
                                            .where((element) => element.mobilityIII == true)
                                            .toList()
                                            .map((e) => e.tooth.toString())
                                            .toList(),
                                        strikeValues:
                                            dentalExaminationEntity.dentalExaminations!.where((element) => element.previousState == "mobilityIII") != null
                                                ? dentalExaminationEntity.dentalExaminations!
                                                    .where((element) => element.previousState == "mobilityIII")
                                                    .toList()
                                                    .map((e) => e.tooth.toString())
                                                    .toList()
                                                : null,
                                        onDelete: (value) {
                                          dentalExaminationEntity.dentalExaminations!.firstWhere((element) => element.tooth.toString() == value).mobilityIII =
                                              false;
                                        },
                                      );
                                    }),
                              ),
                            ],
                          ),
                          BlocBuilder<DentalExaminationBloc, DentalExaminationBloc_States>(
                              buildWhen: (previous, current) => current is DentalExaminationBloc_TeethStatusChanged,
                              builder: (context, state) {
                                return CIA_TagsInputWidget(
                                  dynamicVisibility: true,
                                  key: GlobalKey(),
                                  label: "Hopeless teeth",
                                  initialValue: dentalExaminationEntity.dentalExaminations!
                                      .where((element) => element.hopelessTeeth == true)
                                      .toList()
                                      .map((e) => e.tooth.toString())
                                      .toList(),
                                  strikeValues: dentalExaminationEntity.dentalExaminations!.where((element) => element.previousState == "hopelessteeth") != null
                                      ? dentalExaminationEntity.dentalExaminations!
                                          .where((element) => element.previousState == "hopelessteeth")
                                          .toList()
                                          .map((e) => e.tooth.toString())
                                          .toList()
                                      : null,
                                  onDelete: (value) {
                                    dentalExaminationEntity.dentalExaminations!.firstWhere((element) => element.tooth.toString() == value).hopelessTeeth =
                                        false;
                                    setState(() {});
                                  },
                                );
                              }),
                          BlocBuilder<DentalExaminationBloc, DentalExaminationBloc_States>(
                              buildWhen: (previous, current) => current is DentalExaminationBloc_TeethStatusChanged,
                              builder: (context, state) {
                                return CIA_TagsInputWidget(
                                  dynamicVisibility: true,
                                  key: GlobalKey(),
                                  label: "Implant Placed",
                                  initialValue: dentalExaminationEntity.dentalExaminations!
                                      .where((element) => element.implantPlaced == true)
                                      .toList()
                                      .map((e) => e.tooth.toString())
                                      .toList(),
                                  strikeValues: dentalExaminationEntity.dentalExaminations!.where((element) => element.previousState == "implantPlaced") != null
                                      ? dentalExaminationEntity.dentalExaminations!
                                          .where((element) => element.previousState == "implantPlaced")
                                          .toList()
                                          .map((e) => e.tooth.toString())
                                          .toList()
                                      : null,
                                  onDelete: (value) {
                                    dentalExaminationEntity.dentalExaminations!.firstWhere((element) => element.tooth.toString() == value).implantPlaced =
                                        false;
                                    setState(() {});
                                  },
                                );
                              }),
                          BlocBuilder<DentalExaminationBloc, DentalExaminationBloc_States>(
                              buildWhen: (previous, current) => current is DentalExaminationBloc_TeethStatusChanged,
                              builder: (context, state) {
                                return CIA_TagsInputWidget(
                                  dynamicVisibility: true,
                                  key: GlobalKey(),
                                  label: "Implant Failed",
                                  initialValue: dentalExaminationEntity.dentalExaminations!
                                      .where((element) => element.implantFailed == true)
                                      .toList()
                                      .map((e) => e.tooth.toString())
                                      .toList(),
                                  strikeValues: dentalExaminationEntity.dentalExaminations!.where((element) => element.previousState == "implantFailed") != null
                                      ? dentalExaminationEntity.dentalExaminations!
                                          .where((element) => element.previousState == "implantFailed")
                                          .toList()
                                          .map((e) => e.tooth.toString())
                                          .toList()
                                      : null,
                                  onDelete: (value) {
                                    dentalExaminationEntity.dentalExaminations!.firstWhere((element) => element.tooth.toString() == value).implantFailed =
                                        false;
                                    setState(() {});
                                  },
                                );
                              }),
                          Row(
                            children: [
                              Expanded(
                                key: GlobalKey(),
                                child: CIA_TextFormField(
                                  suffix: "mm",
                                  isNumber: true,
                                  label: "Inter arch space RT",
                                  onChange: (value) {
                                    dentalExaminationEntity.interarchSpaceRT = int.parse(value);
                                  },
                                  controller: TextEditingController(
                                    text: (dentalExaminationEntity.interarchSpaceRT ?? 0).toString(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                key: GlobalKey(),
                                child: CIA_TextFormField(
                                    suffix: "mm",
                                    isNumber: true,
                                    label: "Inter arch space LT",
                                    onChange: (value) {
                                      dentalExaminationEntity.interarchSpaceLT = int.parse(value);
                                    },
                                    controller: TextEditingController(
                                      text: (dentalExaminationEntity.interarchSpaceLT ?? 0).toString(),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FormTextKeyWidget(text: "Oral Hygiene Rating"),
                          SizedBox(
                            height: 10,
                          ),
                          CIA_MultiSelectChipWidget(
                            singleSelect: true,
                            onChange: (item, isSelected) {
                              if (item == "Bad")
                                dentalExaminationEntity.oralHygieneRating = EnumOralHygieneRating.BadHygiene;
                              else if (item == "Fair")
                                dentalExaminationEntity.oralHygieneRating = EnumOralHygieneRating.FairHygiene;
                              else if (item == "Good")
                                dentalExaminationEntity.oralHygieneRating = EnumOralHygieneRating.GoodHygiene;
                              else if (item == "Excellent") dentalExaminationEntity.oralHygieneRating = EnumOralHygieneRating.ExcellentHygiene;
                            },
                            labels: [
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Bad",
                                  selectedColor: Colors.red,
                                  isSelected: dentalExaminationEntity.oralHygieneRating == EnumOralHygieneRating.BadHygiene),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Fair",
                                  selectedColor: Colors.orange,
                                  isSelected: dentalExaminationEntity.oralHygieneRating == EnumOralHygieneRating.FairHygiene),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Good", isSelected: dentalExaminationEntity.oralHygieneRating == EnumOralHygieneRating.GoodHygiene),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Excellent", isSelected: dentalExaminationEntity.oralHygieneRating == EnumOralHygieneRating.ExcellentHygiene),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CIA_TextFormField(
                              label: "Operator Implant Notes",
                              onChange: (value) {
                                dentalExaminationEntity.operatorImplantNotes = value;
                              },
                              controller: TextEditingController(text: dentalExaminationEntity.operatorImplantNotes ?? "")),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        else if(state is DentalExaminationBloc_ErrorState)
        return BigErrorPageWidget(message: state.message);
        return Container();
      },
      listener: (context, state) {
        if(state is DentalExaminationBloc_SavedDataSuccessfullyState)
          bloc.add(DentalExaminationBloc_GetDataEvent(patientId: widget.patientId));

        // if(state is DentalHistoryBloc_SavingDataState)
        //   context.l
      },
    );
  }
}
