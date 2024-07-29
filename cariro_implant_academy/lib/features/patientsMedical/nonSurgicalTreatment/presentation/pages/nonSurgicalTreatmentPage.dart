import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/complainBloc_States.dart';
import 'package:cariro_implant_academy/features/patient/presentation/widgets/calendarWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterProsthesisEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterSurgeryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/presentation/bloc/complicationsBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/presentation/bloc/complicationsBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/presentation/bloc/complicationsBloc_States.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/presentation/pages/ComplicationsAfterSurgeryPage.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/domain/entities/dentalExaminationBaseEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/domain/entities/dentalExaminationEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/entities/nonSurgialTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc_States.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmenDetailsEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc_Events.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../Constants/Controllers.dart';
import '../../../../../Widgets/CIA_DropDown.dart';
import '../../../../../Widgets/CIA_PopUp.dart';
import '../../../../../Widgets/CIA_SecondaryButton.dart';
import '../../../../../Widgets/CIA_TextFormField.dart';
import '../../../../../Widgets/FormTextWidget.dart';
import '../../../../../Widgets/MultiSelectChipWidget.dart';
import '../../../../../core/constants/enums/enums.dart';
import '../../../../../core/injection_contianer.dart';
import '../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import '../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc_States.dart';

class NonSurgicalTreatmentPage extends StatefulWidget {
  NonSurgicalTreatmentPage({Key? key, required this.patientId}) : super(key: key);

  static String routePath = ":id/NonSurgicalTreatment";
  int patientId;

  static String getRouteName({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicNonSurgicalTreatment";
      default:
        return "NonSurgicalTreatment";
    }
  }

  @override
  State<NonSurgicalTreatmentPage> createState() => _NonSurgicalTreatmentPageState();
}

class _NonSurgicalTreatmentPageState extends State<NonSurgicalTreatmentPage> {
  String date = "";

  bool edit = false;
  late NonSurgicalTreatmentBloc bloc;
  late MedicalInfoShellBloc medicalShellBloc;
  late NonSurgicalTreatmentEntity nonSurgicalTreatment;
  late DentalExaminationBaseEntity dentalExaminationEntity;
  List<TreatmentItemEntity> treatmentItems = [];
  List<int>? teeth;

  @override
  void initState() {
    bloc = BlocProvider.of<NonSurgicalTreatmentBloc>(context);
    bloc.add(NonSurgicalTreatmentBloc_GetDataEvent(id: widget.patientId));
    medicalShellBloc = context.read<MedicalInfoShellBloc>();
    medicalShellBloc.add(MedicalInfoShell_ChangeTitleEvent(title: "Non Surgical Treatment"));
    medicalShellBloc.saveChanges = () {
      bloc.add(NonSurgicalTreatmentBloc_SaveDataEvent(
        nonSurgicalTreatmentEntity: nonSurgicalTreatment,
        patientId: widget.patientId,
        dentalExaminationEntity: dentalExaminationEntity,
      ));
    };
  }

  void checkComplications(String treatmentNotes) {
    if (treatmentNotes.toLowerCase().contains("complication")) {
      bloc.emit(NonSurgicalTreatmentBloc_ShowComplications(show: true));
    } else
      bloc.emit(NonSurgicalTreatmentBloc_ShowComplications(show: false));
  }

  @override
  void dispose() {
    if (bloc.isInitialized && medicalShellBloc.allowEdit == true) {
      bloc.add(NonSurgicalTreatmentBloc_SaveDataEvent(
        nonSurgicalTreatmentEntity: nonSurgicalTreatment,
        patientId: widget.patientId,
        dentalExaminationEntity: dentalExaminationEntity,
      ));
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NonSurgicalTreatmentBloc, NonSurgicalTreatmentBloc_States>(
      listener: (context, state) {
        if (state is NonSurgicalTreatmentBloc_DataSavedSuccessfully) bloc.add(NonSurgicalTreatmentBloc_GetDataEvent(id: widget.patientId));
        if (state is NonSurgicalTreatmentBloc_LoadingTreatmentPlanItem)
          CustomLoader.show(context);
        else
          CustomLoader.hide();
        if (state is NonSurgicalTreatmentBloc_DentalExaminationDataLoadedSuccessfully) {
          dentalExaminationEntity = state.dentalExaminationEntity;

          //  bloc.add(NonSurgicalTreatmentBloc_CheckTeethStatusEvent(treatment: nonSurgicalTreatment.treatment??""));
        } else if (state is NonSurgicalTreatmentBloc_CheckingTeethStatusError)
          ShowSnackBar(context, isSuccess: false, message: state.message);
        else if (state is NonSurgicalTreatmentBloc_DataLoadingError)
          ShowSnackBar(context, isSuccess: false, message: state.message);
        else if (state is NonSurgicalTreatmentBloc_DataSavingError)
          ShowSnackBar(context, isSuccess: false, message: state.message);
        else if (state is NonSurgicalTreatmentBloc_LoadingTreatmentPlanItemError)
          ShowSnackBar(context, isSuccess: false, message: state.message);
        else if (state is NonSurgicalTreatmentBloc_AddedPatientReceiptSuccessfully)
          ShowSnackBar(context, isSuccess: true, message: "Receipt updated!");
        else if (state is NonSurgicalTreatmentBloc_AddingPatientReceiptError)
          ShowSnackBar(context, isSuccess: false, message: state.message);
        else if (state is NonSurgicalTreatmentBloc_LoadedTreatmentPlanItemSuccessfully) {
          if (state.data == null) return;
          List<TreatmentDetailsEntity> model = state.data!;
          if (state.action == "Missed") {
            var extractionModel = TreatmentDetailsEntity.getTreatment(
                data: model,
                treatmentItemId: treatmentItems.firstWhere((element) => element.name?.toLowerCase() == "extraction").id!,
                tooth: state.tooth);
            if (extractionModel != null) {
              CIA_ShowPopUpYesNo(
                context: context,
                onSave: () async {
                  bloc.add(NonSurgicalTreatmentBloc_AddPatientReceiptEvent(
                    patientId: widget.patientId,
                    tooth: state.tooth,
                    action: "extraction",
                  ));
                },
                title: "Extraction done at price ${extractionModel!.planPrice!.toString()}?",
              );
            }
          } else if (state.action == "Filled") {
            bool crown = false;
            bool rootCanalTreatment = false;
            bool restoration = false;

            CIA_ShowPopUp(
              context: context,
              onSave: () async {
                if (crown)
                  bloc.add(NonSurgicalTreatmentBloc_AddPatientReceiptEvent(
                    patientId: widget.patientId,
                    tooth: state.tooth,
                    action: "crown",
                  ));
                if (rootCanalTreatment)
                  bloc.add(NonSurgicalTreatmentBloc_AddPatientReceiptEvent(
                    patientId: widget.patientId,
                    tooth: state.tooth,
                    action: "rootCanaltreatment",
                  ));
                if (restoration)
                  bloc.add(NonSurgicalTreatmentBloc_AddPatientReceiptEvent(
                    patientId: widget.patientId,
                    tooth: state.tooth,
                    action: "restoration",
                  ));
              },
              child: Column(
                children: [
                  TreatmentDetailsEntity.getTreatment(
                              data: model,
                              treatmentItemId: treatmentItems.firstWhere((element) => element.name?.toLowerCase() == "crown").id!,
                              tooth: state.tooth) !=
                          null
                      ? Row(
                          children: [
                            FormTextKeyWidget(
                                text:
                                    "Crown at price ${TreatmentDetailsEntity.getTreatment(data: model, treatmentItemId: treatmentItems.firstWhere((element) => element.name?.toLowerCase() == "crown").id!, tooth: state.tooth)!.planPrice!.toString()}"),
                            SizedBox(width: 10),
                            CIA_MultiSelectChipWidget(
                              onChange: (item, isSelected) => crown = item == "Yes" && isSelected,
                              singleSelect: true,
                              labels: [
                                CIA_MultiSelectChipWidgeModel(label: "Yes"),
                                CIA_MultiSelectChipWidgeModel(label: "No", isSelected: true),
                              ],
                            )
                          ],
                        )
                      : SizedBox(),
                  TreatmentDetailsEntity.getTreatment(
                              data: model,
                              treatmentItemId: treatmentItems.firstWhere((element) => element.name?.toLowerCase() == "restoration").id!,
                              tooth: state.tooth) !=
                          null
                      ? Row(
                          children: [
                            FormTextKeyWidget(
                                text:
                                    "Restoration at price ${TreatmentDetailsEntity.getTreatment(data: model, treatmentItemId: treatmentItems.firstWhere((element) => element.name?.toLowerCase() == "restoration").id!, tooth: state.tooth)!.planPrice!.toString()}"),
                            SizedBox(width: 10),
                            CIA_MultiSelectChipWidget(
                              singleSelect: true,
                              onChange: (item, isSelected) => restoration = item == "Yes" && isSelected,
                              labels: [
                                CIA_MultiSelectChipWidgeModel(label: "Yes"),
                                CIA_MultiSelectChipWidgeModel(label: "No", isSelected: true),
                              ],
                            )
                          ],
                        )
                      : SizedBox(),
                  TreatmentDetailsEntity.getTreatment(
                              data: model,
                              treatmentItemId: treatmentItems.firstWhere((element) => element.name?.toLowerCase() == "root canal treatment").id!,
                              tooth: state.tooth) !=
                          null
                      ? Row(
                          children: [
                            FormTextKeyWidget(
                                text:
                                    "Root Canal Treatment at price ${TreatmentDetailsEntity.getTreatment(data: model, treatmentItemId: treatmentItems.firstWhere((element) => element.name?.toLowerCase() == "root canal treatment").id!, tooth: state.tooth)!.planPrice!.toString()}"),
                            SizedBox(width: 10),
                            CIA_MultiSelectChipWidget(
                              singleSelect: true,
                              onChange: (item, isSelected) => rootCanalTreatment = item == "Yes" && isSelected,
                              labels: [
                                CIA_MultiSelectChipWidgeModel(label: "Yes"),
                                CIA_MultiSelectChipWidgeModel(label: "No", isSelected: true),
                              ],
                            )
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            );
          } else if (state.action.toLowerCase() == "scaling") {
            int price = 0;
            CIA_ShowPopUp(
              context: context,
              onSave: () {
                bloc.add(NonSurgicalTreatmentBloc_AddPatientReceiptEvent(
                  patientId: widget.patientId,
                  tooth: 0,
                  action: "scaling",
                ));
              },
              child: CIA_TextFormField(
                label: "Price",
                isNumber: true,
                suffix: "EGP",
                onChange: (value) => price = int.parse(value),
                controller: TextEditingController(
                    text: TreatmentDetailsEntity.getTreatment(
                                data: model,
                                treatmentItemId: treatmentItems.firstWhere((element) => element.name?.toLowerCase() == "scaling").id!,
                                tooth: state.tooth)
                            ?.planPrice
                            ?.toString() ??
                        "0"),
              ),
            );
          }
        }
      },
      buildWhen: (previous, current) =>
          current is NonSurgicalTreatmentBloc_LoadingData ||
          current is NonSurgicalTreatmentBloc_DataLoadedSuccessfully ||
          current is NonSurgicalTreatmentBloc_DataLoadingError,
      builder: (context, state) {
        String error = "";
        if (state is NonSurgicalTreatmentBloc_LoadingData)
          return LoadingWidget();
        else if (state is NonSurgicalTreatmentBloc_DataLoadedSuccessfully) {
          treatmentItems = state.treatmentItems;
          nonSurgicalTreatment = state.nonSurgicalTreatmentEntity;
          medicalShellBloc.emit(MedicalInfoBlocChangeDateState(date: nonSurgicalTreatment.date, data: nonSurgicalTreatment));
          bloc.isInitialized = true;
          return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                FormTextKeyWidget(text: "Next Visit: "),
                FormTextValueWidget(
                    text: nonSurgicalTreatment.nextVisit == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(nonSurgicalTreatment.nextVisit!)),
              ],
            ),
            SizedBox(
              height: 10,
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
                    child: StatefulBuilder(builder: (context, _setState) {
                      var controller = TextEditingController(text: nonSurgicalTreatment.treatment ?? "");

                      return CIA_TextFormField(
                        textInputType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        onChange: (value) {
                          nonSurgicalTreatment.treatment = value;
                          checkComplications(value);
                          bloc.add(NonSurgicalTreatmentBloc_CheckTeethStatusEvent(treatment: value));
                        },
                        label: "Treatment",
                        controller: controller,
                        maxLines: 5,
                      );
                    }),
                  );
                }),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                    onClear: () {
                      nonSurgicalTreatment.supervisorID = null;
                    },
                    asyncUseCase: sl<LoadUsersUseCase>(),
                    searchParams: LoadUsersEnum.supervisors,
                    onSelect: (value) {
                      nonSurgicalTreatment.supervisorID = value.id;
                    },
                    //selectedItem: DropDownDTO(),
                    selectedItem: nonSurgicalTreatment.supervisor ?? BasicNameIdObjectEntity(name: "", id: 0),
                    label: "Supervisor",
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                CIA_SecondaryButton(
                    label: "View History",
                    onTab: () {
                      NonSurgicalTreatmentDataGridSource dataSource = NonSurgicalTreatmentDataGridSource(
                        context: context,
                        bloc: bloc,
                      );
                      bloc.add(NonSurgicalTreatmentBloc_GetAllDataEvent(id: widget.patientId));
                      CIA_ShowPopUp(
                          width: double.maxFinite,
                          context: context,
                          child: Column(
                            children: [
                              FormTextKeyWidget(text: "View History Treatments"),
                              Visibility(
                                  visible: siteController.getRole()!.contains("admin"), child: FormTextValueWidget(text: "Click on note to update")),
                              Expanded(
                                child: BlocConsumer<NonSurgicalTreatmentBloc, NonSurgicalTreatmentBloc_States>(
                                  buildWhen: (previous, current) =>
                                      current is NonSurgicalTreatmentBloc_LoadingAllData ||
                                      current is NonSurgicalTreatmentBloc_AllDataLoadingError ||
                                      current is NonSurgicalTreatmentBloc_AllDataLoadedSuccessfully,
                                  builder: (context, state) {
                                    if (state is NonSurgicalTreatmentBloc_LoadingAllData)
                                      return LoadingWidget();
                                    else if (state is NonSurgicalTreatmentBloc_AllDataLoadingError)
                                      return BigErrorPageWidget(message: state.message);
                                    else if (state is NonSurgicalTreatmentBloc_AllDataLoadedSuccessfully) {
                                      dataSource.updateData(state.nonSurgicalTreatments);
                                      return TableWidget(dataSource: dataSource);
                                    }
                                    return Container();
                                  },
                                  listener: (context, state) {
                                    if (state is NonSurgicalTreatmentBloc_SavingData)
                                      CustomLoader.show(context);
                                    else {
                                      CustomLoader.hide();
                                      if (state is NonSurgicalTreatmentBloc_DataSavingError)
                                        ShowSnackBar(context, isSuccess: false, message: state.message);
                                      else if (state is NonSurgicalTreatmentBloc_DataSavedSuccessfully) {
                                        ShowSnackBar(context, isSuccess: true);
                                        bloc.add(NonSurgicalTreatmentBloc_GetAllDataEvent(id: widget.patientId));
                                      }
                                    }
                                  },
                                ),
                              )
                            ],
                          ));
                    }),
                SizedBox(
                  width: 10,
                ),
                CIA_SecondaryButton(
                    label: "Schedule Next Visit",
                    width: 600,
                    onTab: () async {
                      CIA_ShowPopUp(
                          context: context,
                          width: double.maxFinite,
                          height: 600,
                          title: "Schedule Next Visit",
                          child: CalendarWidget(
                            // dataSource: dataSource,
                            getForDoctor: true,
                            patientID: widget.patientId,
                            onNewVisit: (newVisit) {
                              nonSurgicalTreatment.nextVisit = newVisit.reservationTime;
                              bloc.add(NonSurgicalTreatmentBloc_SaveDataEvent(
                                nonSurgicalTreatmentEntity: nonSurgicalTreatment,
                                dentalExaminationEntity: dentalExaminationEntity,
                                patientId: widget.patientId,
                              ));
                            },
                          ),
                          onSave: () {
                            bloc.add(NonSurgicalTreatmentBloc_GetDataEvent(id: widget.patientId));
                          });
                    }),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
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
                        child: BlocBuilder<NonSurgicalTreatmentBloc, NonSurgicalTreatmentBloc_States>(
                          buildWhen: (previous, current) => current is NonSurgicalTreatmentBloc_TeethStatusLoadedSuccessfully,
                          builder: (context, state) {
                            List<int> containedTeeth = [];
                            if (state is NonSurgicalTreatmentBloc_TeethStatusLoadedSuccessfully) {
                              containedTeeth = state.status;
                              checkComplications(nonSurgicalTreatment.treatment ?? "");

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: nonSurgicalTreatment.treatment?.toLowerCase().contains("scaling") ?? false,
                                    child: CIA_PrimaryButton(
                                        label: "Add Scaling to Receipt",
                                        onTab: () {
                                          bloc.add(NonSurgicalTreatmentBloc_GetPaidTreatmentPlanItemEvent(
                                            patientId: widget.patientId,
                                            tooth: 0,
                                            action: "scaling",
                                          ));
                                        }),
                                  ),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BlocBuilder<NonSurgicalTreatmentBloc, NonSurgicalTreatmentBloc_States>(
                                          buildWhen: (previous, current) => current is NonSurgicalTreatmentBloc_ShowComplications,
                                          builder: (context, state) {
                                            if (state is NonSurgicalTreatmentBloc_ShowComplications && state.show == true)
                                              return Expanded(
                                                child: ComplicationsAfterSurgeryPage(patientId: widget.patientId, enable: true),
                                              );
                                            else
                                              return Container();
                                          },
                                        ),
                                        _buildTeethSuggestion(containedTeeth)
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Container();
                          },
                        ));
                  }),
            ),
            SizedBox(height: 20),
          ]);
        } else if (state is NonSurgicalTreatmentBloc_DataLoadingError) error = state.message;
        return BigErrorPageWidget(message: error);
      },
    );
  }

  _buildTeethSuggestion(List<int> containedTeeth) {
    List<Widget> uu = <Widget>[];
    containedTeeth.forEach((tooth) {
      var currentToothDentalExamination = dentalExaminationEntity.dentalExaminations!.firstWhereOrNull((element) => element.tooth == tooth);
      if (currentToothDentalExamination == null) {
        currentToothDentalExamination = DentalExaminationEntity(tooth: tooth);
        dentalExaminationEntity.dentalExaminations!.add(currentToothDentalExamination);
      }
      List<CIA_MultiSelectChipWidgeModel> tempSelectionModel = [
        CIA_MultiSelectChipWidgeModel(
            label: "Carious", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.carious) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Filled", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.filled) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Missed", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.missed) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Not Sure", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.notSure) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Mobility I", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.mobilityI) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Mobility II", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.mobilityII) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Mobility III", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.mobilityIII) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Hopeless teeth",
            isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.hopelessTeeth) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Implant Placed",
            isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.implantPlaced) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Implant Failed",
            isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.implantFailed) as bool : false),
      ];

      uu.add(FormTextKeyWidget(text: "Do you want to update tooth $tooth?"));
      uu.add(Row(
        children: [
          Expanded(
            child: CIA_MultiSelectChipWidget(
              key: LabeledGlobalKey(tooth.toString()),
              singleSelect: true,
              labels: tempSelectionModel,
              onChange: (value, isSelected) async {
                if (currentToothDentalExamination!.carious!) {
                  currentToothDentalExamination!.previousState = "carious";
                  currentToothDentalExamination.carious = false;
                }
                if (currentToothDentalExamination!.missed!) {
                  currentToothDentalExamination!.previousState = "missed";
                  currentToothDentalExamination.missed = false;
                }
                if (currentToothDentalExamination!.filled!) {
                  currentToothDentalExamination!.previousState = "filled";
                  currentToothDentalExamination.filled = false;
                }
                if (currentToothDentalExamination!.notSure!) {
                  currentToothDentalExamination!.previousState = "notSure";
                  currentToothDentalExamination.notSure = false;
                }
                if (currentToothDentalExamination!.mobilityIII!) {
                  currentToothDentalExamination!.previousState = "mobilityIII";
                  currentToothDentalExamination.mobilityIII = false;
                }
                if (currentToothDentalExamination!.mobilityII!) {
                  currentToothDentalExamination!.previousState = "mobilityII";
                  currentToothDentalExamination.mobilityII = false;
                }
                if (currentToothDentalExamination!.mobilityI!) {
                  currentToothDentalExamination!.previousState = "mobilityI";
                  currentToothDentalExamination.mobilityI = false;
                }
                if (currentToothDentalExamination!.hopelessTeeth!) {
                  currentToothDentalExamination!.previousState = "hopelessteeth";
                  currentToothDentalExamination.hopelessTeeth = false;
                }
                if (currentToothDentalExamination!.implantFailed!) {
                  currentToothDentalExamination!.previousState = "implantFailed";
                  currentToothDentalExamination.implantFailed = false;
                }
                if (currentToothDentalExamination!.implantPlaced!) {
                  currentToothDentalExamination!.previousState = "implantPlaced";
                  currentToothDentalExamination.implantPlaced = false;
                }
                if (isSelected) {
                  currentToothDentalExamination.updateToothStatus(value);
                  if (value == "Missed" || value == "Filled") {
                    bloc.add(NonSurgicalTreatmentBloc_GetPaidTreatmentPlanItemEvent(
                      patientId: widget.patientId,
                      tooth: tooth,
                      action: value,
                    ));
                  }
                }
              },
            ),
          ),
          Visibility(
            visible: currentToothDentalExamination.missed == true,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CIA_SecondaryButton(
                  label: "Intra Arch Spaces",
                  onTab: () {
                    CIA_ShowPopUp(
                        title: "Intra Arch Spaces",
                        context: context,
                        width: 500,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              FormTextValueWidget(text: currentToothDentalExamination!.tooth!.toString()),
                              SizedBox(width: 10),
                              Expanded(
                                key: GlobalKey(),
                                child: CIA_TextFormField(
                                  suffix: "mm",
                                  isNumber: true,
                                  label: "Inter arch space RT",
                                  onChange: (value) {
                                    currentToothDentalExamination!.interarchSpaceRT = int.tryParse(value) ?? 0;
                                  },
                                  controller: TextEditingController(
                                    text: (currentToothDentalExamination.interarchSpaceRT ?? 0).toString(),
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
                                      try {
                                        currentToothDentalExamination!.interarchSpaceLT = int.tryParse(value) ?? 0;
                                      } catch (e, s) {
                                        print(s);
                                      }
                                    },
                                    controller: TextEditingController(
                                      text: (currentToothDentalExamination.interarchSpaceLT ?? 0).toString(),
                                    )),
                              ),
                            ],
                          ),
                        ));
                  }),
            ),
          ),
        ],
      ));
      uu.add(SizedBox(height: 10));
    });

    Widget ss = SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: uu,
      ),
    );
    return Expanded(child: ss);
  }
}
