import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/visitEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getVisitsUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/updateVisit.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientVisitsBloc_Events.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientVisitsBloc_States.dart';
import 'package:cariro_implant_academy/features/patient/presentation/widgets/timePickerTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/presentation/widgets/CIA_GestureWidget.dart';
import '../../domain/usecases/getPatientDataUseCase.dart';
import '../../domain/usecases/patientEntersClinicUseCase.dart';
import '../../domain/usecases/patientLeavesClinicUseCase.dart';
import '../../domain/usecases/patientVisitsUseCase.dart';

class PatientVisitsBloc extends Bloc<PatientVisitsBloc_Events, PatientVisitsBloc_States> {
  final GetVisitsUseCase getVisitsUseCase;
  final GetPatientDataUseCase getPatientDataUseCase;
  final PatientVisitsUseCase patientVisitsUseCase;
  final PatientLeavesClinicUseCase patientLeavesClinicUseCase;
  final PatientEntersClinicUseCase patientEntersClinicUseCase;
  final UpdateVisitUseCase updateVisitUseCase;

  PatientVisitsBloc({
    required this.getVisitsUseCase,
    required this.getPatientDataUseCase,
    required this.patientEntersClinicUseCase,
    required this.patientLeavesClinicUseCase,
    required this.patientVisitsUseCase,
    required this.updateVisitUseCase,
  }) : super(PatientVisitsBloc_LoadingVisitsState()) {
    on<PatientVisitsBloc_GetVisitsEvent>(
      (event, emit) async {
        emit(PatientVisitsBloc_LoadingVisitsState());
        final result = await getVisitsUseCase(event.params);
        result.fold(
          (l) => emit(PatientVisitsBloc_LoadingErrorState(message: l.message ?? "")),
          (r) => emit(PatientVisitsBloc_LoadedVisitsSuccessfullyState(visits: r)),
        );
        if (event.params.patientId != null)
          await getPatientDataUseCase(event.params.patientId!).then((value) => value.fold(
                (l) => null,
                (r) => emit(PatientVisitsBloc_LoadedPatientDataSuccessfullyState(data: r)),
              ));
      },
    );
    on<PatientVisitsBloc_GetPatientDataEvent>(
      (event, emit) async {
        final result = await getPatientDataUseCase(event.id);
        result.fold(
          (l) => null,
          (r) => emit(PatientVisitsBloc_LoadedPatientDataSuccessfullyState(data: r)),
        );
      },
    );
    on<PatientVisitsBloc_PatientVisitsEvent>(
      (event, emit) async {
        final result = await patientVisitsUseCase(event.id);
        result.fold(
          (l) => emit(PatientVisitsBloc_VisitProcedureErrorState(message: l.message ?? "")),
          (r) => emit(PatientVisitsBloc_VisitProcedureSuccessState()),
        );
      },
    );
    on<PatientVisitsBloc_PatientEntersClinicEvent>(
      (event, emit) async {
        final result = await patientEntersClinicUseCase(event.params);
        result.fold(
          (l) => emit(PatientVisitsBloc_VisitProcedureErrorState(message: l.message ?? "")),
          (r) => emit(PatientVisitsBloc_VisitProcedureSuccessState()),
        );
      },
    );
    on<PatientVisitsBloc_PatientLeavesClinicEvent>(
      (event, emit) async {
        final result = await patientLeavesClinicUseCase(event.id);
        result.fold(
          (l) => emit(PatientVisitsBloc_VisitProcedureErrorState(message: l.message ?? "")),
          (r) {
            emit(PatientVisitsBloc_LeftSuccessState());
            emit(PatientVisitsBloc_VisitProcedureSuccessState());
          },
        );
      },
    );
    on<PatientVisitsBloc_UpdateVisitsEvent>(
      (event, emit) async {
        final result = await updateVisitUseCase(event.params);
        result.fold(
          (l) => emit(PatientVisitsBloc_VisitProcedureErrorState(message: l.message ?? "")),
          (r) {
            emit(PatientVisitsBloc_VisitProcedureSuccessState());
          },
        );
      },
    );
  }
}

class VisitDataSource extends DataGridSource {
  List<VisitEntity> models = <VisitEntity>[];
  PatientVisitsBloc bloc;
  bool sessions;
  BuildContext context;
  List<String> columns = [
    "id",
    "Patient",
    "Status",
    "Reservation Time",
    "Real Visit Time",
    "Enters Clinic Time",
    "Leave Time",
    "Duration",
    "Doctor Name",
    "Treatment",
  ];

  /// Creates the visit data source class with required details.
  VisitDataSource({this.sessions = false, required this.context, required this.bloc}) {
    init();
  }

  init() {
    if (sessions) {
      columns = [
        "id",
        "Patient",
        //   "Status",
        //  "Reservation Time",
        "Real Visit Time",
        "Enters Clinic Time",
        "Leave Time",
        "Duration",
        "Doctor Name",
        "Treatment",
      ];
      _visitData = models
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(columnName: 'id', value: e.secondaryId),
                DataGridCell<String>(columnName: 'Patient', value: e.patientName ?? ""),
                // DataGridCell<String>(columnName: 'Status', value: e.status??""),
                DataGridCell<DateTime>(columnName: 'Reservation Time', value: e.reservationTime),
                DataGridCell<DateTime>(columnName: 'Real Visit Time', value: e.realVisitTime),
                DataGridCell<DateTime>(columnName: 'Enters Clinic Time', value: e.entersClinicTime),
                DataGridCell<DateTime>(columnName: 'Leave Time', value: e.leaveTime),
                DataGridCell<String>(columnName: 'Duration', value: e.duration ?? ""),
                DataGridCell<String>(columnName: 'Doctor Name', value: e.doctorName ?? ""),
                DataGridCell<Widget>(
                    columnName: 'Treatment',
                    value: CIA_GestureWidget(
                      child: Text(e.treatment ?? ""),
                      onTap: () => CIA_ShowPopUp(context: context, title: "Treatment", child: Text(e.treatment ?? "")),
                    )),
              ]))
          .toList();
    } else {
      columns = [
        "id",
        "Patient",
        "Status",
        "Reservation Time",
        "Real Visit Time",
        "Enters Clinic Time",
        "Leave Time",
        "Duration",
        "Doctor Name",
        "Treatment",
      ];
      // if (siteController.getRole()!.contains("admin"))
      _visitData = models
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(columnName: 'id', value: e.secondaryId),
                DataGridCell<Widget>(
                    columnName: 'Change Request',
                    value: e.changeRequestId == null
                        ? Container()
                        : Icon(
                            Icons.warning_rounded,
                            color: Colors.orange,
                          )),
                DataGridCell<String>(columnName: 'Patient', value: e.patientName ?? ""),
                DataGridCell<String>(columnName: 'Status', value: e.status ?? ""),
                DataGridCell<DateTime>(columnName: 'Reservation Time', value: e.reservationTime),
                DataGridCell<DateTime>(columnName: 'Real Visit Time', value: e.realVisitTime),
                DataGridCell<DateTime>(columnName: 'Enters Clinic Time', value: e.entersClinicTime),
                DataGridCell<DateTime>(columnName: 'Leave Time', value: e.leaveTime),
                DataGridCell<String>(columnName: 'Duration', value: e.duration ?? ""),
                DataGridCell<String>(columnName: 'Doctor Name', value: e.doctorName ?? ""),
                DataGridCell<Widget>(
                  columnName: 'Edit',
                  value: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      CIA_ShowPopUp(
                        context: context,
                        title:
                            "Edit Visit Entry\n ${(siteController.getRole()?.contains("admin") ?? false) ? "Saving will discard all un applied changes requests!" : "Changes will not take effect until admin approval!"}\n",
                        onSave: () {
                          bloc.add(PatientVisitsBloc_UpdateVisitsEvent(
                              params: UpdateVisitParams(
                            visitEntity: e,
                          )));
                        },
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            if (e.changeRequestId != null && e.changeRequest != null) {}
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: CIA_DateTimeTextFormField(
                                        label: "Reservation Time",
                                        controller: TextEditingController(
                                          text: e.reservationTime == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(e.reservationTime!),
                                        ),
                                        onChange: (value) {
                                          if (siteController.getRole()?.contains("admin") ?? false) {
                                            e.reservationTime = DateTime(
                                              value.year,
                                              value.month,
                                              value.day,
                                              e.reservationTime?.hour ?? 0,
                                              e.reservationTime?.minute ?? 0,
                                              e.reservationTime?.second ?? 0,
                                            );
                                          } else {
                                            e.changeRequest ??= VisitEntity();
                                            e.changeRequest!.reservationTime = DateTime(
                                              value.year,
                                              value.month,
                                              value.day,
                                              e.changeRequest!.reservationTime?.hour ?? 0,
                                              e.changeRequest!.reservationTime?.minute ?? 0,
                                              e.changeRequest!.reservationTime?.second ?? 0,
                                            );
                                          }
                                          setState(() => {});
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TimePickerTextField(
                                        initialTime: e.reservationTime ?? DateTime.now(),
                                        onChanged: (newTime) {
                                          if (siteController.getRole()?.contains("admin") ?? false)
                                            e.reservationTime = DateTime(
                                              e.reservationTime?.year ?? DateTime.now().year,
                                              e.reservationTime?.month ?? DateTime.now().month,
                                              e.reservationTime?.day ?? DateTime.now().day,
                                              newTime.hour,
                                              newTime.minute,
                                              newTime.second,
                                            );
                                          else {
                                            e.changeRequest ??= VisitEntity();
                                            e.changeRequest!.reservationTime = DateTime(
                                              e.changeRequest!.reservationTime?.year ?? DateTime.now().year,
                                              e.changeRequest!.reservationTime?.month ?? DateTime.now().month,
                                              e.changeRequest!.reservationTime?.day ?? DateTime.now().day,
                                              newTime.hour,
                                              newTime.minute,
                                              newTime.second,
                                            );
                                          }
                                          setState(() => {});
                                        },
                                      ),
                                    ),
                                    FormTextKeyWidget(
                                        text: e.changeRequest?.reservationTime != null && e.changeRequest?.reservationTime != e.reservationTime
                                            ? DateFormat("dd/MM/yyyy hh:mm a").format(e.changeRequest!.reservationTime!)
                                            : "",
                                        color: Colors.red),
                                    Visibility(
                                      visible: e.changeRequest?.reservationTime != null &&
                                          e.changeRequest?.reservationTime != e.reservationTime &&
                                          (siteController.getRole()?.contains("admin") ?? false),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        ),
                                        onPressed: () {
                                          setState(() => e.reservationTime = e.changeRequest!.reservationTime!);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CIA_DateTimeTextFormField(
                                        label: "Real Visit Time",
                                        controller: TextEditingController(
                                          text: e.realVisitTime == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(e.realVisitTime!),
                                        ),
                                        onChange: (value) {
                                          if (siteController.getRole()?.contains("admin") ?? false) {
                                            e.realVisitTime = DateTime(
                                              value.year,
                                              value.month,
                                              value.day,
                                              e.realVisitTime?.hour ?? 0,
                                              e.realVisitTime?.minute ?? 0,
                                              e.realVisitTime?.second ?? 0,
                                            );
                                            e.from = e.realVisitTime;
                                          } else {
                                            e.changeRequest ??= VisitEntity();
                                            e.changeRequest!.realVisitTime = DateTime(
                                              value.year,
                                              value.month,
                                              value.day,
                                              e.changeRequest!.realVisitTime?.hour ?? 0,
                                              e.changeRequest!.realVisitTime?.minute ?? 0,
                                              e.changeRequest!.realVisitTime?.second ?? 0,
                                            );
                                            e.changeRequest!.from = e.changeRequest!.realVisitTime;
                                          }

                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TimePickerTextField(
                                        initialTime: e.realVisitTime ?? DateTime.now(),
                                        onChanged: (newTime) {
                                          if (siteController.getRole()?.contains("admin") ?? false) {
                                            e.realVisitTime = DateTime(
                                              e.realVisitTime?.year ?? DateTime.now().year,
                                              e.realVisitTime?.month ?? DateTime.now().month,
                                              e.realVisitTime?.day ?? DateTime.now().day,
                                              newTime.hour,
                                              newTime.minute,
                                              newTime.second,
                                            );
                                            e.from = e.realVisitTime;
                                          } else {
                                            e.changeRequest ??= VisitEntity();
                                            e.changeRequest!.realVisitTime = DateTime(
                                              e.changeRequest!.realVisitTime?.year ?? DateTime.now().year,
                                              e.changeRequest!.realVisitTime?.month ?? DateTime.now().month,
                                              e.changeRequest!.realVisitTime?.day ?? DateTime.now().day,
                                              newTime.hour,
                                              newTime.minute,
                                              newTime.second,
                                            );
                                            e.changeRequest!.from = e.changeRequest!.realVisitTime;
                                          }
                                          setState(() => {});
                                        },
                                      ),
                                    ),
                                    FormTextKeyWidget(
                                        text: e.changeRequest?.realVisitTime != null && e.changeRequest?.realVisitTime != e.realVisitTime
                                            ? DateFormat("dd/MM/yyyy hh:mm a").format(e.changeRequest!.realVisitTime!)
                                            : "",
                                        color: Colors.red),
                                    Visibility(
                                      visible: e.changeRequest?.realVisitTime != null &&
                                          e.changeRequest?.realVisitTime != e.realVisitTime &&
                                          (siteController.getRole()?.contains("admin") ?? false),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        ),
                                        onPressed: () {
                                          setState(() => e.realVisitTime = e.changeRequest!.realVisitTime!);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),

                                Row(
                                  children: [
                                    Expanded(
                                      child: CIA_DateTimeTextFormField(
                                        label: "Enters Clinic Time",
                                        controller: TextEditingController(
                                          text: e.entersClinicTime == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(e.entersClinicTime!),
                                        ),
                                        onChange: (value) {
                                          if (siteController.getRole()?.contains("admin") ?? false) {
                                            e.entersClinicTime = DateTime(
                                              value.year,
                                              value.month,
                                              value.day,
                                              e.entersClinicTime?.hour ?? 0,
                                              e.entersClinicTime?.minute ?? 0,
                                              e.entersClinicTime?.second ?? 0,
                                            );
                                            if (e.leaveTime != null && e.entersClinicTime != null)
                                              e.duration = e.leaveTime!.difference(e.entersClinicTime!).toString();
                                          } else {
                                            e.changeRequest ??= VisitEntity();
                                            e.changeRequest!.entersClinicTime = DateTime(
                                              value.year,
                                              value.month,
                                              value.day,
                                              e.changeRequest!.entersClinicTime?.hour ?? 0,
                                              e.changeRequest!.entersClinicTime?.minute ?? 0,
                                              e.changeRequest!.entersClinicTime?.second ?? 0,
                                            );
                                            if (e.changeRequest!.leaveTime != null && e.changeRequest!.entersClinicTime != null)
                                              e.changeRequest!.duration =
                                                  e.changeRequest!.leaveTime!.difference(e.changeRequest!.entersClinicTime!).toString();
                                          }
                                          setState(() => null);
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TimePickerTextField(
                                        initialTime: e.entersClinicTime ?? DateTime.now(),
                                        onChanged: (newTime) {
                                          if (siteController.getRole()?.contains("admin") ?? false) {
                                            e.entersClinicTime = DateTime(
                                              e.entersClinicTime?.year ?? DateTime.now().year,
                                              e.entersClinicTime?.month ?? DateTime.now().month,
                                              e.entersClinicTime?.day ?? DateTime.now().day,
                                              newTime.hour,
                                              newTime.minute,
                                              newTime.second,
                                            );
                                            if (e.leaveTime != null && e.entersClinicTime != null) {
                                              e.duration = e.leaveTime!.difference(e.entersClinicTime!).toString();
                                            }
                                          } else {
                                            e.changeRequest ??= VisitEntity();
                                            e.changeRequest!.entersClinicTime = DateTime(
                                              e.changeRequest!.entersClinicTime?.year ?? DateTime.now().year,
                                              e.changeRequest!.entersClinicTime?.month ?? DateTime.now().month,
                                              e.changeRequest!.entersClinicTime?.day ?? DateTime.now().day,
                                              newTime.hour,
                                              newTime.minute,
                                              newTime.second,
                                            );
                                          }
                                          setState(() => null);
                                        },
                                      ),
                                    ),
                                    FormTextKeyWidget(
                                        text: e.changeRequest?.entersClinicTime != null && e.changeRequest?.entersClinicTime != e.entersClinicTime
                                            ? DateFormat("dd/MM/yyyy hh:mm a").format(e.changeRequest!.entersClinicTime!)
                                            : "",
                                        color: Colors.red),
                                    Visibility(
                                      visible: e.changeRequest?.entersClinicTime != null &&
                                          e.changeRequest?.entersClinicTime != e.entersClinicTime &&
                                          (siteController.getRole()?.contains("admin") ?? false),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        ),
                                        onPressed: () {
                                          setState(() => e.entersClinicTime = e.changeRequest!.entersClinicTime!);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),

                                Row(
                                  children: [
                                    Expanded(
                                      child: CIA_DateTimeTextFormField(
                                        label: "Leave Time",
                                        controller: TextEditingController(
                                          text: e.leaveTime == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(e.leaveTime!),
                                        ),
                                        onChange: (value) {
                                          if (siteController.getRole()?.contains("admin") ?? false) {
                                            e.leaveTime = DateTime(
                                              value.year,
                                              value.month,
                                              value.day,
                                              e.leaveTime?.hour ?? 0,
                                              e.leaveTime?.minute ?? 0,
                                              e.leaveTime?.second ?? 0,
                                            );
                                            e.to = e.leaveTime;
                                            if (e.leaveTime != null && e.entersClinicTime != null) {
                                              e.duration = e.leaveTime!.difference(e.entersClinicTime!).toString();
                                            }
                                          } else {
                                            e.changeRequest ??= VisitEntity();
                                            e.changeRequest!.leaveTime = DateTime(
                                              value.year,
                                              value.month,
                                              value.day,
                                              e.changeRequest!.leaveTime?.hour ?? 0,
                                              e.changeRequest!.leaveTime?.minute ?? 0,
                                              e.changeRequest!.leaveTime?.second ?? 0,
                                            );
                                            e.changeRequest!.to = e.changeRequest!.leaveTime;
                                            if (e.changeRequest!.leaveTime != null && e.changeRequest!.entersClinicTime != null) {
                                              e.changeRequest!.duration = e.leaveTime!.difference(e.changeRequest!.entersClinicTime!).toString();
                                            }
                                          }

                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TimePickerTextField(
                                        initialTime: e.leaveTime ?? DateTime.now(),
                                        onChanged: (newTime) => setState(() {
                                          if (siteController.getRole()?.contains("admin") ?? false) {
                                            e.leaveTime = DateTime(
                                              e.leaveTime?.year ?? DateTime.now().year,
                                              e.leaveTime?.month ?? DateTime.now().month,
                                              e.leaveTime?.day ?? DateTime.now().day,
                                              newTime.hour,
                                              newTime.minute,
                                              newTime.second,
                                            );
                                            if (e.leaveTime != null && e.entersClinicTime != null)
                                              e.duration = e.leaveTime!.difference(e.entersClinicTime!).toString();
                                            e.to = e.leaveTime;
                                          } else {
                                            e.changeRequest ??= VisitEntity();
                                            e.changeRequest!.leaveTime = DateTime(
                                              e.changeRequest!.leaveTime?.year ?? DateTime.now().year,
                                              e.changeRequest!.leaveTime?.month ?? DateTime.now().month,
                                              e.changeRequest!.leaveTime?.day ?? DateTime.now().day,
                                              newTime.hour,
                                              newTime.minute,
                                              newTime.second,
                                            );
                                            e.changeRequest!.to = e.changeRequest!.leaveTime;
                                          }
                                          setState(() => null);
                                        }),
                                      ),
                                    ),
                                    FormTextKeyWidget(
                                        text: e.changeRequest?.leaveTime != null && e.changeRequest?.leaveTime != e.leaveTime
                                            ? DateFormat("dd/MM/yyyy hh:mm a").format(e.changeRequest!.leaveTime!)
                                            : "",
                                        color: Colors.red),
                                    Visibility(
                                      visible: e.changeRequest?.leaveTime != null &&
                                          e.changeRequest?.leaveTime != e.leaveTime &&
                                          (siteController.getRole()?.contains("admin") ?? false),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        ),
                                        onPressed: () {
                                          setState(() => e.leaveTime = e.changeRequest!.leaveTime!);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),

                                CIA_TextFormField(
                                  enabled: false,
                                  label: "Duration",
                                  controller: TextEditingController(
                                    text: e.duration ?? "",
                                  ),
                                ),
                                SizedBox(height: 10),
                                CIA_PrimaryButton(
                                  label: "Delete",
                                  onTab: () {
                                    CIA_ShowPopUpYesNo(
                                        context: context,
                                        onSave: () {
                                          bloc.add(PatientVisitsBloc_UpdateVisitsEvent(params: UpdateVisitParams(visitEntity: e, delete: true)));
                                          dialogHelper.dismissAll(context);
                                        },
                                        title: "Are you sure you want to delete this entry?");
                                  },
                                  color: Colors.red,
                                  icon: Icon(Icons.delete),
                                )
                                // Add more fields as needed...
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                DataGridCell<Widget>(
                  columnName: 'Treatment',
                  value: CIA_GestureWidget(
                    child: Text(e.treatment ?? ""),
                    onTap: () => CIA_ShowPopUp(context: context, title: "Treatment", child: Text(e.treatment ?? "")),
                  ),
                ),
              ]))
          .toList();
      // else
      //   _visitData = models
      //       .map<DataGridRow>((e) => DataGridRow(cells: [
      //             DataGridCell<int>(columnName: 'id', value: e.id),
      //             DataGridCell<String>(columnName: 'Patient', value: e.patientName ?? ""),
      //             DataGridCell<String>(columnName: 'Status', value: e.status ?? ""),
      //             DataGridCell<DateTime>(columnName: 'Reservation Time', value: e.reservationTime),
      //             DataGridCell<DateTime>(columnName: 'Real Visit Time', value: e.realVisitTime),
      //             DataGridCell<DateTime>(columnName: 'Enters Clinic Time', value: e.entersClinicTime),
      //             DataGridCell<DateTime>(columnName: 'Leave Time', value: e.leaveTime),
      //             DataGridCell<String>(columnName: 'Duration', value: e.duration ?? ""),
      //             DataGridCell<String>(columnName: 'Doctor Name', value: e.doctorName ?? ""),
      //             DataGridCell<Widget>(
      //                 columnName: 'Treatment',
      //                 value: CIA_GestureWidget(
      //                   child: Text(e.treatment ?? ""),
      //                   onTap: () => CIA_ShowPopUp(context: context, title: "Treatment", child: Text(e.treatment ?? "")),
      //                 )),
      //           ]))
      //       .toList();
    }
  }

  List<DataGridRow> _visitData = [];

  @override
  List<DataGridRow> get rows => _visitData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        child: e.value is Widget
            ? e.value
            : Text(
                e.value is DateTime
                    ? DateFormat("dd-MM-yyyy hh:mm a").format(e.value)
                    : e.value == null
                        ? ""
                        : e.value.toString(),
                style: TextStyle(fontSize: 12),
              ),
      );
    }).toList());
  }

  updateData({required List<VisitEntity> newData}) {
    models = newData;
    init();
    notifyListeners();
    notifyDataSourceListeners();
  }
}
