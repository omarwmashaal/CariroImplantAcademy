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

  Future<_PatientDataSource> getDataSource(List<PatientInfoModel> data)
  async {
    _PatientDataSource instance = _PatientDataSource();
    return await instance.create(patientData: data);
  }

}



class _PatientDataSource extends DataGridSource {
  /// Creates the patient data source class with required details.
  Future<_PatientDataSource> create({required List<PatientInfoModel> patientData}) async{
    _patientData = await buildDataGridRow(patientData);
    return this;
  }
  List<String> columns = ["ID","Name","Phone","Marital Stats"];
  List<DataGridRow> _patientData = [];

  @override
  List<DataGridRow> get rows => _patientData;



  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }


  Future<List<DataGridRow>> buildDataGridRow(List<PatientInfoModel> data) async {
    return data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'ID', value: e.ID),
      DataGridCell<String>(columnName: 'Name', value: e.Name),
      DataGridCell<String>(columnName: 'Phone', value: e.Phone),
      DataGridCell<String>(columnName: 'Marital Status', value: e.MaritalStatus),
    ])).toList();
    }
}