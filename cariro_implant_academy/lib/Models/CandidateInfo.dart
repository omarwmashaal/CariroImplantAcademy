import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CandidateInfoModel {
  String? Name;
  int? ID;
  String? Gender;
  String? Phone;
  String? DateOfBirth;
  String? GraduatedFrom;
  String? ClassYear;
  String? Speciality;

  CandidateInfoModel(
      this.ID,
      this.Name,
      this.Phone,
      this.Gender,
      this.DateOfBirth,
      this.GraduatedFrom,
      this.ClassYear,
      this.Speciality,
      );

  static List<CandidateInfoModel> models = <CandidateInfoModel>[];
  static List<String> columns = [
    "ID",
    "Name",
    "Phone",
    "Gender",
    "Graduated From",
    "Class Year",
    "Speciality"
  ];
//CandidateDataSource dataSource = CandidateDataSource();

}

class CandidateDataSource extends DataGridSource {
  List<CandidateInfoModel> models = <CandidateInfoModel>[
    CandidateInfoModel(1, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    CandidateInfoModel(2, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    CandidateInfoModel(3, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    CandidateInfoModel(4, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    CandidateInfoModel(5, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    CandidateInfoModel(6, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    CandidateInfoModel(7, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    CandidateInfoModel(8, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    CandidateInfoModel(9, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    CandidateInfoModel(10, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    CandidateInfoModel(11, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    CandidateInfoModel(12, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    CandidateInfoModel(13, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    CandidateInfoModel(14, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    CandidateInfoModel(15, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    CandidateInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
    CandidateInfoModel(17, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"),
  ];

  /// Creates the candidate data source class with required details.
  CandidateDataSource() {
    _candidateData = models
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

  List<DataGridRow> _candidateData = [];

  @override
  List<DataGridRow> get rows => _candidateData;

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
    models.add(CandidateInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(CandidateInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(CandidateInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(CandidateInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(CandidateInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(CandidateInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(CandidateInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(CandidateInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));

    _candidateData = models
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
    models.add(CandidateInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(CandidateInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(CandidateInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(CandidateInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(CandidateInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(CandidateInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(CandidateInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));
    models.add(CandidateInfoModel(16, "Omar", "1290447120", "Male", "3/2/1997",
        "Cairo University", "2019", "Speciality"));

    _candidateData = models
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
