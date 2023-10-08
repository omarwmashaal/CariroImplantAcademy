import 'package:cariro_implant_academy/features/labRequest/domain/usecases/addOrUpdateRequestReceiptUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/assignTaskToTechnicianUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/createLabRequestUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/createNewLabCustomerUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/finishTaskUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/getAllRequestsUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/getDefaultStepByNameUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/markRequestAsDoneUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/searchLabPatientsByTypeUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_Events.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_States.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/searchUsersByWorkPlaceUseCase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../Constants/Controllers.dart';
import '../../../../core/constants/enums/enums.dart';
import '../../domain/entities/labRequestEntityl.dart';
import '../../domain/usecases/checkLabRequestsUseCase.dart';
import '../../domain/usecases/getPatientRequestsUseCase.dart';
import '../../domain/usecases/getRequestUseCase.dart';

class LabRequestsBloc extends Bloc<LabRequestsBloc_Events, LabRequestsBloc_States> {
  final GetAllLabRequestsUseCase getAllLabRequestsUseCase;
  final CreateNewLabCustomerUseCase createNewLabCustomerUseCase;
  final SearchLabPatientsByTypeUseCase searchLabPatientsByTypeUseCase;
  final CreateLabRequestUseCase createLabRequestUseCase;
  final GetDefaultStepByNameUseCase getDefaultStepByNameUseCase;
  final GetPatientLabRequestsUseCase getPatientLabRequestsUseCase;
  final GetLabRequestUseCase getLabRequestUseCase;
  final FinishTaskUseCase finishTaskUseCase;
  final MarkRequestAsDoneUseCase markRequestAsDoneUseCase;
  final AddOrUpdateRequestReceiptUseCase addOrUpdateRequestReceiptUseCase;
  final AssignTaskToTechnicianUseCase assignTaskToTechnicianUseCase;



  LabRequestsBloc({
    required this.getAllLabRequestsUseCase,
    required this.createNewLabCustomerUseCase,
    required this.searchLabPatientsByTypeUseCase,
    required this.createLabRequestUseCase,
    required this.getDefaultStepByNameUseCase,
    required this.getPatientLabRequestsUseCase,
    required this.getLabRequestUseCase,
    required this.finishTaskUseCase,
    required this.markRequestAsDoneUseCase,
    required this.addOrUpdateRequestReceiptUseCase,
    required this.assignTaskToTechnicianUseCase,
  }) : super(LabRequestsBloc_InitState()) {
    on<LabRequestsBloc_GetTodaysRequestsEvent>(
      (event, emit) async {
        emit(LabRequestsBloc_LoadingRequestsState());
        final result = await getAllLabRequestsUseCase(event.getAllRequestsParams
          ..to = DateFormat("yyyy-MM-dd").format(DateTime.now())
          ..from = DateFormat("yyyy-MM-dd").format(DateTime.now()));
        result.fold(
          (l) => emit(LabRequestsBloc_LoadingRequestsErrorState(message: l.message ?? "")),
          (r) => emit(LabRequestsBloc_LoadedMultiRequestsSuccessfullyState(requests: r)),
        );
      },
    );
    on<LabRequestsBloc_CreateLabCustomerEvent>(
      (event, emit) async {
        emit(LabRequestsBloc_CreatingCustomerState());
        final result = await createNewLabCustomerUseCase(event.customer);
        result.fold(
          (l) => emit(LabRequestsBloc_CreatingCustomerErrorState(message: l.message ?? "")),
          (r) => emit(LabRequestsBloc_CreatedCustomerSuccessfullyState(newCustomer: r)),
        );
      },
    );
    on<LabRequestsBloc_SearchLabPatientsByTypeEvent>(
      (event, emit) async {
        emit(LabRequestsBloc_SearchingPatientsState());
        final result = await searchLabPatientsByTypeUseCase(event.params);
        result.fold(
          (l) => emit(LabRequestsBloc_SearchingPatientsErrorState(message: l.message ?? "")),
          (r) => emit(LabRequestsBloc_LoadedPatientsState(patients: r)),
        );
      },
    );
    on<LabRequestsBloc_GetPatientsRequestsEvent>(
      (event, emit) async {
        emit(LabRequestsBloc_LoadingRequestsState());
        final result = await getPatientLabRequestsUseCase(event.patientId);
        result.fold(
          (l) => emit(LabRequestsBloc_LoadingRequestsErrorState(message: l.message ?? "")),
          (r) => emit(LabRequestsBloc_LoadedMultiRequestsSuccessfullyState(requests: r)),
        );
      },
    );
    on<LabRequestsBloc_GetRequestEvent>(
      (event, emit) async {
        emit(LabRequestsBloc_LoadingRequestsState());
        final result = await getLabRequestUseCase(event.id);
        result.fold(
          (l) => emit(LabRequestsBloc_LoadingRequestsErrorState(message: l.message ?? "")),
          (r) => emit(LabRequestsBloc_LoadedSingleRequestsSuccessfullyState(request: r)),
        );
      },
    );
    on<LabRequestsBloc_AssignTaskToATechnicianEvent>(
      (event, emit) async {
        emit(LabRequestsBloc_AssigningTaskToATechnicianState());
        final result = await assignTaskToTechnicianUseCase(event.params);
        result.fold(
          (l) => emit(LabRequestsBloc_AssigningTaskToATechnicianErrorState(message: l.message ?? "")),
          (r) => emit(LabRequestsBloc_AssignedTaskToATechnicianSuccessfullyState()),
        );
      },
    );
    on<LabRequestsBloc_FinishTaskEvent>(
      (event, emit) async {
        emit(LabRequestsBloc_FinishingTaskState());
        final result = await finishTaskUseCase(event.params);
        result.fold(
          (l) => emit(LabRequestsBloc_FinishingTaskErrorState(message: l.message ?? "")),
          (r) => emit(LabRequestsBloc_FinishedTaskSuccessfullyState()),
        );
      },
    );
    on<LabRequestsBloc_MarkRequestAsDoneEvent>(
      (event, emit) async {
        emit(LabRequestsBloc_MarkingRequestAsDoneState());
        final result = await markRequestAsDoneUseCase(event.params);
        result.fold(
          (l) => emit(LabRequestsBloc_MarkingRequestAsDoneErrorState(message: l.message ?? "")),
          (r) => emit(LabRequestsBloc_MarkedRequestAsDoneSuccessfullyState()),
        );
      },
    );
    on<LabRequestsBloc_AddOrUpdateRequestReceiptEvent>(
      (event, emit) async {
        emit(LabRequestsBloc_UpdatingRequestReceiptState());
        final result = await addOrUpdateRequestReceiptUseCase(event.params);
        result.fold(
          (l) => emit(LabRequestsBloc_UpdatingRequestErrorState(message: l.message ?? "")),
          (r) => emit(LabRequestsBloc_UpdatedRequestReceiptSuccessfullyState()),
        );
      },
    );
    on<LabRequestsBloc_CreateLabRequestEvent>(
      (event, emit) async {
        emit(LabRequestsBloc_CreatingLabRequestState());
        if (event.request.steps != null && event.request.steps!.length != 0) {
          if (event.request.steps?[0]?.step?.name != null)
            await getDefaultStepByNameUseCase(event.request.steps![0]!.step!.name!).then((value) => value.fold(
                  (l) {
                    return emit(LabRequestsBloc_CreatingLabRequestErrorState(message: l.message ?? ""));
                  },
                  (r) {
                    event.request.steps![0].step = r;
                    event.request.steps![0].stepId = r.id;
                  },
                ));

          if (event.request.steps?[1]?.step?.name != null)
            await getDefaultStepByNameUseCase(event.request.steps![1]!.step!.name!).then((value) => value.fold(
                  (l) {
                    return emit(LabRequestsBloc_CreatingLabRequestErrorState(message: l.message ?? ""));
                  },
                  (r) {
                    event.request.steps![1].step = r;
                    event.request.steps![1].stepId = r.id;
                  },
                ));

        }
        final result = await createLabRequestUseCase(event.request);
        result.fold(
          (l) => emit(LabRequestsBloc_CreatingLabRequestErrorState(message: l.message ?? "")),
          (r) => emit(LabRequestsBloc_CreatedLabRequestSuccessfullyState()),
        );
      },
    );
  }
}

class LabRequestDataGridSource extends DataGridSource {
  List<LabRequestEntity> models = [];
  var columns = ["ID", "Date", "Source", "Customer Name", "Customer Phone", "Patient Name", "Paid", "Status"];

  String? from;
  String? to;
  String? search;
  EnumLabRequestStatus? status;
  EnumLabRequestSources? source;
  bool? paid;
  bool? myRequests;

  /// Creates the labRequest data source class with required details.
  LabRequestDataGridSource() {
    init();
  }

  init() {
    columns = [
      // "ID",
      "Date",
      "Source",
      "Customer Name",
      "Customer Phone",
      "Patient Name",
      "Paid",
      "Assigned",
      "Status",
      "Step",
    ];
    _labRequestData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Date', value: e.date == null ? "" : DateFormat("dd-MM-yyyy").format(e.date!)),
              DataGridCell<String>(columnName: 'Source', value: e.source?.name??""),
              DataGridCell<String>(columnName: 'Customer Name', value: e.customer?.name ?? ""),
              DataGridCell<String>(columnName: 'Customer Phone', value: e.customer?.phoneNumber ?? ""),
              DataGridCell<String>(columnName: 'Patient Name', value: e.patient?.name ?? ""),
              DataGridCell<String>(columnName: 'Paid', value: (e.paid ?? false) ? "Paid" : "Not Paid"),
              DataGridCell<String>(columnName: 'Assigned', value: e.assignedToId == siteController.getUserId() ? "You" : e.assignedTo?.name??""),
              DataGridCell<String>(columnName: 'Status', value: e.status?.name.split(".").last??""),
              DataGridCell<String>(columnName: 'Step', value: e.steps ==null||(e.steps??[]).length==0?"": (e.steps ?? [])?.last?.step?.name??""),
            ]))
        .toList();
  }

  List<DataGridRow> _labRequestData = [];

  @override
  List<DataGridRow> get rows => _labRequestData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      if (e.value is Widget) return e.value;
      return Container(
        alignment: Alignment.center,
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  updateData(List<LabRequestEntity> newData) async {
    models = newData;
    init();
    notifyListeners();
  }
}
