import 'package:cariro_implant_academy/features/patient/domain/usecases/advancedProstheticSearchUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/advancedSearchPatientsUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/advancedTreatmentSearchUseCase.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/advancedSearchBloc_Events.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/advancedSearchBloc_States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../patientsMedical/prosthetic/domain/entities/prostheticEntity.dart';
import '../../domain/entities/advancedPatientSearchEntity.dart';
import '../../domain/entities/advancedTreatmentSearchEntity.dart';

class AdvancedSearchBloc extends Bloc<AdvancedSearchBloc_Events, AdvancedSearchBloc_States> {
  final AdvancedSearchPatientsUseCase advancedSearchPatientsUseCase;
  final AdvancedTreatmentSearchUseCase advancedTreatmentSearchUseCase;
  final AdvancedProstheticSearchUseCase advancedProstheticSearchUseCase;
  List<int> ids = [];

  AdvancedPatientSearchEntity searchPatientQuery = AdvancedPatientSearchEntity();
  AdvancedTreatmentSearchEntity searchTreatmentQuery = AdvancedTreatmentSearchEntity();
  AdvancedProstheticSearchParams searchProstheticQuery = AdvancedProstheticSearchParams(query: ProstheticTreatmentEntity());

  AdvancedSearchBloc({
    required this.advancedTreatmentSearchUseCase,
    required this.advancedSearchPatientsUseCase,
    required this.advancedProstheticSearchUseCase,
  }) : super(AdvancedSearchBloc_LoadingState()) {
    on<AdvancedSearchBloc_SearchPatientsEvents>(
      (event, emit) async {
        emit(AdvancedSearchBloc_LoadingState());
        final result = await advancedSearchPatientsUseCase(event.query);
        result.fold(
          (l) => emit(AdvancedSearchBloc_LoadingErrorState(message: l.message ?? "")),
          (r) {
            ids = r.where((element) => element.id != null).map((e) => e.id!).toList();
            emit(AdvancedSearchBloc_LoadedPatientsSuccessfullyState(data: r));
          },
        );
      },
    );
    on<AdvancedSearchBloc_SearchTreatmentsEvents>(
      (event, emit) async {
        emit(AdvancedSearchBloc_LoadingState());
        event.query.ids = ids;
        final result = await advancedTreatmentSearchUseCase(event.query);
        result.fold(
          (l) => emit(AdvancedSearchBloc_LoadingErrorState(message: l.message ?? "")),
          (r) => emit(AdvancedSearchBloc_LoadedTreatmentsSuccessfullyState(data: r)),
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

class AdvancedTreatmentSearchDataGridSource extends DataGridSource {
  List<String> columns = [
    "Id",
    "Patient Name",
    "Scaling",
    "Crown",
    "RootCanal Treatment",
    "Restoration",
    "Pontic",
    "Extraction",
    "Simple Implant",
    "Immediate Implant",
    "Expansion With Implant",
    "Splitting With Implant",
    "GBR With Implant",
    "Open Sinus WithImplant",
    "ClosedSinus With Implant",
    "Guided Implant",
    "Expansion Without Implant",
    "Splitting Without Implant",
    "GBRWithout Implant",
    "OpenSinus Without Implant",
    "ClosedSinus Without Implant",
  ];

  List<AdvancedTreatmentSearchEntity> models = <AdvancedTreatmentSearchEntity>[];
  AdvancedTreatmentSearchEntity query  = AdvancedTreatmentSearchEntity();

  /// Creates the income data source class with required details.
  AdvancedTreatmentSearchDataGridSource() {}

  init({AdvancedTreatmentSearchEntity? search}) {
    _data = models
        .map<DataGridRow>((e) => DataGridRow(cells: () {
              List<DataGridCell> r = [];

              r.add(DataGridCell<String>(columnName: "Id", value: e.secondaryId));
              r.add(DataGridCell<String>(columnName: "Patient Name", value: e.patientName));
              if (query.scaling == true) r.add(DataGridCell<String>(columnName: "Scaling", value: e.str_scaling));
              if (query.crown == true) r.add(DataGridCell<String>(columnName: "Crown", value: e.str_crown));
              if (query.rootCanalTreatment == true) r.add(DataGridCell<String>(columnName: "RootCanal Treatment", value: e.str_rootCanalTreatment));
              if (query.restoration == true) r.add(DataGridCell<String>(columnName: "Restoration", value: e.str_restoration));
              if (query.pontic == true) r.add(DataGridCell<String>(columnName: "Pontic", value: e.str_pontic));
              if (query.extraction == true) r.add(DataGridCell<String>(columnName: "Extraction", value: e.str_extraction));
              if (query.simpleImplant == true) r.add(DataGridCell<String>(columnName: "Simple Implant", value: e.str_simpleImplant));
              if (query.immediateImplant == true) r.add(DataGridCell<String>(columnName: "Immediate Implant", value: e.str_immediateImplant));
              if (query.expansionWithImplant == true) r.add(DataGridCell<String>(columnName: "Expansion With Implant", value: e.str_expansionWithImplant));
              if (query.splittingWithImplant == true) r.add(DataGridCell<String>(columnName: "Splitting With Implant", value: e.str_splittingWithImplant));
              if (query.gbrWithImplant == true) r.add(DataGridCell<String>(columnName: "GBR With Implant", value: e.str_gbrWithImplant));
              if (query.openSinusWithImplant == true) r.add(DataGridCell<String>(columnName: "Open Sinus WithImplant", value: e.str_openSinusWithImplant));
              if (query.closedSinusWithImplant == true) r.add(DataGridCell<String>(columnName: "ClosedSinus With Implant", value: e.str_closedSinusWithImplant));
              if (query.guidedImplant == true) r.add(DataGridCell<String>(columnName: "Guided Implant", value: e.str_guidedImplant));
              if (query.expansionWithoutImplant == true) r.add(DataGridCell<String>(columnName: "Expansion Without Implant", value: e.str_expansionWithoutImplant));
              if (query.splittingWithoutImplant == true) r.add(DataGridCell<String>(columnName: "Splitting Without Implant", value: e.str_splittingWithoutImplant));
              if (query.gbrWithoutImplant == true) r.add(DataGridCell<String>(columnName: "GBRWithout Implant", value: e.str_gbrWithoutImplant));
              if (query.openSinusWithoutImplant == true) r.add(DataGridCell<String>(columnName: "OpenSinus Without Implant", value: e.str_openSinusWithoutImplant));
              if (query.closedSinusWithoutImplant == true) r.add(DataGridCell<String>(columnName: "ClosedSinus Without Implant", value: e.str_closedSinusWithoutImplant));
              return r;
            }()))
        .toList();
  }

  _reArrangeColumns(AdvancedTreatmentSearchEntity? search, AdvancedTreatmentSearchEntity result) {
    List<DataGridCell> cells = [
      DataGridCell<int>(columnName: "Id", value: result.id),
      DataGridCell<String>(columnName: "Patient Name", value: result.patientName),
      DataGridCell<String>(columnName: "Scaling", value: result.str_scaling),
      DataGridCell<String>(columnName: "Crown", value: result.str_crown),
      DataGridCell<String>(columnName: "RootCanal Treatment", value: result.str_rootCanalTreatment),
      DataGridCell<String>(columnName: "Restoration", value: result.str_restoration),
      DataGridCell<String>(columnName: "Pontic", value: result.str_pontic),
      DataGridCell<String>(columnName: "Extraction", value: result.str_extraction),
      DataGridCell<String>(columnName: "Simple Implant", value: result.str_simpleImplant),
      DataGridCell<String>(columnName: "Immediate Implant", value: result.str_immediateImplant),
      DataGridCell<String>(columnName: "Expansion With Implant", value: result.str_expansionWithImplant),
      DataGridCell<String>(columnName: "Splitting With Implant", value: result.str_splittingWithImplant),
      DataGridCell<String>(columnName: "GBR With Implant", value: result.str_gbrWithImplant),
      DataGridCell<String>(columnName: "Open Sinus WithImplant", value: result.str_openSinusWithImplant),
      DataGridCell<String>(columnName: "ClosedSinus With Implant", value: result.str_closedSinusWithImplant),
      DataGridCell<String>(columnName: "Guided Implant", value: result.str_guidedImplant),
      DataGridCell<String>(columnName: "Expansion Without Implant", value: result.str_expansionWithoutImplant),
      DataGridCell<String>(columnName: "Splitting Without Implant", value: result.str_splittingWithoutImplant),
      DataGridCell<String>(columnName: "GBRWithout Implant", value: result.str_gbrWithoutImplant),
      DataGridCell<String>(columnName: "OpenSinus Without Implant", value: result.str_openSinusWithoutImplant),
      DataGridCell<String>(columnName: "ClosedSinus Without Implant", value: result.str_closedSinusWithoutImplant),
    ];
    if (search != null) {
      if (search.scaling == true) {
        var temp = cells.firstWhere((element) => element.columnName == "Scaling");
        cells.remove(temp);
        cells.insert(2, temp);
      }
      if (search.crown == true) {
        var temp = cells.firstWhere((element) => element.columnName == "Crown");
        cells.remove(temp);
        cells.insert(2, temp);
      }
      if (search.rootCanalTreatment == true) {
        var temp = cells.firstWhere((element) => element.columnName == "RootCanal Treatment");
        cells.remove(temp);
        cells.insert(2, temp);
      }
      if (search.restoration == true) {
        var temp = cells.firstWhere((element) => element.columnName == "Restoration");
        cells.remove(temp);
        cells.insert(2, temp);
      }
      if (search.pontic == true) {
        var temp = cells.firstWhere((element) => element.columnName == "Pontic");
        cells.remove(temp);
        cells.insert(2, temp);
      }
      if (search.extraction == true) {
        var temp = cells.firstWhere((element) => element.columnName == "Extraction");
        cells.remove(temp);
        cells.insert(2, temp);
      }
      if (search.simpleImplant == true) {
        var temp = cells.firstWhere((element) => element.columnName == "Simple Implant");
        cells.remove(temp);
        cells.insert(2, temp);
      }
      if (search.immediateImplant == true) {
        var temp = cells.firstWhere((element) => element.columnName == "Immediate Implant");
        cells.remove(temp);
        cells.insert(2, temp);
      }
      if (search.expansionWithImplant == true) {
        var temp = cells.firstWhere((element) => element.columnName == "Expansion With Implant");
        cells.remove(temp);
        cells.insert(2, temp);
      }
      if (search.splittingWithImplant == true) {
        var temp = cells.firstWhere((element) => element.columnName == "Splitting With Implant");
        cells.remove(temp);
        cells.insert(2, temp);
      }
      if (search.gbrWithImplant == true) {
        var temp = cells.firstWhere((element) => element.columnName == "GBR With Implant");
        cells.remove(temp);
        cells.insert(2, temp);
      }
      if (search.openSinusWithImplant == true) {
        var temp = cells.firstWhere((element) => element.columnName == "Open Sinus WithImplant");
        cells.remove(temp);
        cells.insert(2, temp);
      }
      if (search.closedSinusWithImplant == true) {
        var temp = cells.firstWhere((element) => element.columnName == "ClosedSinus With Implant");
        cells.remove(temp);
        cells.insert(2, temp);
      }
      if (search.guidedImplant == true) {
        var temp = cells.firstWhere((element) => element.columnName == "Guided Implant");
        cells.remove(temp);
        cells.insert(2, temp);
      }
      if (search.expansionWithoutImplant == true) {
        var temp = cells.firstWhere((element) => element.columnName == "Expansion Without Implant");
        cells.remove(temp);
        cells.insert(2, temp);
      }
      if (search.splittingWithoutImplant == true) {
        var temp = cells.firstWhere((element) => element.columnName == "Splitting Without Implant");
        cells.remove(temp);
        cells.insert(2, temp);
      }
      if (search.gbrWithoutImplant == true) {
        var temp = cells.firstWhere((element) => element.columnName == "GBRWithout Implant");
        cells.remove(temp);
        cells.insert(2, temp);
      }
      if (search.openSinusWithoutImplant == true) {
        var temp = cells.firstWhere((element) => element.columnName == "OpenSinus Without Implant");
        cells.remove(temp);
        cells.insert(2, temp);
      }
      if (search.closedSinusWithoutImplant == true) {
        var temp = cells.firstWhere((element) => element.columnName == "ClosedSinus Without Implant");
        cells.remove(temp);
        cells.insert(2, temp);
      }
    }
    return cells;
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
          e.value.toString().replaceAll("Done tooth: ", "").replaceAll("Planned tooth: ", "").replaceAll("None", "-"),
          style: TextStyle(
              color: (e.value is String)
                  ? ((e.value as String).contains("Planned")
                      ? Colors.orange
                      : (e.value as String).contains("Done")
                          ? Colors.green
                          : Colors.black)
                  : Colors.black),
        ),
      );
    }).toList());
  }

  updateData(List<AdvancedTreatmentSearchEntity> newData,AdvancedTreatmentSearchEntity queryy) async {
    models = newData;
    query = queryy;
    init();
    notifyListeners();

    return columns;
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
              if (searchDTO.anyDiseases != null)
                r.add(DataGridCell<List<String>>(columnName: "Diseases", value: e.diseases == null ? [] : e.diseases!.map((e) => e.name).toList()));
              if (searchDTO.bloodPressureCategories != null)
                r.add(DataGridCell<String>(columnName: "Blood Pressure", value: e.bloodPressure == null ? "" : e.bloodPressure!.name));
              if (searchDTO.diabetesCategories != null) r.add(DataGridCell<String>(columnName: "Diabetes", value: e.diabetes == null ? "" : e.diabetes!.name));
              if (searchDTO.lastHAB1cFrom != null || searchDTO.lastHAB1cTo != null) r.add(DataGridCell<int>(columnName: "Last HAB1c", value: e.lastHAB1c));
              if (searchDTO.penecilin != null) r.add(DataGridCell<String>(columnName: "Penecilin", value: e.penecilin == true ? "Yes" : "No"));
              if (searchDTO.illegalDrugs != null) r.add(DataGridCell<String>(columnName: "Illegal Drugs", value: e.illegalDrugs == true ? "Yes" : "No"));
              if (searchDTO.pregnancy != null) r.add(DataGridCell<String>(columnName: "Pregnancy", value: e.pregnancy == null ? "" : e.pregnancy!.name));
              if (searchDTO.chewing != null) r.add(DataGridCell<String>(columnName: "Chewing", value: e.chewing == true ? "Yes" : "No"));
              if (searchDTO.smokingStatus != null)
                r.add(DataGridCell<String>(columnName: "Smoking Status", value: e.smokingStatus == null ? "" : e.smokingStatus!.name));
              if (searchDTO.cooperationScore != null)
                r.add(DataGridCell<String>(columnName: "Cooperation Score", value: e.cooperationScore == null ? "" : e.cooperationScore!.name));
              if (searchDTO.oralHygieneRating != null)
                r.add(DataGridCell<String>(columnName: "Oral Hygiene Rating", value: e.oralHygieneRating == null ? "" : e.oralHygieneRating!.name));
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

  List<ProstheticTreatmentEntity> models = <ProstheticTreatmentEntity>[];

  /// Creates the income data source class with required details.
  AdvancedProstheticSearchDataGridSource() {}

  init({ProstheticTreatmentEntity? search}) {
    _data = models
        .map<DataGridRow>((e) => DataGridRow(cells: () {
              List<DataGridCell> cells = [];
              cells.add(DataGridCell<String>(columnName: "Id", value: e.secondaryId));
              cells.add(DataGridCell<String>(columnName: "Patient Name", value: e.patient?.name ?? ""));
              if (search?.searchProstheticDiagnostic_DiagnosticImpression?.diagnostic != null)
                cells.add(DataGridCell<String>(
                    columnName: "Diagnostic Impression Diagnostic", value: e.searchProstheticDiagnostic_DiagnosticImpression?.diagnostic?.name ?? ""));
              if (search?.searchProstheticDiagnostic_DiagnosticImpression?.nextStep != null)
                cells.add(DataGridCell<String>(
                    columnName: "Diagnostic Impression Next Step", value: e.searchProstheticDiagnostic_DiagnosticImpression?.nextStep?.name ?? ""));
              if (search?.searchProstheticDiagnostic_DiagnosticImpression?.needsRemake != null)
                cells.add(DataGridCell<String>(
                    columnName: "Diagnostic Impression Needs Remake",
                    value: e.searchProstheticDiagnostic_DiagnosticImpression?.needsRemake ?? false ? "-" : "Needs Remake"));
              if (search?.searchProstheticDiagnostic_DiagnosticImpression?.scanned != null)
                cells.add(DataGridCell<String>(
                    columnName: "Diagnostic Impression Scanned", value: e.searchProstheticDiagnostic_DiagnosticImpression?.scanned ?? false ? "-" : "Scanned"));
              if (search?.searchProstheticDiagnostic_DiagnosticImpression != null)
                cells.add(DataGridCell<DateTime>(columnName: "Diagnostic Impression Date", value: e.searchProstheticDiagnostic_DiagnosticImpression?.date));
              if (search?.searchProstheticDiagnostic_Bite?.diagnostic != null)
                cells.add(DataGridCell<String>(columnName: "Bite Diagnostic", value: e.searchProstheticDiagnostic_Bite?.diagnostic?.name ?? ""));
              if (search?.searchProstheticDiagnostic_Bite?.nextStep != null)
                cells.add(DataGridCell<String>(columnName: "Bite Next Step", value: e.searchProstheticDiagnostic_Bite?.nextStep?.name ?? ""));
              if (search?.searchProstheticDiagnostic_Bite?.needsRemake != null)
                cells.add(DataGridCell<String>(
                    columnName: "Bite Needs Remake", value: e.searchProstheticDiagnostic_Bite?.needsRemake ?? false ? "-" : "Needs Remake"));
              if (search?.searchProstheticDiagnostic_Bite?.scanned != null)
                cells.add(DataGridCell<String>(columnName: "Bite Scanned", value: e.searchProstheticDiagnostic_Bite?.scanned ?? false ? "-" : "Scanned"));
              if (search?.searchProstheticDiagnostic_Bite != null)
                cells.add(DataGridCell<DateTime>(columnName: "Bite Date", value: e.searchProstheticDiagnostic_Bite?.date));
              if (search?.searchProstheticDiagnostic_ScanAppliance?.diagnostic != null)
                cells.add(
                    DataGridCell<String>(columnName: "Scan Appliance Diagnostic", value: e.searchProstheticDiagnostic_ScanAppliance?.diagnostic?.name ?? ""));
              if (search?.searchProstheticDiagnostic_ScanAppliance?.needsRemake != null)
                cells.add(DataGridCell<String>(
                    columnName: "Scan Appliance Needs Remake", value: e.searchProstheticDiagnostic_ScanAppliance?.needsRemake ?? false ? "-" : "Needs Remake"));
              if (search?.searchProstheticDiagnostic_ScanAppliance?.scanned != null)
                cells.add(DataGridCell<String>(
                    columnName: "Scan Appliance Scanned", value: e.searchProstheticDiagnostic_ScanAppliance?.scanned ?? false ? "-" : "Scanned"));
              if (search?.searchProstheticDiagnostic_ScanAppliance != null)
                cells.add(DataGridCell<DateTime>(columnName: "Scan Appliance Date", value: e.searchProstheticDiagnostic_ScanAppliance?.date));
              if (search?.finalProthesisSingleBridgeHealingCollarStatus != null)
                cells.add(DataGridCell<String>(
                    columnName: "Single & Bridge Healing Collar Status", value: e.finalProthesisSingleBridgeHealingCollarStatus?.name ?? ""));
              if (search?.finalProthesisSingleBridgeImpressionStatus != null)
                cells.add(
                    DataGridCell<String>(columnName: "Single & Bridge Impression Procedure", value: e.finalProthesisSingleBridgeImpressionStatus?.name ?? ""));
              if (search?.finalProthesisSingleBridgeImpressionNextVisit != null)
                cells.add(DataGridCell<String>(
                    columnName: "Single & Bridge Impression Next Visit", value: e.finalProthesisSingleBridgeImpressionNextVisit?.name ?? ""));
              if (search?.finalProthesisSingleBridgeTryInStatus != null)
                cells.add(DataGridCell<String>(columnName: "Single & Bridge Try In Procedure", value: e.finalProthesisSingleBridgeTryInStatus?.name ?? ""));
              if (search?.finalProthesisSingleBridgeTryInNextVisit != null)
                cells.add(DataGridCell<String>(columnName: "Single & Bridge Try In Next Visit", value: e.finalProthesisSingleBridgeTryInNextVisit?.name ?? ""));
              if (search?.finalProthesisSingleBridgeDeliveryStatus != null)
                cells
                    .add(DataGridCell<String>(columnName: "Single & Bridge Delivery Procedure", value: e.finalProthesisSingleBridgeDeliveryStatus?.name ?? ""));
              if (search?.finalProthesisSingleBridgeDeliveryNextVisit != null)
                cells.add(
                    DataGridCell<String>(columnName: "Single & Bridge Delivery Next Visit", value: e.finalProthesisSingleBridgeDeliveryNextVisit?.name ?? ""));
              if (search?.finalProthesisFullArchHealingCollarStatus != null)
                cells.add(DataGridCell<String>(columnName: "Full Arch Healing Collar Status", value: e.finalProthesisFullArchHealingCollarStatus?.name ?? ""));
              if (search?.finalProthesisFullArchImpressionStatus != null)
                cells.add(DataGridCell<String>(columnName: "Full Arch Impression Procedure", value: e.finalProthesisFullArchImpressionStatus?.name ?? ""));
              if (search?.finalProthesisFullArchImpressionNextVisit != null)
                cells.add(DataGridCell<String>(columnName: "Full Arch Impression Next Visit", value: e.finalProthesisFullArchImpressionNextVisit?.name ?? ""));
              if (search?.finalProthesisFullArchTryInStatus != null)
                cells.add(DataGridCell<String>(columnName: "Full Arch Try In Procedure", value: e.finalProthesisFullArchTryInStatus?.name ?? ""));
              if (search?.finalProthesisFullArchTryInNextVisit != null)
                cells.add(DataGridCell<String>(columnName: "Full Arch Try In Next Visit", value: e.finalProthesisFullArchTryInNextVisit?.name ?? ""));
              if (search?.finalProthesisFullArchDeliveryStatus != null)
                cells.add(DataGridCell<String>(columnName: "Full Arch Delivery Procedure", value: e.finalProthesisFullArchDeliveryStatus?.name ?? ""));
              if (search?.finalProthesisFullArchDeliveryNextVisit != null)
                cells.add(DataGridCell<String>(columnName: "Full Arch Delivery Next Visit", value: e.finalProthesisFullArchDeliveryNextVisit?.name ?? ""));

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

  updateData({required List<ProstheticTreatmentEntity> newData, ProstheticTreatmentEntity? search}) async {
    models = newData;
    init(search: search);
    notifyListeners();

    return columns;
  }
}
