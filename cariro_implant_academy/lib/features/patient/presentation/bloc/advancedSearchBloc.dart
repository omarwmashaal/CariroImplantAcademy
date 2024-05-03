import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/patient/data/models/advancedProstheicSeachRequestModel.dart';
import 'package:cariro_implant_academy/features/patient/data/models/advancedProstheicSeachResponseModel.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedProstheticSearchRequestEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedProstheticSearchResonseEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/advancedProstheticSearchUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/advancedSearchPatientsUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/advancedTreatmentSearchUseCase.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/advancedSearchBloc_Events.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/advancedSearchBloc_States.dart';
import 'package:cariro_implant_academy/features/patient/presentation/pages/PatientAdvancedSearchPage.dart';
import 'package:cariro_implant_academy/features/patient/presentation/widgets/advancedSearchTreatmentFiltersWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../patientsMedical/prosthetic/domain/entities/prostheticDiagnosticEntity.dart';
import '../../domain/entities/advancedPatientSearchEntity.dart';
import '../../domain/entities/advancedTreatmentSearchEntity.dart';

class AdvancedSearchBloc extends Bloc<AdvancedSearchBloc_Events, AdvancedSearchBloc_States> {
  final AdvancedSearchPatientsUseCase advancedSearchPatientsUseCase;
  final AdvancedTreatmentSearchUseCase advancedTreatmentSearchUseCase;
  final AdvancedProstheticSearchUseCase advancedProstheticSearchUseCase;
  List<int> ids = [];

  AdvancedPatientSearchEntity searchPatientQuery = AdvancedPatientSearchEntity();
  AdvancedTreatmentSearchEntity searchTreatmentQuery = AdvancedTreatmentSearchEntity();
  AdvancedProstheticSearchRequestEntity searchProstheticQuery = AdvancedProstheticSearchRequestEntity();

  AdvancedSearchBloc({
    required this.advancedTreatmentSearchUseCase,
    required this.advancedSearchPatientsUseCase,
    required this.advancedProstheticSearchUseCase,
  }) : super(AdvancedSearchBloc_LoadingState()) {
    on<AdvancedSearchBloc_SearchPatientsEvents>(
      (event, emit) async {
        emit(AdvancedSearchBloc_LoadingState());
        List<AdvancedPatientSearchEntity> patients = [];
        List<AdvancedTreatmentSearchEntity> treatments = [];
        List<AdvancedProstheticSearchResponseEntity> pros = [];
        bool failed = false;
        final resultPatients = await advancedSearchPatientsUseCase(event.patientQuery);
        resultPatients.fold(
          (l) {
            failed = true;
            emit(AdvancedSearchBloc_LoadingErrorState(message: l.message ?? ""));
          },
          (r) {
            ids = r.where((element) => element.id != null).map((e) => e.id!).toSet().toList();
            patients = r;
          },
        );

        if (!failed) {
          event.treatmentQuery.ids = ids;
          final resultTreatments = await advancedTreatmentSearchUseCase(event.treatmentQuery);
          resultTreatments.fold(
            (l) {
              failed = true;
              emit(AdvancedSearchBloc_LoadingErrorState(message: l.message ?? ""));
            },
            (r) {
              ids = r.where((element) => element.id != null).map((e) => e.id!).toSet().toList();
              treatments = r;
            },
          );
        }

        if (!failed && !event.prostheticQuery.isNull()) {
          event.prostheticQuery.ids = ids;
          final resultPros = await advancedProstheticSearchUseCase(event.prostheticQuery);
          resultPros.fold(
            (l) {
              failed = true;
              emit(AdvancedSearchBloc_LoadingErrorState(message: l.message ?? ""));
            },
            (r) {
              ids = r.where((element) => element.id != null).map((e) => e.id!).toSet().toList();
              pros = r;
            },
          );
        }

        pros.removeWhere((element) => !ids.contains(element.id ?? 0));
        patients.removeWhere((element) => !ids.contains(element.id ?? 0));
        treatments.removeWhere((element) => !ids.contains(element.id ?? 0));

        switch (event.type) {
          case AdvancedSearchEnum.Treatments:
            emit(AdvancedSearchBloc_LoadedTreatmentsSuccessfullyState(data: treatments));
            break;
          case AdvancedSearchEnum.Prosthetic:
            emit(AdvancedSearchBloc_LoadedProstheticSuccessfullyState(data: pros));
            break;
          default:
            emit(AdvancedSearchBloc_LoadedPatientsSuccessfullyState(data: patients));
        }
      },
    );
    on<AdvancedSearchBloc_SearchTreatmentsEvents>(
      (event, emit) async {
        emit(AdvancedSearchBloc_LoadingState());
        event.query.ids = ids;
        final result = await advancedTreatmentSearchUseCase(event.query);
        result.fold(
          (l) => emit(AdvancedSearchBloc_LoadingErrorState(message: l.message ?? "")),
          (r) {
            ids = r.where((element) => element.id != null).map((e) => e.id!).toList();
            emit(AdvancedSearchBloc_LoadedTreatmentsSuccessfullyState(data: r));
          },
        );
      },
    );
    on<AdvancedSearchBloc_SearchProstheticEvents>(
      (event, emit) async {
        emit(AdvancedSearchBloc_LoadingState());
        final result = await advancedProstheticSearchUseCase(event.query);
        result.fold(
          (l) => emit(AdvancedSearchBloc_LoadingErrorState(message: l.message ?? "")),
          (r) => emit(AdvancedSearchBloc_LoadedProstheticSuccessfullyState(data: r)),
        );
      },
    );
  }
}

class AdvancedPatientSearchDataGridSource extends DataGridSource {
  List<String> columns = [];

  List<AdvancedPatientSearchEntity> models = <AdvancedPatientSearchEntity>[];
  AdvancedPatientSearchEntity searchDTO = AdvancedPatientSearchEntity();

  /// Creates the income data source class with required details.
  AdvancedPatientSearchDataGridSource() {}

  init() {
    _data = models
        .map<DataGridRow>((e) => DataGridRow(cells: () {
              List<DataGridCell> r = [];
              r.add(DataGridCell<String>(columnName: "Id", value: e.secondaryId));
              r.add(DataGridCell<String>(columnName: "Name", value: e.name));
              if (searchDTO.gender != null) r.add(DataGridCell<String>(columnName: "Gender", value: e.gender != null ? e.gender!.name : ""));
              if (searchDTO.ageRangeFrom != null || searchDTO.ageRangeTo != null) r.add(DataGridCell<int>(columnName: "Age", value: e.age ?? 0));
              if (searchDTO.anyDiseases != null) {
                r.add(DataGridCell<List<String>>(columnName: "Diseases", value: e.diseases == null ? [] : e.diseases!.map((e) => e.name).toList()));
              }
              if (searchDTO.bloodPressureCategories != null) {
                r.add(DataGridCell<String>(columnName: "Blood Pressure", value: e.bloodPressure == null ? "" : e.bloodPressure!.name));
              }
              if (searchDTO.diabetesCategories != null) {
                r.add(DataGridCell<String>(columnName: "Diabetes", value: e.diabetes == null ? "" : e.diabetes!.name));
              }
              if (searchDTO.lastHAB1cFrom != null || searchDTO.lastHAB1cTo != null) {
                r.add(DataGridCell<int>(columnName: "Last HAB1c", value: e.lastHAB1c));
              }
              if (searchDTO.penecilin != null) r.add(DataGridCell<String>(columnName: "Penecilin", value: e.penecilin == true ? "Yes" : "No"));
              if (searchDTO.illegalDrugs != null) {
                r.add(DataGridCell<String>(columnName: "Illegal Drugs", value: e.illegalDrugs == true ? "Yes" : "No"));
              }
              if (searchDTO.pregnancy != null) {
                r.add(DataGridCell<String>(columnName: "Pregnancy", value: e.pregnancy == null ? "" : e.pregnancy!.name));
              }
              if (searchDTO.chewing != null) r.add(DataGridCell<String>(columnName: "Chewing", value: e.chewing == true ? "Yes" : "No"));
              if (searchDTO.smokingStatus != null) {
                r.add(DataGridCell<String>(columnName: "Smoking Status", value: e.smokingStatus == null ? "" : e.smokingStatus!.name));
              }
              if (searchDTO.cooperationScore != null) {
                r.add(DataGridCell<String>(columnName: "Cooperation Score", value: e.cooperationScore == null ? "" : e.cooperationScore!.name));
              }
              if (searchDTO.oralHygieneRating != null) {
                r.add(DataGridCell<String>(columnName: "Oral Hygiene Rating", value: e.oralHygieneRating == null ? "" : e.oralHygieneRating!.name));
              }
              return r;
            }()))
        .toList();
  }

  List<DataGridRow> _data = [];

  @override
  List<DataGridRow> get rows => _data;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          e.value.toString(),
        ),
      );
    }).toList());
  }

  updateData({
    required AdvancedPatientSearchEntity searchQuery,
    required List<AdvancedPatientSearchEntity> searchResults,
  }) {
    searchDTO = searchQuery;
    models = searchResults;
    columns = [];
    columns.add("Id");
    columns.add("Name");
    if (searchDTO.gender != null) columns.add("Gender");
    if (searchDTO.ageRangeFrom != null || searchDTO.ageRangeTo != null) columns.add("Age");
    if (searchDTO.anyDiseases != null) columns.add("Diseases");
    if (searchDTO.bloodPressureCategories != null) columns.add("Blood Pressure");
    if (searchDTO.diabetesCategories != null) columns.add("Diabetes");
    if (searchDTO.lastHAB1cTo != null || searchDTO.lastHAB1cFrom != null) columns.add("Last HAB1c");
    if (searchDTO.penecilin != null) columns.add("Penecilin");
    if (searchDTO.illegalDrugs != null) columns.add("Illegal Drugs");
    if (searchDTO.pregnancy != null) columns.add("Pregnancy");
    if (searchDTO.chewing != null) columns.add("Chewing");
    if (searchDTO.smokingStatus != null) columns.add("SmokingStatus");
    if (searchDTO.cooperationScore != null) columns.add("CooperationScore");
    if (searchDTO.oralHygieneRating != null) columns.add("Oral Hygiene Rating");

    init();
    notifyListeners();

    return columns;
  }
}

class AdvancedTreatmentSearchDataGridSource extends DataGridSource {
  List<AdvancedTreatmentSearchEntity> models = <AdvancedTreatmentSearchEntity>[];
  AdvancedTreatmentSearchEntity query = AdvancedTreatmentSearchEntity();

  /// Creates the income data source class with required details.
  AdvancedTreatmentSearchDataGridSource() {
    // addColumnGroup(
    //   ColumnGroup(
    //     name: "Patient Name",
    //     sortGroupRows: true,

    //   ),
    // );
  }

  init({AdvancedTreatmentSearchEntity? search}) {
    List<String> forceShowColumns = [];
    if (query.implantFailed != null) {
      for (var element in models) {
        if (element.treatmentValue?.contains("Failed") ?? false) {
          forceShowColumns.add(element.treatmentName!);
        }
      }
      forceShowColumns = forceShowColumns.toSet().toList();
    }

    List<int> columnsIds = <int>[];
    columnsIds.addAll(query.and_treatmentIds ?? []);
    columnsIds.addAll(query.or_treatmentIds ?? []);

    columnsIds = columnsIds
      ..toSet()
      ..toList();

    var resultIds = models.map((e) => e.treatmentId).toList();
    columnsIds.removeWhere((element) => !resultIds.contains(element));

    var columns =
        columnsIds.map((e) => BasicNameIdObjectEntity(id: e, name: models.firstWhere((element) => element.treatmentId == e).treatmentName)).toList();

    _data = models
        .map<DataGridRow>((e) => DataGridRow(cells: () {
              List<DataGridCell> r = [];

              r.add(DataGridCell<String>(columnName: "Id", value: e.secondaryId));
              r.add(DataGridCell<String>(columnName: "Patient Name", value: e.patientName));
              if (e.tooth != null) r.add(DataGridCell<String>(columnName: "Tooth", value: e.tooth?.toString() ?? ""));
              if (!(query.complicationsAfterSurgery?.isNull() ?? true) || !(query.complicationsAfterSurgeryOr?.isNull() ?? true)) {
                r.add(DataGridCell<String>(columnName: "Complications", value: e.str_complicationsAfterSurgery));
              }
              for (var column in columns) {
                r.add(DataGridCell<String>(columnName: column.name ?? "", value: e.treatmentId == column.id ? e.treatmentValue : "-"));
              }

              return r;
            }()))
        .toList();
  }

  List<DataGridRow> _data = [];

  @override
  List<DataGridRow> get rows => _data;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          e.value
              .toString()
              .replaceAll("Done tooth: ", "")
              .replaceAll("Planned tooth: ", "")
              .replaceAll("Failed tooth: ", "")
              .replaceAll("None", "-"),
          style: TextStyle(
              color: (e.value is String)
                  ? ((e.value as String).contains("Planned")
                      ? Colors.orange
                      : (e.value as String).contains("Done")
                          ? Colors.green
                          : (e.value as String).contains("Failed")
                              ? Colors.red
                              : Colors.black)
                  : Colors.black),
        ),
      );
    }).toList());
  }

  updateData(List<AdvancedTreatmentSearchEntity> newData, AdvancedTreatmentSearchEntity queryy) async {
    models = newData;
    models.sort(
      (a, b) => a.secondaryId!.compareTo(b.secondaryId!),
    );
    query = queryy;
    init();
    notifyListeners();

    return [];
  }

  // @override
  // Widget? buildGroupCaptionCellWidget(RowColumnIndex rowColumnIndex, String summaryValue) {
  //   return Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15), child: Text(summaryValue));
  // }
}

class AdvancedProstheticSearchDataGridSource extends DataGridSource {
  List<String> columns = [
    "Single & Bridge Teeth",
    "Single & Bridge Healing Collar Customization",
    "Single & Bridge Impression Procedure",
    "Single & Bridge Impression Next Visit",
    "Single & Bridge Try In Procedure",
    "Single & Bridge Try In Next Visit",
    "Single & Bridge Delivery Procedure",
    "Single & Bridge Delivery Next Visit",
    "Full Arch Teeth",
    "Full Arch Healing Collar Customization",
    "Full Arch Impression Procedure",
    "Full Arch Impression Next Visit",
    "Full Arch Try In Procedure",
    "Full Arch Try In Next Visit",
    "Full Arch Delivery Procedure",
    "Full Arch Delivery Next Visit",
  ];

  List<AdvancedProstheticSearchResponseEntity> models = <AdvancedProstheticSearchResponseEntity>[];

  /// Creates the income data source class with required details.
  AdvancedProstheticSearchDataGridSource() {}

  init({AdvancedProstheticSearchRequestEntity? request}) {
    _data = models
        .map<DataGridRow>((e) => DataGridRow(cells: () {
              DataGridCell<DateTime>? dateColumn;
              DataGridCell<int>? toothColumn;

              List<DataGridCell> cells = [];
              cells.add(DataGridCell<String>(columnName: "Id", value: e.secondaryId));
              cells.add(DataGridCell<String>(columnName: "Patient Name", value: e.patientName ?? ""));

              if (!(request?.complicationsAnd?.isNull() ?? true) || !(request?.complicationsOr?.isNull() ?? true)) {
                cells.add(DataGridCell<String>(columnName: "Complications", value: e.str_complicationsAfterProsthesis));
              }
              if (request?.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.diagnostic != null ||
                  request?.diagnosticOr?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.diagnostic != null) {
                cells.add(DataGridCell<String>(columnName: "Diagnostic Impression Diagnosis", value: e.diagnosticImpression?.diagnostic?.name ?? ""));

                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.diagnosticImpression?.date);
              }
              if (request?.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.nextStep != null ||
                  request?.diagnosticOr?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.nextStep != null) {
                cells.add(DataGridCell<String>(columnName: "Diagnostic Impression Next Step", value: e.diagnosticImpression?.nextStep?.name ?? ""));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.diagnosticImpression?.date);
              }
              if (request?.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.needsRemake != null ||
                  request?.diagnosticOr?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.needsRemake != null) {
                cells.add(DataGridCell<String>(
                    columnName: "Diagnostic Impression Needs Remake", value: e.diagnosticImpression?.needsRemake ?? false ? "Needs Remake" : "-"));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.diagnosticImpression?.date);
              }
              if (request?.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.scanned != null ||
                  request?.diagnosticOr?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.scanned != null) {
                cells.add(DataGridCell<String>(
                    columnName: "Diagnostic Impression Scanned", value: e.diagnosticImpression?.scanned ?? false ? "Scanned" : "-"));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.diagnosticImpression?.date);
              }
              if (request?.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.diagnostic != null ||
                  request?.diagnosticOr?.prostheticDiagnostic_Bite?.firstOrNull?.diagnostic != null) {
                cells.add(DataGridCell<String>(columnName: "Bite Diagnostic", value: e.bite?.diagnostic?.name ?? ""));

                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.bite?.date);
              }
              if (request?.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.nextStep != null ||
                  request?.diagnosticOr?.prostheticDiagnostic_Bite?.firstOrNull?.nextStep != null) {
                cells.add(DataGridCell<String>(columnName: "Bite Next Step", value: e.bite?.nextStep?.name ?? ""));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.bite?.date);
              }
              if (request?.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.needsRemake != null ||
                  request?.diagnosticOr?.prostheticDiagnostic_Bite?.firstOrNull?.needsRemake != null) {
                cells.add(DataGridCell<String>(columnName: "Bite Needs Remake", value: e.bite?.needsRemake ?? false ? "Needs Remake" : "-"));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.bite?.date);
              }
              if (request?.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.scanned != null ||
                  request?.diagnosticOr?.prostheticDiagnostic_Bite?.firstOrNull?.scanned != null) {
                cells.add(DataGridCell<String>(columnName: "Bite Scanned", value: e.bite?.scanned ?? false ? "Scanned" : "-"));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.bite?.date);
              }
              if (request?.diagnosticAnd?.prostheticDiagnostic_ScanAppliance?.firstOrNull?.diagnostic != null ||
                  request?.diagnosticOr?.prostheticDiagnostic_ScanAppliance?.firstOrNull?.diagnostic != null) {
                cells.add(DataGridCell<String>(columnName: "Scan Appliance Diagnostic", value: e.scanAppliance?.diagnostic?.name ?? ""));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.scanAppliance?.date);
              }
              if (request?.diagnosticAnd?.prostheticDiagnostic_ScanAppliance?.firstOrNull?.needsRemake != null ||
                  request?.diagnosticOr?.prostheticDiagnostic_ScanAppliance?.firstOrNull?.needsRemake != null) {
                cells.add(DataGridCell<String>(
                    columnName: "Scan Appliance Needs Remake", value: e.scanAppliance?.needsRemake ?? false ? "Needs Remake" : "-"));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.scanAppliance?.date);
              }
              if (request?.diagnosticAnd?.prostheticDiagnostic_ScanAppliance?.firstOrNull?.scanned != null ||
                  request?.diagnosticOr?.prostheticDiagnostic_ScanAppliance?.firstOrNull?.scanned != null) {
                cells.add(DataGridCell<String>(columnName: "Scan Appliance Scanned", value: e.scanAppliance?.scanned ?? false ? "Scanned" : "-"));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.scanAppliance?.date);
              }

              if (request?.singleAndBridgeAnd?.healingCollars?.firstOrNull?.finalProthesisHealingCollarStatus != null) {
                cells.add(DataGridCell<String>(
                    columnName: "Single & Bridge Healing Collar Status",
                    value: e.singleAndBridge_HealingCollar?.finalProthesisHealingCollarStatus?.name ?? ""));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.singleAndBridge_HealingCollar?.date);

                toothColumn = DataGridCell<int>(columnName: "Tooth", value: e.singleAndBridge_HealingCollar?.finalProthesisTeeth?.first);
              }
              if (request?.singleAndBridgeAnd?.impressions?.firstOrNull?.finalProthesisImpressionStatus != null) {
                cells.add(DataGridCell<String>(
                    columnName: "Single & Bridge Impression Procedure",
                    value: e.singleAndBridge_Impression?.finalProthesisImpressionStatus?.name ?? ""));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.singleAndBridge_Impression?.date);
                toothColumn = DataGridCell<int>(columnName: "Tooth", value: e.singleAndBridge_Impression?.finalProthesisTeeth?.first);
              }
              if (request?.singleAndBridgeAnd?.impressions?.firstOrNull?.finalProthesisImpressionNextVisit != null) {
                cells.add(DataGridCell<String>(
                    columnName: "Single & Bridge Impression Next Visit",
                    value: e.singleAndBridge_Impression?.finalProthesisImpressionNextVisit?.name ?? ""));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.singleAndBridge_Impression?.date);
                toothColumn = DataGridCell<int>(columnName: "Tooth", value: e.singleAndBridge_Impression?.finalProthesisTeeth?.first);
              }
              if (request?.singleAndBridgeAnd?.tryIns?.firstOrNull?.finalProthesisTryInStatus != null) {
                cells.add(DataGridCell<String>(
                    columnName: "Single & Bridge Try In Procedure", value: e.singleAndBridge_TryIn?.finalProthesisTryInStatus?.name ?? ""));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.singleAndBridge_TryIn?.date);
                toothColumn = DataGridCell<int>(columnName: "Tooth", value: e.singleAndBridge_TryIn?.finalProthesisTeeth?.first);
              }
              if (request?.singleAndBridgeAnd?.tryIns?.firstOrNull?.finalProthesisTryInNextVisit != null) {
                cells.add(DataGridCell<String>(
                    columnName: "Single & Bridge Try In Next Visit", value: e.singleAndBridge_TryIn?.finalProthesisTryInNextVisit?.name ?? ""));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.singleAndBridge_TryIn?.date);
                toothColumn = DataGridCell<int>(columnName: "Tooth", value: e.singleAndBridge_TryIn?.finalProthesisTeeth?.first);
              }
              if (request?.singleAndBridgeAnd?.delivery?.firstOrNull?.finalProthesisDeliveryStatus != null) {
                cells.add(DataGridCell<String>(
                    columnName: "Single & Bridge Delivery Procedure", value: e.singleAndBridge_Delivery?.finalProthesisDeliveryStatus?.name ?? ""));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.singleAndBridge_Delivery?.date);
                toothColumn = DataGridCell<int>(columnName: "Tooth", value: e.singleAndBridge_Delivery?.finalProthesisTeeth?.first);
              }
              if (request?.singleAndBridgeAnd?.delivery?.firstOrNull?.finalProthesisDeliveryNextVisit != null) {
                cells.add(DataGridCell<String>(
                    columnName: "Single & Bridge Delivery Next Visit",
                    value: e.singleAndBridge_Delivery?.finalProthesisDeliveryNextVisit?.name ?? ""));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.singleAndBridge_Delivery?.date);
                toothColumn = DataGridCell<int>(columnName: "Tooth", value: e.singleAndBridge_Delivery?.finalProthesisTeeth?.first);
              }
              if (request?.fullArchAnd?.healingCollars?.firstOrNull?.finalProthesisHealingCollarStatus != null) {
                cells.add(DataGridCell<String>(
                    columnName: "Full Arch Healing Collar Status", value: e.fullArch_HealingCollar?.finalProthesisHealingCollarStatus?.name ?? ""));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.fullArch_HealingCollar?.date);
              }
              if (request?.fullArchAnd?.impressions?.firstOrNull?.finalProthesisImpressionStatus != null) {
                cells.add(DataGridCell<String>(
                    columnName: "Full Arch Impression Procedure", value: e.fullArch_Impression?.finalProthesisImpressionStatus?.name ?? ""));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.fullArch_Impression?.date);
              }
              if (request?.fullArchAnd?.impressions?.firstOrNull?.finalProthesisImpressionNextVisit != null) {
                cells.add(DataGridCell<String>(
                    columnName: "Full Arch Impression Next Visit", value: e.fullArch_Impression?.finalProthesisImpressionNextVisit?.name ?? ""));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.fullArch_Impression?.date);
              }
              if (request?.fullArchAnd?.tryIns?.firstOrNull?.finalProthesisTryInStatus != null) {
                cells.add(
                    DataGridCell<String>(columnName: "Full Arch Try In Procedure", value: e.fullArch_TryIn?.finalProthesisTryInStatus?.name ?? ""));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.fullArch_TryIn?.date);
              }
              if (request?.fullArchAnd?.tryIns?.firstOrNull?.finalProthesisTryInNextVisit != null) {
                cells.add(DataGridCell<String>(
                    columnName: "Full Arch Try In Next Visit", value: e.fullArch_TryIn?.finalProthesisTryInNextVisit?.name ?? ""));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.fullArch_TryIn?.date);
              }
              if (request?.fullArchAnd?.delivery?.firstOrNull?.finalProthesisDeliveryStatus != null) {
                cells.add(DataGridCell<String>(
                    columnName: "Full Arch Delivery Procedure", value: e.fullArch_Delivery?.finalProthesisDeliveryStatus?.name ?? ""));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.fullArch_Delivery?.date);
              }
              if (request?.fullArchAnd?.delivery?.firstOrNull?.finalProthesisDeliveryNextVisit != null) {
                cells.add(DataGridCell<String>(
                    columnName: "Full Arch Delivery Next Visit", value: e.fullArch_Delivery?.finalProthesisDeliveryNextVisit?.name ?? ""));
                dateColumn = DataGridCell<DateTime>(columnName: "Date", value: e.fullArch_Delivery?.date);
              }

              if (toothColumn != null) cells.insert(2, toothColumn);
              if (dateColumn != null) cells.insert(2, dateColumn);
              return cells;
            }()))
        .toList();
  }

  List<DataGridRow> _data = [];

  @override
  List<DataGridRow> get rows => _data;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        child: Text(e.value is DateTime ? DateFormat("dd-MM-yyyy").format(e.value) : e.value.toString()),
      );
    }).toList());
  }

  updateData({required List<AdvancedProstheticSearchResponseEntity> response, AdvancedProstheticSearchRequestEntity? request}) async {
    models = response;
    init(request: request);
    notifyListeners();

    return columns;
  }
}
