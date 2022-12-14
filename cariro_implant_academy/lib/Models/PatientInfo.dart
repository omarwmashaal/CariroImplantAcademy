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
  static _PatientDataSource getDataSource(List<PatientInfoModel> data)
   {
    models = data;
    return  _PatientDataSource(patientData: data);
  }


}



class _PatientDataSource extends DataGridSource {
  /// Creates the patient data source class with required details.
  _PatientDataSource({required List<PatientInfoModel> patientData}) {
    _patientData =  patientData.map<DataGridRow>((e) => DataGridRow(cells: [
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


}