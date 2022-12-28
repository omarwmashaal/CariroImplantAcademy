import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class NonSurgicalTreatmentModel {
  int? ID;
  String? Date;
  String? Treatment;
  String? Operator;
  String? Supervisor;
  String? NextVisit;

  NonSurgicalTreatmentModel(
    this.ID,
    this.Date,
    this.Treatment,
    this.Operator,
    this.Supervisor,
    this.NextVisit,
  );

  static List<NonSurgicalTreatmentModel> models = <NonSurgicalTreatmentModel>[];
  static List<String> columns = [
    "ID",
    "Date",
    "Treatment",
    "Operator",
    "Supervisor",
    "Next Visit",
  ];
//NonSurgicalTreatmentDataSource dataSource = NonSurgicalTreatmentDataSource();

}

class NonSurgicalTreatmentDataSource extends DataGridSource {
  List<NonSurgicalTreatmentModel> models = <NonSurgicalTreatmentModel>[
    NonSurgicalTreatmentModel(
        5,
        "12/5/2023",
        "my Trasjhsdfklasdfadjghasdfgjasdlkfgadkhgasdfgkjdshlkasfhklasfhlkasflhsfhlksfhklsfhklasfhklsfahlksfaklhsfahklasflhkasfhklasfhklsfhklasfhklasfhklasfhklasfhklasfhklasfhklfsahklfsahklfsahklfsahklfsahklfsahklfsahklfsahklfsahklfsahlkfsahlkfsahklfashklfashklfsahklfsahklfsahklfsahklfsahlkfsahkleatment",
        "Operator Name",
        "Supervisor Name",
        "25/5/2023 12:30 PM"),
    NonSurgicalTreatmentModel(5, "12/5/2023", "my Treatment", "Operator Name",
        "Supervisor Name", "25/5/2023 12:30 PM"),
    NonSurgicalTreatmentModel(5, "12/5/2023", "my Treatment", "Operator Name",
        "Supervisor Name", "25/5/2023 12:30 PM"),
    NonSurgicalTreatmentModel(5, "12/5/2023", "my Treatment", "Operator Name",
        "Supervisor Name", "25/5/2023 12:30 PM"),
    NonSurgicalTreatmentModel(5, "12/5/2023", "my Treatment", "Operator Name",
        "Supervisor Name", "25/5/2023 12:30 PM"),
    NonSurgicalTreatmentModel(5, "12/5/2023", "my Treatment", "Operator Name",
        "Supervisor Name", "25/5/2023 12:30 PM"),
    NonSurgicalTreatmentModel(5, "12/5/2023", "my Treatment", "Operator Name",
        "Supervisor Name", "25/5/2023 12:30 PM"),
    NonSurgicalTreatmentModel(5, "12/5/2023", "my Treatment", "Operator Name",
        "Supervisor Name", "25/5/2023 12:30 PM"),
    NonSurgicalTreatmentModel(5, "12/5/2023", "my Treatment", "Operator Name",
        "Supervisor Name", "25/5/2023 12:30 PM"),
    NonSurgicalTreatmentModel(5, "12/5/2023", "my Treatment", "Operator Name",
        "Supervisor Name", "25/5/2023 12:30 PM"),
    NonSurgicalTreatmentModel(5, "12/5/2023", "my Treatment", "Operator Name",
        "Supervisor Name", "25/5/2023 12:30 PM"),
    NonSurgicalTreatmentModel(5, "12/5/2023", "my Treatment", "Operator Name",
        "Supervisor Name", "25/5/2023 12:30 PM"),
    NonSurgicalTreatmentModel(5, "12/5/2023", "my Treatment", "Operator Name",
        "Supervisor Name", "25/5/2023 12:30 PM"),
    NonSurgicalTreatmentModel(5, "12/5/2023", "my Treatment", "Operator Name",
        "Supervisor Name", "25/5/2023 12:30 PM"),
    NonSurgicalTreatmentModel(5, "12/5/2023", "my Treatment", "Operator Name",
        "Supervisor Name", "25/5/2023 12:30 PM"),
  ];

  /// Creates the nonSurgicalTreatment data source class with required details.
  ///
  ///  this.ID,
  //     this.Date,
  //     this.Treatment,
  //     this.Operator,
  //     this.Supervisor,
  //     this.NextVisit,
  NonSurgicalTreatmentDataSource() {
    _nonSurgicalTreatmentData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.ID),
              DataGridCell<String>(columnName: 'Date', value: e.Date),
              DataGridCell<String>(columnName: 'Treatment', value: e.Treatment),
              DataGridCell<String>(columnName: 'Operator', value: e.Operator),
              DataGridCell<String>(
                  columnName: 'Supervisor', value: e.Supervisor),
              DataGridCell<String>(
                  columnName: 'Next Visit', value: e.NextVisit),
            ]))
        .toList();
  }

  List<DataGridRow> _nonSurgicalTreatmentData = [];

  @override
  List<DataGridRow> get rows => _nonSurgicalTreatmentData;

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
