import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getTeethClinicPrice.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc_States.dart';
import 'package:cariro_implant_academy/core/helpers/spaceToString.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicDoctorPercentageEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicImplantEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/orthoTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/pedoEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/restorationEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/rootCanalTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/scalingEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/tmdEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/useCases/getTreatmentsUseCase.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/useCases/updateTreatmentsUseCase.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc_Events.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc_States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../domain/useCases/getDoctorPercentageForPatientUseCase.dart';
import '../../domain/useCases/updateClinicReceiptUseCase.dart';

class ClinicTreatmentBloc extends Bloc<ClinicTreatmentBloc_Events, ClinicTreatmentBloc_States> {
  final GetClinicTreatmentsUseCase getClinicTreatmentsUseCase;
  final UpdateClinicTreatmentsUseCase updateClinicTreatmentsUseCase;
  final GetTeethClinicPricesUseCase getTeethClinicPricesUseCase;
  final GetDoctorPercentageForPatientUseCase getDoctorPercentageForPatientUseCase;
  final UpdateClinicReceiptUseCase updateClinicReceiptUseCase;

  bool isInitialized = false;

  ClinicTreatmentBloc({
    required this.updateClinicTreatmentsUseCase,
    required this.getClinicTreatmentsUseCase,
    required this.getTeethClinicPricesUseCase,
    required this.getDoctorPercentageForPatientUseCase,
    required this.updateClinicReceiptUseCase,
  }) : super(ClinicTreatmentBloc_InitState()) {
    on<ClinicTreatmentBloc_LoadTreatmentsEvent>(
      (event, emit) async {
        emit(ClinicTreatmentBloc_LoadingTreatmentsState());
        var result = await getClinicTreatmentsUseCase(event.id);
        result.fold(
          (l) => emit(ClinicTreatmentBloc_LoadingTreatmentsErrorState(message: l.message ?? "")),
          (r) => emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: r)),
        );
      },
    );

    on<ClinicTreatmentBloc_GetPriceEvent>(
      (event, emit) async {
        emit(ClinicTreatmentBloc_LoadingPricesState(key: event.key));
        var result = await getTeethClinicPricesUseCase(event.params);
        result.fold(
          (l) => emit(ClinicTreatmentBloc_LoadingPricesErrorState(message: l.message ?? "", key: event.key)),
          (r) => emit(ClinicTreatmentBloc_LoadedPricesSuccessfullyState(key: event.key, prices: r)),
        );
      },
    );
    on<ClinicTreatmentBloc_UpdateTreatmentsEvent>(
      (event, emit) async {
        emit(ClinicTreatmentBloc_UpdatingTreatmentsState());
        var result = await updateClinicTreatmentsUseCase(event.data);
        result.fold(
          (l) => emit(ClinicTreatmentBloc_UpdatingTreatmentsErrorState(message: l.message ?? "")),
          (r) => emit(ClinicTreatmentBloc_UpdatedTreatmentsSuccessfullyState()),
        );
      },
    );

    on<ClinicTreatmentBloc_BuildPageEvent>(
      (event, emit) {
        emit(ClinicTreatmentBloc_LoadingTreatmentsState());
        switch (event.selectedTreatmentEnum) {
          case SelectedTreatmentEnum.restoration:
            {
              for (var tooth in event.selectedTeeth) {
                if (event.data.restorations!.where((element) => element.tooth == tooth).toList().isEmpty)
                  event.data.restorations = [
                    ...event.data.restorations!,
                    RestorationEntity(
                      patientId: event.data.patientId,
                      tooth: tooth,
                    )
                  ];
              }

              break;
            }
          case SelectedTreatmentEnum.rootCanalTreatment:
            {
              for (var tooth in event.selectedTeeth) {
                int number = 1;
                if (event.data.rootCanalTreatments!.where((element) => element.tooth == tooth).toList().isEmpty) {
                  switch (tooth % 10) {
                    case 1:
                      {
                        event.data.rootCanalTreatments = [
                          ...event.data.rootCanalTreatments!,
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 1),
                        ];
                        break;
                      }
                    case 2:
                      {
                        event.data.rootCanalTreatments = [
                          ...event.data.rootCanalTreatments!,
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 1),
                        ];
                        break;
                      }
                    case 3:
                      {
                        event.data.rootCanalTreatments = [
                          ...event.data.rootCanalTreatments!,
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 1),
                        ];
                        break;
                      }
                    case 4:
                      {
                        event.data.rootCanalTreatments = [
                          ...event.data.rootCanalTreatments!,
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 1),
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 2),
                        ];
                        break;
                      }
                    case 5:
                      {
                        event.data.rootCanalTreatments = [
                          ...event.data.rootCanalTreatments!,
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 1),
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 2),
                        ];
                        break;
                      }
                    case 6:
                      {
                        event.data.rootCanalTreatments = [
                          ...event.data.rootCanalTreatments!,
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 1),
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 2),
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 3),
                        ];
                        break;
                      }
                    case 7:
                      {
                        event.data.rootCanalTreatments = [
                          ...event.data.rootCanalTreatments!,
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 1),
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 2),
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 3),
                        ];
                        break;
                      }
                    case 8:
                      {
                        event.data.rootCanalTreatments = [
                          ...event.data.rootCanalTreatments!,
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 1),
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 2),
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 3),
                        ];
                        break;
                      }
                  }
                }
              }

              break;
            }
          case SelectedTreatmentEnum.pedo:
            {
              for (var tooth in event.selectedTeeth) {
                if (event.data.pedos!.where((element) => element.tooth == tooth).toList().isEmpty)
                  event.data.pedos = [
                    ...event.data.pedos!,
                    PedoEntity(
                      patientId: event.data.patientId,
                      tooth: tooth,
                    )
                  ];
              }

              break;
            }
          case SelectedTreatmentEnum.tmd:
            {
              for (var tooth in event.selectedTeeth) {
                if (event.data.tmds!.where((element) => element.tooth == tooth).toList().isEmpty)
                  event.data.tmds = [
                    ...event.data.tmds!,
                    TMDEntity(
                      patientId: event.data.patientId,
                      tooth: tooth,
                    )
                  ];
              }

              break;
            }
          case SelectedTreatmentEnum.scaling:
            {
              for (var tooth in event.selectedTeeth) {
                if (event.data.scalings!.where((element) => element.tooth == tooth).toList().isEmpty)
                  event.data.scalings = [
                    ...event.data.scalings!,
                    ScalingEntity(
                      patientId: event.data.patientId,
                      tooth: tooth,
                      stepNumber: 1,
                    )
                  ];
              }

              break;
            }
          case SelectedTreatmentEnum.implants:
            {
              for (var tooth in event.selectedTeeth) {
                if (event.data.clinicImplants!.where((element) => element.tooth == tooth).toList().isEmpty)
                  event.data.clinicImplants = [
                    ...event.data.clinicImplants!,
                    ClinicImplantEntity(
                      patientId: event.data.patientId,
                      tooth: tooth,
                      type: event.implantType,
                    )
                  ];
              }

              break;
            }
          case SelectedTreatmentEnum.ortho:
            {
              for (var tooth in event.selectedTeeth) {
                if (event.data.orthoTreatments!.where((element) => element.tooth == tooth).toList().isEmpty)
                  event.data.orthoTreatments = [
                    ...event.data.orthoTreatments!,
                    OrthoTreatmentEntity(
                      patientId: event.data.patientId,
                      tooth: tooth,
                    )
                  ];
              }

              break;
            }
        }
        emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: event.data));
      },
    );
    on<ClinicTreatmentBloc_CalculateTotalPriceEvent>(
      (event, emit) {
        var price = 0;
        for (var rest in event.params.restorations!) price += rest.price ?? 0;
        for (var rest in event.params.clinicImplants!) price += rest.price ?? 0;
        for (var rest in event.params.orthoTreatments!) price += rest.price ?? 0;
        for (var rest in event.params.tmds!) price += rest.price ?? 0;
        for (var rest in event.params.pedos!) price += rest.price ?? 0;
        for (var rest in event.params.rootCanalTreatments!) price += rest.price ?? 0;
        for (var rest in event.params.scalings!) price += rest.price ?? 0;
        emit(ClinicTreatmentBloc_TotalPriceChangedState(price: price));
      },
    );
    on<ClinicTreatmentBloc_LoadDoctorsPercentagesEvent>(
      (event, emit) async {
        emit(ClinicTreatmentBloc_LoadingDoctorsPercentageState());
        await updateClinicTreatmentsUseCase(UpdateClinicTreatmentsParams(id: event.id, data: event.clinicTreatmentEntity));
        var result = await getDoctorPercentageForPatientUseCase(event.id);
        result.fold(
          (l) => emit(ClinicTreatmentBloc_LoadingDoctorsPercentageErrorState(message: l.message ?? "")),
          (r) => emit(ClinicTreatmentBloc_LoadedDoctorsPercentageState(data: r)),
        );
      },
    );
    on<ClinicTreatmentBloc_UpdateClinicReceiptEvent>(
      (event, emit) async {
        //emit(ClinicTreatmentBloc_UpdatingClinicReceiptState());
        //var result = await updateClinicReceiptUseCase(event.params);
        // result.fold(
        //     (l) => emit(ClinicTreatmentBloc_UpdatingClinicReceiptErrorState(message: l.message ?? "")),
        //   (r) => emit(ClinicTreatmentBloc_UpdatedClinicReceiptSuccessfullyState()),
      },
    );
  }
}

class DoctorsPercentageDataGridSource extends DataGridSource {
  List<ClinicDoctorPercentageEntity> models = <ClinicDoctorPercentageEntity>[];

  /// Creates the visit data source class with required details.
  DoctorsPercentageDataGridSource() {
    init();
  }

  init() {
    _data = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              //DataGridCell<int>(columnName: 'Id', value: e.patientId),
              DataGridCell<String>(columnName: 'Patient Name', value: e.patient?.name ?? ""),
              DataGridCell<DateTime>(columnName: 'Date', value: e.dateTime),
              DataGridCell<String>(columnName: 'Doctor', value: e.doctor?.name ?? ""),
              DataGridCell<String>(
                  columnName: 'Operation',
                  value: () {
                    if (e.restorationId != null) return "Restoration";
                    if (e.clinicImplantId != null) return "Implant";
                    if (e.orthoTreatmentId != null) return "Ortho";
                    if (e.tMDId != null) return "TMD";
                    if (e.pedoId != null) return "Pedo";
                    if (e.rootCanalTreatment != null) return "Root";
                    if (e.scalingId != null) return "Scaling";
                    return "";
                  }()),
              DataGridCell<String>(
                  columnName: 'Type',
                  value: () {
                    if (e.restorationId != null) return e.restoration?.name;
                    if (e.clinicImplantId != null) return e.clinicImplant?.name;
                    if (e.orthoTreatmentId != null) return e.orthoTreatment?.name;
                    if (e.tMDId != null) return e.tMD?.name;
                    if (e.pedoId != null) return e.pedo?.name;
                    if (e.rootCanalTreatment != null) return e.rootCanalTreatment?.name;
                    if (e.scalingId != null) return e.scaling?.name;
                    return "";
                  }()),
              DataGridCell<String>(columnName: 'Doctor type', value: AddSpacesToSentence(e.doctorFeesType?.name ?? "")),
              DataGridCell<int>(columnName: "Total Fees", value: e.operationFee),
              DataGridCell<int>(columnName: "Doctor's Share", value: e.doctorsFees),
              DataGridCell<int>(columnName: "Clinic's Share", value: e.clinicFee),
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
      if (e.value is Widget) return e.value;

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

  Future<bool> updateData({required List<ClinicDoctorPercentageEntity> newData}) async {
    models = newData;
    init();
    notifyListeners();

    return true;
  }
}
