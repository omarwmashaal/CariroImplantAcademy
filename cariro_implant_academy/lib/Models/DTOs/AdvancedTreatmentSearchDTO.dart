import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../API_Response.dart';

class AdvancedTreatmentSearchDTO {
  int? id;
  String? patientName;
  bool? done;
  bool? scaling;
  bool? crown;
  bool? rootCanalTreatment;
  bool? restoration;
  bool? pontic;
  bool? extraction;
  bool? simpleImplant;
  bool? immediateImplant;
  bool? expansionWithImplant;
  bool? splittingWithImplant;
  bool? gbrWithImplant;
  bool? openSinusWithImplant;
  bool? closedSinusWithImplant;
  bool? guidedImplant;
  bool? expansionWithoutImplant;
  bool? splittingWithoutImplant;
  bool? gbrWithoutImplant;
  bool? openSinusWithoutImplant;
  bool? closedSinusWithoutImplant;

  String? str_scaling;
  String? str_crown;
  String? str_rootCanalTreatment;
  String? str_restoration;
  String? str_pontic;
  String? str_extraction;
  String? str_simpleImplant;
  String? str_immediateImplant;
  String? str_expansionWithImplant;
  String? str_splittingWithImplant;
  String? str_gbrWithImplant;
  String? str_openSinusWithImplant;
  String? str_closedSinusWithImplant;
  String? str_guidedImplant;
  String? str_expansionWithoutImplant;
  String? str_splittingWithoutImplant;
  String? str_gbrWithoutImplant;
  String? str_openSinusWithoutImplant;
  String? str_closedSinusWithoutImplant;
  EnumTeethClassification? teethClassification;

  AdvancedTreatmentSearchDTO({
    this.id,
    this.patientName,
    this.done,
    this.scaling,
    this.crown,
    this.rootCanalTreatment,
    this.restoration,
    this.pontic,
    this.extraction,
    this.simpleImplant,
    this.immediateImplant,
    this.expansionWithImplant,
    this.splittingWithImplant,
    this.gbrWithImplant,
    this.openSinusWithImplant,
    this.closedSinusWithImplant,
    this.guidedImplant,
    this.expansionWithoutImplant,
    this.splittingWithoutImplant,
    this.gbrWithoutImplant,
    this.openSinusWithoutImplant,
    this.closedSinusWithoutImplant,
    this.teethClassification,
  });

  AdvancedTreatmentSearchDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientName = json['patientName'];
    done = json['done'];
    str_scaling = json['scaling'];
    str_crown = json['crown'];
    str_rootCanalTreatment = json['rootCanalTreatment'];
    str_restoration = json['restoration'];
    str_pontic = json['pontic'];
    str_extraction = json['extraction'];
    str_simpleImplant = json['simpleImplant'];
    str_immediateImplant = json['immediateImplant'];
    str_expansionWithImplant = json['expansionWithImplant'];
    str_splittingWithImplant = json['splittingWithImplant'];
    str_gbrWithImplant = json['gbrWithImplant'];
    str_openSinusWithImplant = json['openSinusWithImplant'];
    str_closedSinusWithImplant = json['closedSinusWithImplant'];
    str_guidedImplant = json['guidedImplant'];
    str_expansionWithoutImplant = json['expansionWithoutImplant'];
    str_splittingWithoutImplant = json['splittingWithoutImplant'];
    str_gbrWithoutImplant = json['gbrWithoutImplant'];
    str_openSinusWithoutImplant = json['openSinusWithoutImplant'];
    str_closedSinusWithoutImplant = json['closedSinusWithoutImplant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientName'] = this.patientName;
    data['done'] = this.done;
    data['scaling'] = this.scaling;
    data['crown'] = this.crown;
    data['rootCanalTreatment'] = this.rootCanalTreatment;
    data['restoration'] = this.restoration;
    data['pontic'] = this.pontic;
    data['extraction'] = this.extraction;
    data['simpleImplant'] = this.simpleImplant;
    data['immediateImplant'] = this.immediateImplant;
    data['expansionWithImplant'] = this.expansionWithImplant;
    data['splittingWithImplant'] = this.splittingWithImplant;
    data['gbrWithImplant'] = this.gbrWithImplant;
    data['openSinusWithImplant'] = this.openSinusWithImplant;
    data['closedSinusWithImplant'] = this.closedSinusWithImplant;
    data['guidedImplant'] = this.guidedImplant;
    data['expansionWithoutImplant'] = this.expansionWithoutImplant;
    data['splittingWithoutImplant'] = this.splittingWithoutImplant;
    data['gbrWithoutImplant'] = this.gbrWithoutImplant;
    data['openSinusWithoutImplant'] = this.openSinusWithoutImplant;
    data['closedSinusWithoutImplant'] = this.closedSinusWithoutImplant;
    data['teethClassification'] = this.teethClassification == null ? null : this.teethClassification!.index;

    return data;
  }
}

class AdvancedTreatmentSearchDataSource extends DataGridSource {
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

  List<AdvancedTreatmentSearchDTO> models = <AdvancedTreatmentSearchDTO>[];

  /// Creates the income data source class with required details.
  AdvancedTreatmentSearchDataSource() {}

  init({AdvancedTreatmentSearchDTO? search}) {
    _data = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: "Id", value: e.id),
              DataGridCell<String>(columnName: "Patient Name", value: e.patientName),
              DataGridCell<String>(columnName: "Scaling", value: e.str_scaling),
              DataGridCell<String>(columnName: "Crown", value: e.str_crown),
              DataGridCell<String>(columnName: "RootCanal Treatment", value: e.str_rootCanalTreatment),
              DataGridCell<String>(columnName: "Restoration", value: e.str_restoration),
              DataGridCell<String>(columnName: "Pontic", value: e.str_pontic),
              DataGridCell<String>(columnName: "Extraction", value: e.str_extraction),
              DataGridCell<String>(columnName: "Simple Implant", value: e.str_simpleImplant),
              DataGridCell<String>(columnName: "Immediate Implant", value: e.str_immediateImplant),
              DataGridCell<String>(columnName: "Expansion With Implant", value: e.str_expansionWithImplant),
              DataGridCell<String>(columnName: "Splitting With Implant", value: e.str_splittingWithImplant),
              DataGridCell<String>(columnName: "GBR With Implant", value: e.str_gbrWithImplant),
              DataGridCell<String>(columnName: "Open Sinus WithImplant", value: e.str_openSinusWithImplant),
              DataGridCell<String>(columnName: "ClosedSinus With Implant", value: e.str_closedSinusWithImplant),
              DataGridCell<String>(columnName: "Guided Implant", value: e.str_guidedImplant),
              DataGridCell<String>(columnName: "Expansion Without Implant", value: e.str_expansionWithoutImplant),
              DataGridCell<String>(columnName: "Splitting Without Implant", value: e.str_splittingWithoutImplant),
              DataGridCell<String>(columnName: "GBRWithout Implant", value: e.str_gbrWithoutImplant),
              DataGridCell<String>(columnName: "OpenSinus Without Implant", value: e.str_openSinusWithoutImplant),
              DataGridCell<String>(columnName: "ClosedSinus Without Implant", value: e.str_closedSinusWithoutImplant),
            ]))
        .toList();
  }

  _reArrangeColumns(AdvancedTreatmentSearchDTO? search, AdvancedTreatmentSearchDTO result) {
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
          e.value.toString(),
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

  Future<List<String>> loadData({required AdvancedTreatmentSearchDTO msearchDTO}) async {
    API_Response response = await PatientAPI.AdvancedSearchTreatment(msearchDTO);

    if (response.statusCode == 200) models = response.result as List<AdvancedTreatmentSearchDTO>;
    init();
    notifyListeners();

    return columns;
  }
}
