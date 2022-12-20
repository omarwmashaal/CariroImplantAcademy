import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PatientInfoModel{
  String? Name;
  int? ID;
  String? Gender;
  String? Phone;
  String? Phone2;
  String? DateOfBirth;
  String? MaritalStatus;
  String? Address;
  String? City;
  PatientInfoModel(this.ID,this.Name,this.Phone,this.MaritalStatus);


  static List<PatientInfoModel> models = <PatientInfoModel>[];
  static List<String> columns = ["ID","Name","Phone","Marital Stats"];
  //PatientDataSource dataSource = PatientDataSource();



}



class PatientDataSource extends DataGridSource {


  List<PatientInfoModel> models = <PatientInfoModel>[
    PatientInfoModel(5, "Omar", "1290447120", "Married"),
    PatientInfoModel(21, "Omar", "1290447120", "Married"),
    PatientInfoModel(4, "Omar", "1290447120", "Married"),
    PatientInfoModel(8, "Omar", "1290447120", "Married"),
    PatientInfoModel(14, "Omar", "1290447120", "Married"),
    PatientInfoModel(20, "Omar", "1290447120", "Married"),
    PatientInfoModel(13, "Omar", "1290447120", "Married"),
    PatientInfoModel(9, "Omar", "1290447120", "Married"),
    PatientInfoModel(9, "Omar", "1290447120", "Married"),
    PatientInfoModel(9, "Omar", "1290447120", "Married"),
    PatientInfoModel(9, "Omar", "1290447120", "Married"),
    PatientInfoModel(9, "Omar", "1290447120", "Married"),
    PatientInfoModel(9, "Omar", "1290447120", "Married"),
    PatientInfoModel(9, "Omar", "1290447120", "Married"),
    PatientInfoModel(9, "Omar", "1290447120", "Married"),
    PatientInfoModel(9, "Omar", "1290447120", "Married"),
    PatientInfoModel(9, "Omar", "1290447120", "Married"),
    PatientInfoModel(9, "Omar", "1290447120", "Married"),
    PatientInfoModel(9, "Omar", "1290447120", "Married"),
    PatientInfoModel(9, "Omar", "1290447120", "Married"),
    PatientInfoModel(9, "Omar", "1290447120", "Married"),
    PatientInfoModel(9, "Omar", "1290447120", "Married"),
    PatientInfoModel(9, "Omar", "1290447120", "Married"),
    PatientInfoModel(9, "Omar", "1290447120", "Married"),
  ];
  /// Creates the patient data source class with required details.
  PatientDataSource() {

    _patientData =  models.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'ID', value: e.ID),
      DataGridCell<String>(columnName: 'Name', value: e.Name),
      DataGridCell<String>(columnName: 'Phone', value: e.Phone),
      DataGridCell<String>(columnName: 'Marital Status', value: e.MaritalStatus),
    ])).toList();

  }
  List<DataGridRow> _patientData = [];

  @override
  List<DataGridRow> get rows => _patientData;



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
    models.add(PatientInfoModel(5, "Omar", "1290447120", "Married"));
    models.add(PatientInfoModel(21, "Omar", "1290447120", "Married"));
    models.add(PatientInfoModel(4, "Omar", "1290447120", "Married"));
    models.add(PatientInfoModel(8, "Omar", "1290447120", "Married"));
    models.add(PatientInfoModel(14, "Omar", "1290447120", "Married"));
    models.add(PatientInfoModel(20, "Omar", "1290447120", "Married"));
    models.add(PatientInfoModel(13, "Omar", "1290447120", "Married"));
    models.add(PatientInfoModel(9, "Omar", "1290447120", "Married"));

    _patientData =  models.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'ID', value: e.ID),
      DataGridCell<String>(columnName: 'Name', value: e.Name),
      DataGridCell<String>(columnName: 'Phone', value: e.Phone),
      DataGridCell<String>(columnName: 'Marital Status', value: e.MaritalStatus),
    ])).toList();
    notifyListeners();
    print("ended");
    return(){
      print("myfunction");
    };
  }

  Future<bool> addMoreRows() async
  {
    print("entered bunction");
    models.add(PatientInfoModel(5, "Omar", "1290447120", "Married"));
    models.add(PatientInfoModel(21, "Omar", "1290447120", "Married"));
    models.add(PatientInfoModel(4, "Omar", "1290447120", "Married"));
    models.add(PatientInfoModel(8, "Omar", "1290447120", "Married"));
    models.add(PatientInfoModel(14, "Omar", "1290447120", "Married"));
    models.add(PatientInfoModel(20, "Omar", "1290447120", "Married"));
    models.add(PatientInfoModel(13, "Omar", "1290447120", "Married"));
    models.add(PatientInfoModel(9, "Omar", "1290447120", "Married"));

    _patientData =  models.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'ID', value: e.ID),
      DataGridCell<String>(columnName: 'Name', value: e.Name),
      DataGridCell<String>(columnName: 'Phone', value: e.Phone),
      DataGridCell<String>(columnName: 'Marital Status', value: e.MaritalStatus),
    ])).toList();
    notifyListeners();
    return true;

  }

  Future<bool> newRows() async
  {
    print("entered bunction");
    models = [PatientInfoModel(5, "Omar", "1290447120", "Married")];
    _patientData =  models.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'ID', value: e.ID),
      DataGridCell<String>(columnName: 'Name', value: e.Name),
      DataGridCell<String>(columnName: 'Phone', value: e.Phone),
      DataGridCell<String>(columnName: 'Marital Status', value: e.MaritalStatus),
    ])).toList();
    notifyListeners();
    return true;

  }
}