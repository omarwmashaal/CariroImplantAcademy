import 'package:cariro_implant_academy/features/patient/domain/entities/visitEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getVisitsUseCase.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientVisitsBloc_Events.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientVisitsBloc_States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

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

  PatientVisitsBloc({
    required this.getVisitsUseCase,
    required this.getPatientDataUseCase,
    required this.patientEntersClinicUseCase,
    required this.patientLeavesClinicUseCase,
    required this.patientVisitsUseCase,
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
  }
}

class VisitDataSource extends DataGridSource {
  List<VisitEntity> models = <VisitEntity>[];
  bool sessions;
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
  VisitDataSource({this.sessions = false}) {
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
                DataGridCell<int>(columnName: 'id', value: e.id),
                DataGridCell<String>(columnName: 'Patient', value: e.patientName ?? ""),
                // DataGridCell<String>(columnName: 'Status', value: e.status??""),
                DataGridCell<DateTime>(columnName: 'Reservation Time', value: e.reservationTime),
                DataGridCell<DateTime>(columnName: 'Real Visit Time', value: e.realVisitTime),
                DataGridCell<DateTime>(columnName: 'Enters Clinic Time', value: e.entersClinicTime),
                DataGridCell<DateTime>(columnName: 'Leave Time', value: e.leaveTime),
                DataGridCell<String>(columnName: 'Duration', value: e.duration ?? ""),
                DataGridCell<String>(columnName: 'Doctor Name', value: e.doctorName ?? ""),
                DataGridCell<String>(columnName: 'Treatment', value: e.treatment ?? ""),
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
                DataGridCell<String>(columnName: 'Treatment', value: e.treatment ?? ""),
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
        child: Text(
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
