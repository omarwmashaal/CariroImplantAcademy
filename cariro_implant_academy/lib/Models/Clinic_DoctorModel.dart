import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Clinic_DoctorModel {
  String? Name;
  int? ID;
  String? Gender;
  String? Phone;
  String? DateOfBirth;
  String? GraduatedFrom;
  String? ClassYear;
  String? Speciality;

  Clinic_DoctorModel(
    this.ID,
    this.Name,
    this.Phone,
    this.Gender,
    this.DateOfBirth,
    this.GraduatedFrom,
    this.ClassYear,
    this.Speciality,
  );

  static List<Clinic_DoctorModel> models = <Clinic_DoctorModel>[];
  static List<String> columns = [
    "ID",
    "Name",
    "Phone",
    "Gender",
    "Graduated From",
    "Class Year",
    "Speciality"
  ];
//DoctorDataSource dataSource = DoctorDataSource();

}

class DoctorDataSource extends DataGridSource {
  List<Clinic_DoctorModel> models = <Clinic_DoctorModel>[
    Clinic_DoctorModel(1, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    Clinic_DoctorModel(2, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    Clinic_DoctorModel(3, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    Clinic_DoctorModel(4, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    Clinic_DoctorModel(5, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    Clinic_DoctorModel(6, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    Clinic_DoctorModel(7, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    Clinic_DoctorModel(8, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    Clinic_DoctorModel(9, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    Clinic_DoctorModel(10, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    Clinic_DoctorModel(11, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    Clinic_DoctorModel(12, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    Clinic_DoctorModel(13, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    Clinic_DoctorModel(14, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    Clinic_DoctorModel(15, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    Clinic_DoctorModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    Clinic_DoctorModel(17, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
  ];

  /// Creates the doctor data source class with required details.
  DoctorDataSource() {
    _doctorData = models
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

  List<DataGridRow> _doctorData = [];

  @override
  List<DataGridRow> get rows => _doctorData;

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

    models.add(Clinic_DoctorModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(Clinic_DoctorModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(Clinic_DoctorModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(Clinic_DoctorModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(Clinic_DoctorModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(Clinic_DoctorModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(Clinic_DoctorModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(Clinic_DoctorModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));

    _doctorData = models
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

    return () {

    };
  }

  Future<bool> addMoreRows() async {

    models.add(Clinic_DoctorModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(Clinic_DoctorModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(Clinic_DoctorModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(Clinic_DoctorModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(Clinic_DoctorModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(Clinic_DoctorModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(Clinic_DoctorModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(Clinic_DoctorModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));

    _doctorData = models
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
