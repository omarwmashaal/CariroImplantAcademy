import 'dart:html';

import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/blocs/receiptBloc_States.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabItemParentsUseCase.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc_States.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/addOrUpdateRequestReceiptUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/assignTaskToTechnicianUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/consumeLabItemUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/createLabRequestUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/createNewLabCustomerUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/finishTaskUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/getAllRequestsUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/getDefaultStepByNameUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/getLabItemStepsFroRequestUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/markRequestAsDoneUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/payForRequestUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/searchLabPatientsByTypeUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/updateLabRequestUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_Events.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_States.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/searchUsersByWorkPlaceUseCase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../Constants/Controllers.dart';
import '../../../../core/constants/enums/enums.dart';
import '../../domain/entities/labRequestEntityl.dart';
import '../../domain/usecases/checkLabRequestsUseCase.dart';
import '../../domain/usecases/getLabItemDetailsUseCase.dart';
import '../../domain/usecases/getPatientRequestsUseCase.dart';
import '../../domain/usecases/getRequestReceiptUseCase.dart';
import '../../domain/usecases/getRequestUseCase.dart';

class LabRequestsBloc extends Bloc<LabRequestsBloc_Events, LabRequestsBloc_States> {
  final GetAllLabRequestsUseCase getAllLabRequestsUseCase;
  final CreateNewLabCustomerUseCase createNewLabCustomerUseCase;
  final SearchLabPatientsByTypeUseCase searchLabPatientsByTypeUseCase;
  final CreateLabRequestUseCase createLabRequestUseCase;
  final GetDefaultStepByNameUseCase getDefaultStepByNameUseCase;
  final GetPatientLabRequestsUseCase getPatientLabRequestsUseCase;
  final GetLabRequestUseCase getLabRequestUseCase;
  final GetLabItemStepsFroRequestUseCase getLabItemStepsFroRequestUseCase;
  final FinishTaskUseCase finishTaskUseCase;
  final MarkRequestAsDoneUseCase markRequestAsDoneUseCase;
  final AssignTaskToTechnicianUseCase assignTaskToTechnicianUseCase;
  final UpdateLabRequestUseCase updateLabRequestUseCase;
  final GetLabItemDetailsUseCase getLabItemDetailsUseCase;
  final ConsumeLabItemUseCase consumeLabItemUseCase;
  final GetRequestReceiptUseCase getRequestReceiptUseCase;
  final PayRequestUseCase payRequestUseCase;

  LabRequestsBloc({
    required this.getAllLabRequestsUseCase,
    required this.createNewLabCustomerUseCase,
    required this.searchLabPatientsByTypeUseCase,
    required this.createLabRequestUseCase,
    required this.getDefaultStepByNameUseCase,
    required this.getPatientLabRequestsUseCase,
    required this.getLabRequestUseCase,
    required this.getLabItemStepsFroRequestUseCase,
    required this.finishTaskUseCase,
    required this.markRequestAsDoneUseCase,
    required this.assignTaskToTechnicianUseCase,
    required this.updateLabRequestUseCase,
    required this.consumeLabItemUseCase,
    required this.getLabItemDetailsUseCase,
    required this.getRequestReceiptUseCase,
    required this.payRequestUseCase,
  }) : super(LabRequestsBloc_InitState()) {
    on<LabRequestsBloc_GetTodaysRequestsEvent>(
      (event, emit) async {
        emit(LabRequestsBloc_LoadingRequestsState());
        final result = await getAllLabRequestsUseCase(event.getAllRequestsParams);
        result.fold(
          (l) {
            emit(LabRequestsBloc_LoadingRequestsErrorState(message: l.message ?? ""));
          },
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
    on<LabRequestsBloc_UpdateLabRequestEvent>(
      (event, emit) async {
        emit(LabRequestsBloc_UpdatingLabRequestState());
        final result = await updateLabRequestUseCase(event.request);
        result.fold(
          (l) => emit(LabRequestsBloc_UpdatingLabRequestErrorState(message: l.message ?? "")),
          (r) => emit(LabRequestsBloc_UpdatedLabRequestSuccessfullyState()),
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
        //final stepsResult = await getLabItemStepsFroRequestUseCase(event.id);
        // if (stepsResult.isLeft() || result.isLeft()) {
        //   emit(LabRequestsBloc_LoadingSingleRequestErrorState(message: "error"));
        //   return;
        // }
        result.fold(
          (l) => emit(LabRequestsBloc_LoadingSingleRequestErrorState(message: l.message ?? "")),
          (r) {
            // stepsResult.fold((l) => null, (steps) => r.labRequestStepItems = steps);
            emit(LabRequestsBloc_LoadedSingleRequestsSuccessfullyState(request: r));
          },
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
    // on<LabRequestsBloc_AddOrUpdateRequestReceiptEvent>(
    //   (event, emit) async {
    //     emit(LabRequestsBloc_UpdatingRequestReceiptState());
    //     final result = await addOrUpdateRequestReceiptUseCase(event.params);
    //     result.fold(
    //       (l) => emit(LabRequestsBloc_UpdatingRequestErrorState(message: l.message ?? "")),
    //       (r) => emit(LabRequestsBloc_UpdatedRequestReceiptSuccessfullyState()),
    //     );
    //   },
    // );
    on<LabRequestsBloc_ConsumeLabItemEvent>(
      (event, emit) async {
        emit(LabRequestsBloc_ConsumingLabItemState());
        final result = await consumeLabItemUseCase(event.params);
        result.fold(
          (l) => emit(LabRequestsBloc_ConsumingLabItemErrorState(message: l.message ?? "")),
          (r) => emit(LabRequestsBloc_ConsumedLabItemSuccessfullyState()),
        );
      },
    );
    on<LabRequestsBloc_GetLabItemDetailsEvent>(
      (event, emit) async {
        emit(LabRequestsBloc_LoadingLabItemState());
        final result = await getLabItemDetailsUseCase(event.id);
        result.fold(
          (l) => emit(LabRequestsBloc_LoadingLabItemErrorState(message: l.message ?? "")),
          (r) => emit(LabRequestsBloc_LoadedLabItemSuccessfullyState(data: r)),
        );
      },
    );
    on<LabRequestsBloc_GetLabRequestReceiptEvent>(
      (event, emit) async {
        emit(LabRequestsBloc_LoadingLabReceiptState());
        final result = await getRequestReceiptUseCase(event.id);
        result.fold(
          (l) => emit(LabRequestsBloc_LoadingLabReceiptErrorState(message: l.message ?? "")),
          (r) => emit(LabRequestsBloc_LoadedLabReceiptuccessfullyState(data: r)),
        );
      },
    );
    on<LabRequestsBloc_PayRequestEvent>(
      (event, emit) async {
        emit(LabRequestsBloc_PayingRequestState());
        final result = await payRequestUseCase(event.id);
        result.fold(
          (l) => emit(LabRequestsBloc_PayingRequestErrorState(message: l.message ?? "")),
          (r) => emit(LabRequestsBloc_PaidRequestSuccessfullyState()),
        );
      },
    );
    on<LabRequestsBloc_CreateLabRequestEvent>(
      (event, emit) async {
        emit(LabRequestsBloc_CreatingLabRequestState());
        // if (event.request.steps != null && event.request.steps!.length != 0) {
        //   if (event.request.steps?[0]?.step?.name != null)
        //     await getDefaultStepByNameUseCase(event.request.steps![0]!.step!.name!).then((value) => value.fold(
        //           (l) {
        //             return emit(LabRequestsBloc_CreatingLabRequestErrorState(message: l.message ?? ""));
        //           },
        //           (r) {
        //             event.request.steps![0].step = r;
        //             event.request.steps![0].stepId = r.id;
        //           },
        //         ));

        //   if (event.request.steps?[1]?.step?.name != null)
        //     await getDefaultStepByNameUseCase(event.request.steps![1]!.step!.name!).then((value) => value.fold(
        //           (l) {
        //             return emit(LabRequestsBloc_CreatingLabRequestErrorState(message: l.message ?? ""));
        //           },
        //           (r) {
        //             event.request.steps![1].step = r;
        //             event.request.steps![1].stepId = r.id;
        //           },
        //         ));
        // }
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
  Website? source;
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
              DataGridCell<DateTime>(columnName: 'Date', value: e.date),
              DataGridCell<String>(columnName: 'Source', value: e.source?.name ?? ""),
              DataGridCell<String>(columnName: 'Customer Name', value: e.customer?.name ?? ""),
              DataGridCell<String>(columnName: 'Customer Phone', value: e.customer?.phoneNumber ?? ""),
              DataGridCell<String>(columnName: 'Patient Name', value: e.patient?.name ?? ""),
              DataGridCell<String>(columnName: 'Paid', value: (e.paid ?? false) ? "Paid" : "Not Paid"),
              DataGridCell<String>(columnName: 'Assigned', value: e.assignedToId == siteController.getUserId() ? "You" : e.assignedTo?.name ?? ""),
              DataGridCell<String>(columnName: 'Designer', value: e.designerId == siteController.getUserId() ? "You" : e.designer?.name ?? ""),
              DataGridCell<String>(columnName: 'Status', value: e.status?.name.split(".").last ?? ""),
              // DataGridCell<String>(                  columnName: 'Step', value: e.steps == null || (e.steps ?? []).length == 0 ? "" : (e.steps ?? [])?.last?.step?.name ?? ""),
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
        child: Text((e.value != null && e.value is DateTime) ? DateFormat("dd-MM-yyyy").format(e.value) : e.value.toString()),
      );
    }).toList());
  }

  updateData(List<LabRequestEntity> newData) async {
    models = newData;
    init();
    notifyListeners();
  }
}
