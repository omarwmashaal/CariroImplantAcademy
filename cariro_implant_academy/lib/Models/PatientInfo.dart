import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PatientInfoModel {
  String? name;
  int? id;
  String? gender;
  String? phone;
  String? phone2;
  String? dateOfBirth;
  String? maritalStatus;
  String? address;
  String? city;

  PatientInfoModel({this.id, this.name, this.phone, this.maritalStatus});

  PatientInfoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    gender = json['gender'];
    phone = json['phone'];
    phone2 = json['phone2'];
    dateOfBirth = json['dateOfBirth'];
    maritalStatus = json['maritalStatus'];
    address = json['address'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['phone2'] = this.phone2;
    data['dateOfBirth'] = this.dateOfBirth;
    data['maritalStatus'] = this.maritalStatus;
    data['address'] = this.address;
    data['city'] = this.city;
    return data;
  }

  static List<PatientInfoModel> models = <PatientInfoModel>[];
  static List<String> columns = ["ID", "Name", "Phone", "Marital Stats"];
//PatientDataSource dataSource = PatientDataSource();

}

class PatientDataSource extends DataGridSource {
  List<PatientInfoModel> models = <PatientInfoModel>[];

  /// Creates the patient data source class with required details.
  PatientDataSource() {
    _patientData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<String>(columnName: 'Phone', value: e.phone),
              DataGridCell<String>(
                  columnName: 'Marital Status', value: e.maritalStatus),
            ]))
        .toList();
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

  Future<bool> addMoreRows() async {
    var res = await PatientAPI.ListPatients();
    if (res.statusCode! > 199 && res.statusCode! < 300) {
      models = res.result as List<PatientInfoModel>;
    }

    _patientData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<String>(columnName: 'Phone', value: e.phone),
              DataGridCell<String>(
                  columnName: 'Marital Status', value: e.maritalStatus),
            ]))
        .toList();
    notifyListeners();
    return true;
  }
}
