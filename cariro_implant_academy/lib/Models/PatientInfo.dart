import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'ApplicationUserModel.dart';
import '../core/constants/enums/enums.dart';
import 'LAB_CustomerModel.dart';

class PatientInfoModel {
  String? name;
  String? nationalId;
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
  //EnumPatientType? patientType;
  int? customerId;
  ApplicationUserModel? customer;
  List<LabRequestEntity>? requests;
  String? labDateOfVisit;
  String? profilePhoto;
  String? idBackPhoto;
  String? idFrontPhoto;
  int? profileImageId;
  int? idFrontImageId;
  int? idBackImageId;
  int? doctorId;
  DropDownDTO? doctor;
  String? registerationDate;
  DropDownDTO? registeredBy;

  PatientInfoModel({this.id, this.name, this.phone, this.maritalStatus,});

  PatientInfoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    doctor = DropDownDTO.fromJson(json['doctor'] ?? Map<String, dynamic>());
    doctorId = json['doctorID'];
    registeredBy = DropDownDTO.fromJson(json['registeredBy'] ?? Map<String, dynamic>());
    registerationDate =CIA_DateConverters.fromBackendToDateTime( json['registerationDate']);
    idBackImageId = json['idBackImageId'];
    idFrontImageId = json['idFrontImageId'];
    profileImageId = json['profileImageId'];
    gender = json['gender'];
    phone = json['phone'];
    nationalId = json['nationalId'];
    phone2 = json['phone2'];
    dateOfBirth = json['dateOfBirth'];
    maritalStatus = json['maritalStatus'];
    address = json['address'];
    city = json['city'];
    profilePhoto = json['profilePhoto'];
    idBackPhoto = json['idBackPhoto'];
    idFrontPhoto = json['idFrontPhoto'];
    relativePatient = json['relativePatient'] != null ? DropDownDTO.fromJson(json['relativePatient']) : DropDownDTO();
    relativePatientId = json['relativePatientId'];
    customerId = json['customerId'];
    customer = ApplicationUserModel.fromJson(json['customer'] ?? Map<String, dynamic>());
 //   requests = ((json['requests'] ?? []) as List<dynamic>).map((e) => LabRequestEntity.fromJson(e)).toList();
    labDateOfVisit = CIA_DateConverters.fromDateTimeToBackend(json['labDateOfVisit']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['idBackImageId'] = this.idBackImageId;
    data['idFrontImageId'] = this.idFrontImageId;
    data['profileImageId'] = this.profileImageId;
    data['nationalId'] = this.nationalId;
    data['id'] = this.id;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['phone2'] = this.phone2;
    data['dateOfBirth'] = this.dateOfBirth;
    data['maritalStatus'] = this.maritalStatus;
    data['address'] = this.address;
    data['city'] = this.city;
    data['relativePatientId'] = this.relativePatientId;
    data['customerId'] = this.customerId;
    data['customer'] = this.customer != null ? this.customer!.toJson() : null;
  //  data['requests'] = (this.requests ?? []).map((e) => e.toJson()).toList();
    data['labDateOfVisit'] = CIA_DateConverters.fromDateTimeToBackend(this.labDateOfVisit);

    return data;
  }

  static List<PatientInfoModel> models = <PatientInfoModel>[];
//PatientDataSource dataSource = PatientDataSource();
}

class PatientDataSource extends DataGridSource {
  List<PatientInfoModel> models = <PatientInfoModel>[];
  List<String> columns = [
    "ID",
    "Name",
    "Phone",
    "Gender",
    "Marital Stats",
    "Relative",
    "Add to my patients",
  ];

  String? search;
  String? filter;
  bool myPatients = false;

  /// Creates the patient data source class with required details.
  PatientDataSource() {
    init();
  }

  init() {
    if ((!siteController.getRole()!.contains("secretary")))
      {
        columns = [
          "ID",
          "Name",
          "Phone",
          "Gender",
          "Marital Stats",
          "Relative",
          "Add to my patients",
        ];
        _patientData = models
            .map<DataGridRow>((e) => DataGridRow(cells: [
          DataGridCell<int>(columnName: 'ID', value: e.id),
          DataGridCell<String>(columnName: 'Name', value: e.name),
          DataGridCell<String>(columnName: 'Phone', value: e.phone),
          DataGridCell<String>(columnName: 'Gender', value: e.gender),
          DataGridCell<String>(columnName: 'Marital Status', value: e.maritalStatus),
          DataGridCell<String>(columnName: 'Relative', value: e.relativePatient!.name!),
          DataGridCell<Widget>(
            columnName: 'Add to my patients',
            value: Center(
              child: e.doctorId == siteController.getUserId()
                  ? IconButton(
                icon: Icon(Icons.remove),
                onPressed: () async {
                  await PatientAPI.RemoveFromMyPatients(e.id!);
                  await loadData(myPatients: myPatients, search: search, filter: filter);
                },
              )
                  : e.doctorId == null
                  ? IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  await PatientAPI.AddToMyPatients(e.id!);
                  await loadData(myPatients: myPatients, search: search, filter: filter);
                },
              )
                  : Text(e.doctor!.name!),
            ),
          ),
        ]))
            .toList();
      }
    else
      {
        columns = [
          "ID",
          "Name",
          "Phone",
          "Gender",
          "Marital Stats",
          "Relative",
        ];
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

  }

  List<DataGridRow> _patientData = [];

  @override
  List<DataGridRow> get rows => _patientData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      if (e.value is Widget) return e.value;
      return Container(
        alignment: Alignment.center,
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  Future<bool> loadData({
    String? search,
    String? filter,
    bool myPatients = false,
  }) async {
    this.search = search;
    this.filter = filter;
    this.myPatients = myPatients;
    var res = await PatientAPI.ListPatients(search: search, filter: filter, myPatients: myPatients);
    if (res.statusCode! > 199 && res.statusCode! < 300) {
      models = res.result as List<PatientInfoModel>;
    }

    init();
    notifyListeners();
    return true;
  }
}
