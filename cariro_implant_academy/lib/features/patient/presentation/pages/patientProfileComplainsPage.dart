import 'dart:convert';
import 'dart:typed_data';

import 'package:cariro_implant_academy/API/LoadinAPI.dart';
import 'package:cariro_implant_academy/API/MedicalAPI.dart';
import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/API/UserAPI.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/NonSurgicalTreatment.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/Horizontal_RadioButtons.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:cariro_implant_academy/Widgets/Title.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/complainEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/complainBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/complainBloc_Events.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/complainBloc_States.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/entities/nonSurgialTreatmentEntity.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Constants/Controllers.dart';
import '../../../../Controllers/SiteController.dart';
import '../../../../Widgets/CIA_PopUp.dart';
import '../../../../Widgets/SnackBar.dart';
import '../../../../core/constants/enums/enums.dart';
import '../../../../core/injection_contianer.dart';

class PatientProfileComplainsPage extends StatefulWidget {
  PatientProfileComplainsPage({Key? key, required this.patientId}) : super(key: key);
  int patientId;

  static String getPath(String id) {
    return "/Patients/Patient/$id/Complains";
  }

  static String routeName = "Complains";
   static String routeNameClinic = "ClinicComplains";
  static String routePath = "Patients/:id/Complains";

  @override
  State<PatientProfileComplainsPage> createState() => _PatientProfileComplainsPageState();
}

class _PatientProfileComplainsPageState extends State<PatientProfileComplainsPage> {
  PatientInfoEntity? patient;
  List<ComplainsEntity> complains = [];
  List<NonSurgicalTreatmentEntity> treatments = [];
  late ComplainsBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ComplainsBloc>(context);
    bloc.add(ComplainsBloc_GetComplainsEvent(patientId: widget.patientId));
  }

  @override
  Widget build(BuildContext context) {
    ComplainsEntity newComplain = ComplainsEntity(patientID: widget.patientId);
    return Column(
      children: [
        TitleWidget(
          title: "Complains",
          showBackButton: true,
        ),
        SizedBox(
          height: 10,
        ),
        CIA_TextFormField(
          label: "New Complain",
          controller: TextEditingController(),
          onChange: (v) => newComplain.comment = v,
          maxLines: 5,
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<ComplainsBloc, ComplainsBloc_States>(
          buildWhen: (previous, current) =>
          current is ComplainsBloc_LoadingDataSuccessState ,
          builder: (context, state) {
            if (state is ComplainsBloc_LoadingDataSuccessState) {
              patient = state.patient??patient;
             // complains = state.complains;
              treatments = state.nonSurgicalTreatments??treatments;
              return Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Entered By: "),
                        FormTextValueWidget(secondaryInfo: true, smallFont: true, text: siteController.getUserName()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Date: "),
                        FormTextValueWidget(secondaryInfo: true, smallFont: true, text: DateFormat("dd-MM-yyyy hh:mm a").format(DateTime.now()).toString()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Last Supervisor: "),
                        FormTextValueWidget(secondaryInfo: true, smallFont: true, text: treatments.isEmpty ? "" : treatments.first.supervisor?.name??""),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Last Doctor: "),
                        FormTextValueWidget(secondaryInfo: true, smallFont: true, text: treatments.isEmpty ? "" : treatments.first.operator?.name??""),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                      onSelect: (e) => newComplain.mentionedDoctorId = e.id,
                      label: "Mentioned Doctor",
                      asyncUseCase: sl<LoadUsersUseCase>(),
                      searchParams: LoadUsersEnum.instructorsAndAssistants,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CIA_PrimaryButton(
                      label: "Add Complain",
                      onTab: () => bloc.add(ComplainsBloc_AddComplainEvent(complainsEntity: newComplain)),
                    ),
                  ),
                ],
              );
            }


            return Container();
          },

        ),

        SizedBox(
          height: 30,
        ),
        BlocConsumer<ComplainsBloc, ComplainsBloc_States>(
          buildWhen: (previous, current) =>
          current is ComplainsBloc_LoadingDataSuccessState ||
              current is ComplainsBloc_LoadingDataState ||
              current is ComplainsBloc_LoadingDataErrorState,
          builder: (context, state) {
            if (state is ComplainsBloc_LoadingDataSuccessState) {
              patient = state.patient??patient;
              complains = state.complains;
              treatments = state.nonSurgicalTreatments??treatments;
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: complains
                        .map(
                          (e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  e.comment ?? "",
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "Notes: " + (e.notes ?? ""),
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  e.status == EnumComplainStatus.Untouched
                                      ? CIA_SecondaryButton(
                                    label: "Start working on complain",
                                    onTab: () => bloc.add(ComplainsBloc_InqueueComplainEvent(complainId: e.id!)),
                                  )
                                      : e.status == EnumComplainStatus.InQueue
                                      ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      CIA_SecondaryButton(
                                        label: "Update Notes",
                                        onTab: () async {
                                          CIA_ShowPopUp(
                                            context: context,
                                            onSave: () => bloc.add(ComplainsBloc_UpdateComplainNotesEvent(complainId: e.id!, notes: e.notes!)),
                                            child: CIA_TextFormField(
                                              label: "Notes",
                                              controller: TextEditingController(text: e.notes??""),
                                              onChange: (v) => e.notes = v,
                                              maxLines: 5,
                                            ),
                                          );
                                        },
                                      ),
                                      CIA_PrimaryButton(
                                        label: "Resolve",
                                        isLong: true,
                                        onTab: () => bloc.add(ComplainsBloc_ResolveComplainEvent(complainId: e.id!)),
                                      ),
                                    ],
                                  )
                                      : RoundCheckBox(
                                    onTap: e.status == EnumComplainStatus.Resolved!
                                        ? null
                                        : (value) => bloc.add(ComplainsBloc_ResolveComplainEvent(complainId: e.id!)),
                                    size: 30,
                                    disabledColor: Colors.green,
                                    checkedColor: Colors.green,
                                    borderColor: Colors.red,
                                    isRound: true,
                                    isChecked: e.status == EnumComplainStatus.Resolved,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Entered By: "),
                                    FormTextValueWidget(secondaryInfo: true, smallFont: true, text: e.entryBy?.name??""),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Date: "),
                                    FormTextValueWidget(
                                        secondaryInfo: true,
                                        smallFont: true,
                                        text: e.entryTime == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(e.entryTime!)),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Last Supervisor: "),
                                    FormTextValueWidget(secondaryInfo: true, smallFont: true, text: e.lastSupervisor?.name??""),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Last Doctor: "),
                                    FormTextValueWidget(secondaryInfo: true, smallFont: true, text: e.lastDoctor?.name??""),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Mentioned Doctor: "),
                                    FormTextValueWidget(secondaryInfo: true, smallFont: true, text: e.mentionedDoctor?.name??""),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    FormTextKeyWidget(secondaryInfo: true, smallFont: true, text: "Resolved By: "),
                                    FormTextValueWidget(secondaryInfo: true, smallFont: true, text: e.resolvedBy?.name??""),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ),
                              Expanded(child: SizedBox())
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    )
                        .toList(),
                  ),
                ),
              );
            }
            else if (state is ComplainsBloc_LoadingDataErrorState)
              return BigErrorPageWidget(message: state.message);
            else if(state is ComplainsBloc_LoadingDataState)
              return LoadingWidget();

            return Container();
          },
          listener: (context, state) {
            if(state is ComplainsBloc_ProcessingDataSuccessState) {
              ShowSnackBar(context, isSuccess: true);
              bloc.add(ComplainsBloc_GetComplainsEvent(patientId: widget.patientId));
            } else if(state is ComplainsBloc_ProcessingDataErrorState)
              ShowSnackBar(context, isSuccess: false,message: state.message);
            else if(state is ComplainsBloc_LoadingDataSuccessState)
              CustomLoader.hide();
            else if (state is ComplainsBloc_ProcessingDataState)
              CustomLoader.show(context);
          },
        )
      ],
    )
    ;

  }
}
