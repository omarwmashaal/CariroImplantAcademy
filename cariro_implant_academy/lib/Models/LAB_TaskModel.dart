import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'LAB_RequestModel.dart';

class LAB_TaskModel {
  int ID;
  String? Date;
  String? Source;
  String? CustomerName;
  String? CustomerPhone;
  String? RequiredStep;
  String? Status;
  List<LAB_StepModel> Steps = <LAB_StepModel>[];

  LAB_TaskModel(
    this.ID,
    this.Date,
    this.Source,
    this.CustomerName,
    this.CustomerPhone,
    this.RequiredStep,
    this.Status,
  );

  static List<LAB_TaskModel> models = <LAB_TaskModel>[];
  static List<String> columns = [
    "ID",
    "Date",
    "Source",
    "Customer Name",
    "Customer Phone",
    "Required Step",
    "Status",
  ];
//LabTaskDataSource dataSource = LabTaskDataSource();

}

class LabTaskDataSource extends DataGridSource {
  List<LAB_TaskModel> models = <LAB_TaskModel>[
    LAB_TaskModel(1, "12/5/2023", "Clinic", "Omar", "0112345353", "Designing",
        "Waiting your work"),
    LAB_TaskModel(2, "12/5/2023", "Clinic", "Omar", "0112345353", "Designing",
        "Waiting your work"),
    LAB_TaskModel(3, "12/5/2023", "Clinic", "Omar", "0112345353", "Designing",
        "finished"),
    LAB_TaskModel(4, "12/5/2023", "Clinic", "Omar", "0112345353", "Designing",
        "finished"),
    LAB_TaskModel(5, "12/5/2023", "Clinic", "Omar", "0112345353", "Designing",
        "finished"),
    LAB_TaskModel(6, "12/5/2023", "Clinic", "Omar", "0112345353", "Designing",
        "finished"),
    LAB_TaskModel(7, "12/5/2023", "Clinic", "Omar", "0112345353", "Designing",
        "finished"),
    LAB_TaskModel(8, "12/5/2023", "Clinic", "Omar", "0112345353", "Designing",
        "finished"),
    LAB_TaskModel(9, "12/5/2023", "Clinic", "Omar", "0112345353", "Designing",
        "finished"),
    LAB_TaskModel(10, "12/5/2023", "Clinic", "Omar", "0112345353", "Designing",
        "finished"),
    LAB_TaskModel(11, "12/5/2023", "Clinic", "Omar", "0112345353", "Designing",
        "finished"),
    LAB_TaskModel(12, "12/5/2023", "Clinic", "Omar", "0112345353", "Designing",
        "finished"),
    LAB_TaskModel(13, "12/5/2023", "Clinic", "Omar", "0112345353", "Designing",
        "finished"),
    LAB_TaskModel(14, "12/5/2023", "Clinic", "Omar", "0112345353", "Designing",
        "finished"),
    LAB_TaskModel(15, "12/5/2023", "Clinic", "Omar", "0112345353", "Designing",
        "finished"),
    LAB_TaskModel(16, "12/5/2023", "Clinic", "Omar", "0112345353", "Designing",
        "finished"),
    LAB_TaskModel(17, "12/5/2023", "Clinic", "Omar", "0112345353", "Designing",
        "finished"),
  ];

  /// Creates the labTask data source class with required details.
  LabTaskDataSource() {
    _labTaskData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.ID),
              DataGridCell<String>(columnName: 'Date', value: e.Date),
              DataGridCell<String>(columnName: 'Source', value: e.Source),
              DataGridCell<String>(
                  columnName: 'Customer Name', value: e.CustomerName),
              DataGridCell<String>(
                  columnName: 'Customer Phone', value: e.CustomerPhone),
              DataGridCell<String>(
                  columnName: 'Required Step', value: e.RequiredStep),
              DataGridCell<String>(columnName: 'Status', value: e.Status),
            ]))
        .toList();
  }

  List<DataGridRow> _labTaskData = [];

  @override
  List<DataGridRow> get rows => _labTaskData;

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
