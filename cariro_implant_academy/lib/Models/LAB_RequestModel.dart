import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

enum StepStatus {
  Done,
  InProgress,
  NotYet,
}

class LAB_StepModel {
  late String name;
  String? assigendTo;
  String? date;
  StepStatus stepStatus = StepStatus.NotYet;
  LAB_StepModel(this.name, this.assigendTo, this.date, this.stepStatus);
}

class LAB_RequestsModel {
  int ID;
  String? Date;
  String? Source;
  String? CustomerName;
  String? CustomerPhone;
  String? PatientName;
  String? InternalPatientID;
  String? AssignedTo;
  String? Status;
  String? PaymentStatus;
  String? Cost;
  String? PayedAmount;
  List<LAB_StepModel> Steps = <LAB_StepModel>[];

  LAB_RequestsModel(
    this.ID,
    this.Date,
    this.Source,
    this.CustomerName,
    this.CustomerPhone,
    this.PatientName,
    this.InternalPatientID,
    this.Status,
  );

  static List<LAB_RequestsModel> models = <LAB_RequestsModel>[];
  static List<String> columns = [
    "ID",
    "Date",
    "Source",
    "Customer Name",
    "Customer Phone",
    "Patient Name",
    "Patient ID",
    "Status",
  ];
//LabRequestDataSource dataSource = LabRequestDataSource();

}

class LabRequestDataSource extends DataGridSource {
  List<LAB_RequestsModel> models = <LAB_RequestsModel>[
    LAB_RequestsModel(1, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(2, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(3, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(4, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(5, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(6, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(7, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(8, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(9, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(10, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(12, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(11, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(13, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(14, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(15, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(16, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(17, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(18, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(19, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
    LAB_RequestsModel(20, "12/5/2023", "Clinic", "Omar", "0112345353", "Wael",
        "12", "In Queue"),
  ];

  /// Creates the labRequest data source class with required details.
  LabRequestDataSource() {
    _labRequestData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.ID),
              DataGridCell<String>(columnName: 'Date', value: e.Date),
              DataGridCell<String>(columnName: 'Source', value: e.Source),
              DataGridCell<String>(
                  columnName: 'Customer Name', value: e.CustomerName),
              DataGridCell<String>(
                  columnName: 'Customer Phone', value: e.CustomerPhone),
              DataGridCell<String>(
                  columnName: 'Patient Name', value: e.PatientName),
              DataGridCell<String>(
                  columnName: 'Patient ID', value: e.InternalPatientID),
              DataGridCell<String>(columnName: 'Status', value: e.Status),
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
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: 50),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
