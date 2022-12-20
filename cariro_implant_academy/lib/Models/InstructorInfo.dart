import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class InstructorInfoModel {
  String? Name;
  int? ID;
  String? Gender;
  String? Phone;
  String? DateOfBirth;
  String? GraduatedFrom;
  String? ClassYear;
  String? Speciality;

  InstructorInfoModel(
      this.ID,
      this.Name,
      this.Phone,
      this.Gender,
      this.DateOfBirth,
      this.GraduatedFrom,
      this.ClassYear,
      this.Speciality,
      );

  static List<InstructorInfoModel> models = <InstructorInfoModel>[];
  static List<String> columns = [
    "ID",
    "Name",
    "Phone",
    "Gender",
    "Graduated From",
    "Class Year",
    "Speciality"
  ];
//InstructorDataSource dataSource = InstructorDataSource();

}

class InstructorDataSource extends DataGridSource {
  List<InstructorInfoModel> models = <InstructorInfoModel>[
    InstructorInfoModel(1, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    InstructorInfoModel(2, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    InstructorInfoModel(3, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    InstructorInfoModel(4, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    InstructorInfoModel(5, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    InstructorInfoModel(6, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    InstructorInfoModel(7, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    InstructorInfoModel(8, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    InstructorInfoModel(9, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    InstructorInfoModel(10, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    InstructorInfoModel(11, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    InstructorInfoModel(12, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    InstructorInfoModel(13, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    InstructorInfoModel(14, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    InstructorInfoModel(15, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    InstructorInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    InstructorInfoModel(17, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
  ];

  /// Creates the instructor data source class with required details.
  InstructorDataSource() {
    _instructorData = models
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

  List<DataGridRow> _instructorData = [];

  @override
  List<DataGridRow> get rows => _instructorData;

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
    models.add(InstructorInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(InstructorInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(InstructorInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(InstructorInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(InstructorInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(InstructorInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(InstructorInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(InstructorInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));

    _instructorData = models
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
    models.add(InstructorInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(InstructorInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(InstructorInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(InstructorInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(InstructorInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(InstructorInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(InstructorInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(InstructorInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));

    _instructorData = models
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
