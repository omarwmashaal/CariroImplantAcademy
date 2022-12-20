import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AssistantInfoModel {
  String? Name;
  int? ID;
  String? Gender;
  String? Phone;
  String? DateOfBirth;
  String? GraduatedFrom;
  String? ClassYear;
  String? Speciality;

  AssistantInfoModel(
    this.ID,
    this.Name,
    this.Phone,
    this.Gender,
    this.DateOfBirth,
    this.GraduatedFrom,
    this.ClassYear,
    this.Speciality,
  );

  static List<AssistantInfoModel> models = <AssistantInfoModel>[];
  static List<String> columns = [
    "ID",
    "Name",
    "Phone",
    "Gender",
    "Graduated From",
    "Class Year",
    "Speciality"
  ];
//AssistantDataSource dataSource = AssistantDataSource();

}

class AssistantDataSource extends DataGridSource {
  List<AssistantInfoModel> models = <AssistantInfoModel>[
    AssistantInfoModel(1, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    AssistantInfoModel(2, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    AssistantInfoModel(3, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    AssistantInfoModel(4, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    AssistantInfoModel(5, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    AssistantInfoModel(6, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    AssistantInfoModel(7, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    AssistantInfoModel(8, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    AssistantInfoModel(9, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    AssistantInfoModel(10, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    AssistantInfoModel(11, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    AssistantInfoModel(12, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    AssistantInfoModel(13, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    AssistantInfoModel(14, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    AssistantInfoModel(15, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    AssistantInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    AssistantInfoModel(17, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
  ];

  /// Creates the assistant data source class with required details.
  AssistantDataSource() {
    _assistantData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'ID', value: e.ID),
      DataGridCell<String>(columnName: 'Name', value: e.Name),
      DataGridCell<String>(columnName: 'Phone', value: e.Phone),
      DataGridCell<String>(columnName: 'Gender', value: e.Gender),
      DataGridCell<String>(
          columnName: 'Graduated From', value: e.GraduatedFrom),
      DataGridCell<String>(
          columnName: 'Class Year', value: e.ClassYear),
      DataGridCell<String>(
          columnName: 'Speciality', value: e.Speciality),
            ]))
        .toList();
  }

  List<DataGridRow> _assistantData = [];

  @override
  List<DataGridRow> get rows => _assistantData;

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

  @override
  Future<Function> handleLoadMoreRows() async {
    print("entered function");
    models.add(AssistantInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(AssistantInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(AssistantInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(AssistantInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(AssistantInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(AssistantInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(AssistantInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(AssistantInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));

    _assistantData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.ID),
              DataGridCell<String>(columnName: 'Name', value: e.Name),
              DataGridCell<String>(columnName: 'Phone', value: e.Phone),
              DataGridCell<String>(columnName: 'Gender', value: e.Gender),
              DataGridCell<String>(
                  columnName: 'Graduated From', value: e.GraduatedFrom),
              DataGridCell<String>(
                  columnName: 'Class Year', value: e.ClassYear),
              DataGridCell<String>(
                  columnName: 'Speciality', value: e.Speciality),
            ]))
        .toList();
    notifyListeners();
    print("ended");
    return () {
      print("myfunction");
    };
  }

  Future<bool> addMoreRows() async {
    print("entered bunction");
    models.add(AssistantInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(AssistantInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(AssistantInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(AssistantInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(AssistantInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(AssistantInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(AssistantInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(AssistantInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));

    _assistantData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.ID),
              DataGridCell<String>(columnName: 'Name', value: e.Name),
              DataGridCell<String>(columnName: 'Phone', value: e.Phone),
              DataGridCell<String>(columnName: 'Gender', value: e.Gender),
              DataGridCell<String>(
                  columnName: 'Graduated From', value: e.GraduatedFrom),
              DataGridCell<String>(
                  columnName: 'Class Year', value: e.ClassYear),
              DataGridCell<String>(
                  columnName: 'Speciality', value: e.Speciality),
            ]))
        .toList();
    notifyListeners();
    return true;
  }
}
