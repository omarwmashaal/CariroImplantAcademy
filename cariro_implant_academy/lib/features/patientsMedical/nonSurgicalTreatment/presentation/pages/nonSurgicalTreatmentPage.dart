import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/patient/presentation/widgets/calendarWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/domain/entities/dentalExaminationBaseEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/domain/entities/dentalExaminationEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/entities/nonSurgialTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc_States.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc_Events.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../API/LoadinAPI.dart';
import '../../../../../Constants/Controllers.dart';
import '../../../../../Models/VisitsModel.dart';
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
import '../../../treatmentFeature/domain/entities/teethTreatmentPlan.dart';

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

  @override
  void dispose() {
    if (bloc.isInitialized && medicalShellBloc.allowEdit == true) {
      bloc.add(NonSurgicalTreatmentBloc_SaveDataEvent(
        nonSurgicalTreatmentEntity: nonSurgicalTreatment,
        patientId: widget.patientId,
        dentalExaminationEntity: dentalExaminationEntity,
      ));
    }
    //  if (!siteController.disableMedicalEdit.value) {
    //  siteController.disableMedicalEdit.value = true;
    //MedicalAPI.AddPatientNonSurgicalTreatment(widget.patientId, nonSurgicalTreatment);
    //MedicalAPI.UpdatePatientDentalExamination(widget.patientId, tempDentalExamination);
    // }

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
          TeethTreatmentPlanEntity model = state.data!;
          if (state.action == "Missed") {
            if (model.extraction != null) {
              CIA_ShowPopUpYesNo(
                context: context,
                onSave: () async {
                  bloc.add(NonSurgicalTreatmentBloc_AddPatientReceiptEvent(
                    patientId: widget.patientId,
                    tooth: state.tooth,
                    action: "extraction",
                  ));
                },
                title: "Extraction done at price ${model.extraction!.planPrice!.toString()}?",
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
                  model.crown != null
                      ? Row(
                          children: [
                            FormTextKeyWidget(text: "Crown at price ${model.crown!.planPrice!.toString()}"),
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
                  model.restoration != null
                      ? Row(
                          children: [
                            FormTextKeyWidget(text: "Restoration at price ${model.restoration!.planPrice!.toString()}"),
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
                  model.rootCanalTreatment != null
                      ? Row(
                          children: [
                            FormTextKeyWidget(text: "Root Canal Treatment at price ${model.rootCanalTreatment!.planPrice!.toString()}"),
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
            int price  =0;
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
                onChange: (value) =>price = int.parse(value),
                controller: TextEditingController(
                  text:state.data?.scaling?.planPrice?.toString()??"0"
                ),
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

                      return RawKeyboardListener(
                        focusNode: FocusNode(),
                        onKey: (value) {
                          if (value.isKeyPressed(LogicalKeyboardKey.enter)) {
                            controller.text += "\r\n";
                            _setState(() {});
                          }
                        },
                        child: CIA_TextFormField(
                          textInputType: TextInputType.multiline,
                          onChange: (value) {
                            nonSurgicalTreatment.treatment = value;
                            bloc.add(NonSurgicalTreatmentBloc_CheckTeethStatusEvent(treatment: value));
                          },
                          label: "Treatment",
                          controller: controller,
                          maxLines: 5,
                        ),
                      );
                    }),
                  );
                }),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
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
                      CIA_PopUpTreatmentHistory_Table(widget.patientId, context, "View History Treatments", (value) {});
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
                          width: 900,
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
                                  _buildTeethSuggestion(containedTeeth)
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
            label: "Hopeless teeth", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.hopelessTeeth) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Implant Placed", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.implantPlaced) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Implant Failed", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.implantFailed) as bool : false),
      ];

      uu.add(FormTextKeyWidget(text: "Do you want to update tooth $tooth?"));
      uu.add(CIA_MultiSelectChipWidget(
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
