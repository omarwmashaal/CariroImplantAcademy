import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class VisitsModel {
  String? Status;
  String? ReservationTime;
  String? RealVisitTime;
  String? LeaveTime;
  String? Doctor;
  String? Treatment;

  VisitsModel(
    this.Status,
    this.ReservationTime,
    this.RealVisitTime,
    this.LeaveTime,
    this.Doctor,
    this.Treatment,
  );

  static List<VisitsModel> models = <VisitsModel>[];
  static List<String> columns = [
    "Status",
    "Reservation Time",
    "Real Visit Time",
    "Leave Time",
    "Doctor",
    "Treatment",
  ];
//VisitDataSource dataSource = VisitDataSource();

}

class VisitDataSource extends DataGridSource {
  List<VisitsModel> models = <VisitsModel>[
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
    VisitsModel("Scheduled", "Today 9:30 pm", "1 Dec 10:30", "11:39 pm", "Name",
        "treatment"),
  ];

  /// Creates the visit data source class with required details.
  VisitDataSource() {
    _visitData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Status', value: e.Status),
              DataGridCell<String>(
                  columnName: 'Reservation Time"', value: e.ReservationTime),
              DataGridCell<String>(
                  columnName: 'Real Visit Time', value: e.RealVisitTime),
              DataGridCell<String>(
                  columnName: 'Leave Time', value: e.LeaveTime),
              DataGridCell<String>(columnName: 'Doctor', value: e.Doctor),
              DataGridCell<String>(columnName: 'Treatment', value: e.Treatment),
            ]))
        .toList();
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
        padding: EdgeInsets.only(right: 50),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
