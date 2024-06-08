import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
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
      if (siteController.getRole()!.contains("admin"))
        _visitData = models
            .map<DataGridRow>((e) => DataGridRow(cells: [
                  DataGridCell<String>(columnName: 'id', value: e.secondaryId),
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
                              title: "Edite Visit Entry",
                              onSave: () {
                                bloc.add(PatientVisitsBloc_UpdateVisitsEvent(
                                    params: UpdateVisitParams(
                                  visitEntity: e,
                                )));
                              },
                              child: StatefulBuilder(builder: (context, setState) {
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
                                            onChange: (value) => setState(() => e.reservationTime = value),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TimePickerTextField(
                                            initialTime: e.reservationTime ?? DateTime.now(),
                                            onChanged: (newTime) {
                                              setState(() => e.reservationTime = newTime);
                                            },
                                          ),
                                        )
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
                                              e.realVisitTime = value;
                                              e.from = e.realVisitTime;
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TimePickerTextField(
                                            initialTime: e.realVisitTime ?? DateTime.now(),
                                            onChanged: (newTime) => setState(() => e.realVisitTime = newTime),
                                          ),
                                        )
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
                                            onChange: (value) => setState(() {
                                              e.entersClinicTime = value;
                                              if (e.leaveTime != null && e.entersClinicTime != null)
                                                e.duration = e.leaveTime!.difference(e.entersClinicTime!).toString();
                                            }),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TimePickerTextField(
                                            initialTime: e.entersClinicTime ?? DateTime.now(),
                                            onChanged: (newTime) {
                                              e.entersClinicTime = newTime;
                                              if (e.leaveTime != null && e.entersClinicTime != null) {
                                                e.duration = e.leaveTime!.difference(e.entersClinicTime!).toString();
                                              }
                                              setState(() {});
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
                                              e.leaveTime = value;
                                              e.to = e.leaveTime;
                                              if (e.leaveTime != null && e.entersClinicTime != null) {
                                                e.duration = e.leaveTime!.difference(e.entersClinicTime!).toString();

                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TimePickerTextField(
                                            initialTime: e.leaveTime ?? DateTime.now(),
                                            onChanged: (newTime) => setState(() {
                                              e.leaveTime = newTime;
                                              if (e.leaveTime != null && e.entersClinicTime != null)
                                                e.duration = e.leaveTime!.difference(e.entersClinicTime!).toString();
                                            }),
                                          ),
                                        )
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
                              }));
                        },
                      )),
                  DataGridCell<Widget>(
                      columnName: 'Treatment',
                      value: CIA_GestureWidget(
                        child: Text(e.treatment ?? ""),
                        onTap: () => CIA_ShowPopUp(context: context, title: "Treatment", child: Text(e.treatment ?? "")),
                      )),
                ]))
            .toList();
      else
        _visitData = models
            .map<DataGridRow>((e) => DataGridRow(cells: [
                  DataGridCell<int>(columnName: 'id', value: e.id),
                  DataGridCell<String>(columnName: 'Patient', value: e.patientName ?? ""),
                  DataGridCell<String>(columnName: 'Status', value: e.status ?? ""),
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
