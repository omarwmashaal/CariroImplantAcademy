import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/LAB_RequestModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'ApplicationUserModel.dart';
import 'Enum.dart';
import 'LAB_CustomerModel.dart';

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
  DropDownDTO? relativePatient;
  int? relativePatientId;
  EnumPatientType? patientType;
  int? customerId;
  ApplicationUserModel? customer;
  List<LAB_RequestModel>? requests;
  String? labDateOfVisit;

  PatientInfoModel({this.id, this.name, this.phone, this.maritalStatus, this.patientType});

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
    relativePatient = json['relativePatient'] != null ? DropDownDTO.fromJson(json['relativePatient']) : DropDownDTO();
    relativePatientId = json['relativePatientId'];
    patientType = EnumPatientType.values[json['patientType']??0];
    customerId = json['customerId'];
    customer = ApplicationUserModel.fromJson(json['customer']??Map<String,dynamic>());
    requests = ((json['requests']??[]) as List<dynamic>).map((e) => LAB_RequestModel.fromJson(e)).toList();
    labDateOfVisit = CIA_DateConverters.fromDateTimeToBackend(json['labDateOfVisit']);

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
    data['relativePatientId'] = this.relativePatientId;
    data['patientType'] = (this.patientType??EnumPatientType.CIA).index;
    data['customerId'] = this.customerId;
    data['customer'] = this.customer!=null?this.customer!.toJson():null;
    data['requests'] = (this.requests??[]).map((e) => e.toJson()).toList();
    data['labDateOfVisit'] = CIA_DateConverters.fromDateTimeToBackend(this.labDateOfVisit);

    return data;
  }

  static List<PatientInfoModel> models = <PatientInfoModel>[];
  static List<String> columns = ["ID", "Name", "Phone", "Gender", "Marital Stats", "Relative"];
//PatientDataSource dataSource = PatientDataSource();
}

class PatientDataSource extends DataGridSource {
  List<PatientInfoModel> models = <PatientInfoModel>[];

  /// Creates the patient data source class with required details.
  PatientDataSource() {
    init();
  }

  init() {
    _patientData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<String>(columnName: 'Phone', value: e.phone),
              DataGridCell<String>(columnName: 'Gender', value: e.gender),
              DataGridCell<String>(columnName: 'Marital Status', value: e.maritalStatus),
              DataGridCell<String>(columnName: 'Relative', value: e.relativePatient!.name!),
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

  Future<bool> loadData({String? search, String? filter}) async {
    var res = await PatientAPI.ListPatients(search: search, filter: filter);
    if (res.statusCode! > 199 && res.statusCode! < 300) {
      models = res.result as List<PatientInfoModel>;
    }

    init();
    notifyListeners();
    return true;
  }
}
