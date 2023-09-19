import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/complainBloc_Events.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/complainBloc_States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../patientsMedical/nonSurgicalTreatment/domain/entities/nonSurgialTreatmentEntity.dart';
import '../../../patientsMedical/nonSurgicalTreatment/domain/usecases/getAllNonSurgicalTreatmentsUseCase.dart';
import '../../domain/entities/complainEntity.dart';
import '../../domain/usecases/addComplainUseCase.dart';
import '../../domain/usecases/getComplainsUseCase.dart';
import '../../domain/usecases/getPatientDataUseCase.dart';
import '../../domain/usecases/inqueueComplaiUseCase.dart';
import '../../domain/usecases/resolveComplaiUseCase.dart';
import '../../domain/usecases/updateComplainNotesUseCase.dart';

class ComplainsBloc extends Bloc<ComplainsBloc_Events, ComplainsBloc_States> {
  final AddComplainUseCase addComplainUseCase;
  final ResolveComplainUseCase resolveComplainUseCase;
  final InqueueComplainUseCase inqueueComplainUseCase;
  final UpdateComplainNotesUseCase updateComplainNotesUseCase;
  final GetComplainsUseCase getComplainsUseCase;
  final GetPatientDataUseCase getPatientDataUseCase;
  final GetAllNonSurgicalTreatmentsUseCase getAllNonSurgicalTreatmentsUseCase;

  ComplainsBloc({
    required this.getComplainsUseCase,
    required this.updateComplainNotesUseCase,
    required this.inqueueComplainUseCase,
    required this.resolveComplainUseCase,
    required this.addComplainUseCase,
    required this.getPatientDataUseCase,
    required this.getAllNonSurgicalTreatmentsUseCase,
  }) : super(ComplainsBloc_LoadingDataState()) {
    on<ComplainsBloc_AddComplainEvent>(
      (event, emit) async {
        emit(ComplainsBloc_ProcessingDataState());
        await addComplainUseCase(event.complainsEntity).then((value) => value.fold(
              (l) => emit(ComplainsBloc_ProcessingDataErrorState(message: l.message ?? "")),
              (r) => emit(ComplainsBloc_ProcessingDataSuccessState()),
            ));
      },
    );
    on<ComplainsBloc_ResolveComplainEvent>(
      (event, emit) async {
        emit(ComplainsBloc_ProcessingDataState());
        await resolveComplainUseCase(event.complainId).then((value) => value.fold(
              (l) => emit(ComplainsBloc_ProcessingDataErrorState(message: l.message ?? "")),
              (r) => emit(ComplainsBloc_ProcessingDataSuccessState()),
            ));
      },
    );
    on<ComplainsBloc_InqueueComplainEvent>(
      (event, emit) async {
        emit(ComplainsBloc_ProcessingDataState());
        await inqueueComplainUseCase(InqueueComplainParams(
          complainId: event.complainId,
          notes: event.notes,
        )).then((value) => value.fold(
              (l) => emit(ComplainsBloc_ProcessingDataErrorState(message: l.message ?? "")),
              (r) => emit(ComplainsBloc_ProcessingDataSuccessState()),
            ));
      },
    );
    on<ComplainsBloc_UpdateComplainNotesEvent>(
      (event, emit) async {
        emit(ComplainsBloc_ProcessingDataState());
        await updateComplainNotesUseCase(UpdateComplainParams(
          complainId: event.complainId,
          notes: event.notes,
        )).then((value) => value.fold(
              (l) => emit(ComplainsBloc_ProcessingDataErrorState(message: l.message ?? "")),
              (r) => emit(ComplainsBloc_ProcessingDataSuccessState()),
            ));
      },
    );
    on<ComplainsBloc_GetComplainsEvent>(
      (event, emit) async {
        emit(ComplainsBloc_LoadingDataState());
        PatientInfoEntity? patient;
        List<NonSurgicalTreatmentEntity> nonSurgicalTreatments = [];
        if (event.patientId != null) {
          final result = await getPatientDataUseCase(event.patientId!);
          result.fold(
            (l) => null,
            (r) => patient = r,
          );
          await getAllNonSurgicalTreatmentsUseCase(event.patientId!).then(
            (value) => value.fold(
              (l) => null,
              (r) => nonSurgicalTreatments = r,
            ),
          );
        }
        await getComplainsUseCase(GetcomplainsParams(
          status: event.status,
          search: event.search,
          patientId: event.patientId,
        )).then((value) => value.fold(
              (l) => emit(ComplainsBloc_ProcessingDataErrorState(message: l.message ?? "")),
              (r) => emit(ComplainsBloc_LoadingDataSuccessState(
                complains: r,
                patient: patient,
                nonSurgicalTreatments: nonSurgicalTreatments,
              )),
            ));
      },
    );
  }
}


class ComplainsDataGridSource extends DataGridSource {
  List<ComplainsEntity> models = <ComplainsEntity>[];
  List<String> columns = [
    "Date",
    "Patient Name",
    "Complain",
    "Last Supervisor",
    "Last Doctor",
    "Mentioned Doctor",
    "Notes",
    "Status",
    "Operator",
  ];

  /// Creates the visit data source class with required details.
  ComplainsDataGridSource() {
    init();
  }

  init() {
    _data = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<DateTime>(columnName: 'Date', value: e.entryTime),
      DataGridCell<String>(columnName: 'Patient Name', value: e.patient!.name??""),
      DataGridCell<String>(columnName: 'Complain', value: e.comment??""),
      DataGridCell<String>(columnName: 'Last Supervisor', value: e.lastSupervisor!.name??""),
      DataGridCell<String>(columnName: 'Last Doctor', value: e.lastDoctor!.name??""),
      DataGridCell<String>(columnName: 'Mentioned Doctor', value: e.mentionedDoctor!.name??""),
      DataGridCell<String>(columnName: 'Notes', value: e.notes),
      DataGridCell<String>(columnName: 'Status', value: e.status!.name),
      DataGridCell<String>(columnName: 'Operator', value: e.resolvedBy!.name??""),
    ]))
        .toList();
  }

  List<DataGridRow> _data = [];

  @override
  List<DataGridRow> get rows => _data;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          if(e.value is Widget)
            return e.value;
          return Container(
            alignment: Alignment.center,
            child: Text(
              e.value == null ? "" : e.value.toString(),
              style: TextStyle(fontSize: 12),
            ),
          );
        }).toList());
  }

  Future<bool> updateData({required List<ComplainsEntity> newData}) async {
    models = newData;
    init();
    notifyListeners();

    return true;
  }


}
