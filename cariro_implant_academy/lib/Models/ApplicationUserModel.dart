import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/Horizontal_RadioButtons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../API/UserAPI.dart';
import 'API_Response.dart';
import 'DTOs/DropDownDTO.dart';

class ApplicationUserModel {
  String? name;
  String? dateOfBirth;
  String? gender;
  String? graduatedFrom;
  String? classYear;
  String? speciality;
  String? maritalStatus;
  String? address;
  String? city;
  int? idInt;
  int? registeredById;
  DropDownDTO? registeredBy;
  String? registerationDate;
  String? id;
  String? userName;
  String? email;
  String? phoneNumber;
  int? batchId;
  DropDownDTO? batch;
  String? role;

  ApplicationUserModel({
    this.name,
    this.role,
    this.dateOfBirth,
    this.gender,
    this.graduatedFrom,
    this.classYear,
    this.speciality,
    this.maritalStatus,
    this.address,
    this.city,
    this.idInt,
    this.registeredById,
    this.registeredBy,
    this.registerationDate,
    this.id,
    this.userName,
    this.email,
    this.phoneNumber,
  });

  ApplicationUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    graduatedFrom = json['graduatedFrom'];
    classYear = json['classYear'];
    speciality = json['speciality'];
    maritalStatus = json['maritalStatus'];
    address = json['address'];
    city = json['city'];
    idInt = json['idInt'];
    registeredById = json['registeredById'];
    registeredBy = json['registeredBy'] == null ? DropDownDTO() : DropDownDTO.fromJson(json['registeredBy']);
    registerationDate = json['registerationDate'];
    try{
      id = json['id'];
    }catch(e){
      idInt = json['id'];
    }
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    batch = DropDownDTO.fromJson(json['batch']??Map<String,dynamic>());
    batchId = json['batchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['graduatedFrom'] = this.graduatedFrom;
    data['classYear'] = this.classYear;
    data['speciality'] = this.speciality;
    data['maritalStatus'] = this.maritalStatus;
    data['address'] = this.address;
    data['city'] = this.city;
    data['idInt'] = this.idInt;
    data['registeredById'] = this.registeredById;
    data['registeredBy'] = this.registeredBy;
    data['registerationDate'] = this.registerationDate;
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['batchId'] = this.batchId;
    data['batch'] = this.batch;
    data['role'] = this.role;

    return data;
  }
}

enum UserDataSourceType { Admin, Instructor, Assistant, Secretary, Candidate }

class ApplicationUserDataSource extends DataGridSource {
  UserDataSourceType type;
  List<ApplicationUserModel> models = <ApplicationUserModel>[];
  List<String> columns = [
    "ID",
    "Name",
    "Email",
    "Phone",
  ];

  /// Creates the visit data source class with required details.
  ApplicationUserDataSource({required this.type}) {
    init();
  }

  init() {
    if (siteController.getRole() == "admin") {
      if(type == UserDataSourceType.Candidate)
      {
        columns = ["ID", "Name","Batch", "Email", "Phone", "Remove"];
        _userData = models
            .map<DataGridRow>((e) => DataGridRow(cells: [
          DataGridCell<int>(columnName: 'ID', value: e.idInt),
          DataGridCell<String>(columnName: 'Name', value: e.name),
          DataGridCell<String>(columnName: 'Batch', value: e.batch!=null?e.batch!.name??"":""),
          DataGridCell<String>(columnName: 'Email', value: e.email),
          DataGridCell<String>(columnName: 'Phone', value: e.phoneNumber),

          DataGridCell<Widget>(
              columnName: 'Remove',
              value: IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () async{
                  await UserAPI.RemoveUser(e.idInt!);
                  await loadData();

                },
              )),
        ]))
            .toList();
      }
      else if(type == UserDataSourceType.Secretary)
      {
        columns = ["ID", "Name", "Email", "Phone", "Remove"];
        _userData = models
            .map<DataGridRow>((e) => DataGridRow(cells: [
          DataGridCell<int>(columnName: 'ID', value: e.idInt),
          DataGridCell<String>(columnName: 'Name', value: e.name),
          DataGridCell<String>(columnName: 'Email', value: e.email),
          DataGridCell<String>(columnName: 'Phone', value: e.phoneNumber),
          DataGridCell<Widget>(
              columnName: 'Remove',
              value: IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () async{
                  await UserAPI.RemoveUser(e.idInt!);
                  await loadData();

                },
              )),
        ]))
            .toList();
      }
      else if(type== UserDataSourceType.Assistant || type == UserDataSourceType.Instructor)
      {
          columns = ["ID", "Name", "Email", "Phone","Graduated","Class Year","Speciality", "Role", "Remove"];
          _userData = models
              .map<DataGridRow>((e) => DataGridRow(cells: [
            DataGridCell<int>(columnName: 'ID', value: e.idInt),
            DataGridCell<String>(columnName: 'Name', value: e.name),
            DataGridCell<String>(columnName: 'Email', value: e.email),
            DataGridCell<String>(columnName: 'Phone', value: e.phoneNumber),
            DataGridCell<String>(columnName: 'Graduated', value: e.graduatedFrom),
            DataGridCell<String>(columnName: 'Class Year', value: e.classYear),
            DataGridCell<String>(columnName: 'Speciality', value: e.speciality),
            DataGridCell<Widget>(
              columnName: 'Role',
              value: HorizontalRadioButtons(
                names: ["Admin", "Instructor", "Assistant"],
                groupValue: type == UserDataSourceType.Admin
                    ? "Admin"
                    : type == UserDataSourceType.Assistant
                    ? "Assistant"
                    : type == UserDataSourceType.Instructor
                    ? "Instructor"
                    : type == UserDataSourceType.Secretary
                    ? "Secretary"
                    : "",
                onChange: (value) async {
                  await UserAPI.ChangeRole(e.idInt!, value.toLowerCase());
                  await loadData();
                },
              ),
            ),
            DataGridCell<Widget>(
                columnName: 'Remove',
                value: IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: () async{
                    await UserAPI.RemoveUser(e.idInt!);
                    await loadData();

                  },
                )),
          ]))
              .toList();
        }
      else
      {
        columns = ["ID", "Name", "Email", "Phone", "Role", "Remove"];
        _userData = models
            .map<DataGridRow>((e) => DataGridRow(cells: [
          DataGridCell<int>(columnName: 'ID', value: e.idInt),
          DataGridCell<String>(columnName: 'Name', value: e.name),
          DataGridCell<String>(columnName: 'Email', value: e.email),
          DataGridCell<String>(columnName: 'Phone', value: e.phoneNumber),
          DataGridCell<Widget>(
            columnName: 'Role',
            value: HorizontalRadioButtons(
              names: ["Admin", "Instructor", "Assistant"],
              groupValue: type == UserDataSourceType.Admin
                  ? "Admin"
                  : type == UserDataSourceType.Assistant
                  ? "Assistant"
                  : type == UserDataSourceType.Instructor
                  ? "Instructor"
                  : type == UserDataSourceType.Secretary
                  ? "Secretary"
                  : "",
              onChange: (value) async {
                await UserAPI.ChangeRole(e.idInt!, value.toLowerCase());
                await loadData();
              },
            ),
          ),
          DataGridCell<Widget>(
              columnName: 'Remove',
              value: IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () async{
                  await UserAPI.RemoveUser(e.idInt!);
                  await loadData();

                },
              )),
        ]))
            .toList();
      }



    } else {
      if(type == UserDataSourceType.Candidate)
        {
          columns = ["ID", "Name","Batch", "Email", "Phone"];
          _userData = models
              .map<DataGridRow>((e) => DataGridRow(cells: [
            DataGridCell<int>(columnName: 'ID', value: e.idInt),
            DataGridCell<String>(columnName: 'Name', value: e.name),
            DataGridCell<String>(columnName: 'Batch', value: e.batch!=null?e.batch!.name??"":""),
            DataGridCell<String>(columnName: 'Email', value: e.email),
            DataGridCell<String>(columnName: 'Phone', value: e.phoneNumber),
          ]))
              .toList();
        }
      else if(type == UserDataSourceType.Secretary)
      {
        columns = ["ID", "Name", "Email", "Phone"];
        _userData = models
            .map<DataGridRow>((e) => DataGridRow(cells: [
          DataGridCell<int>(columnName: 'ID', value: e.idInt),
          DataGridCell<String>(columnName: 'Name', value: e.name),
          DataGridCell<String>(columnName: 'Email', value: e.email),
          DataGridCell<String>(columnName: 'Phone', value: e.phoneNumber),

        ]))
            .toList();
      }
      else if(type== UserDataSourceType.Assistant || type == UserDataSourceType.Instructor)
      {
        columns = ["ID", "Name", "Email", "Phone","Graduated","Class Year","Speciality"];
        _userData = models
            .map<DataGridRow>((e) => DataGridRow(cells: [
          DataGridCell<int>(columnName: 'ID', value: e.idInt),
          DataGridCell<String>(columnName: 'Name', value: e.name),
          DataGridCell<String>(columnName: 'Email', value: e.email),
          DataGridCell<String>(columnName: 'Phone', value: e.phoneNumber),
          DataGridCell<String>(columnName: 'Graduated', value: e.graduatedFrom),
          DataGridCell<String>(columnName: 'Class Year', value: e.classYear),
          DataGridCell<String>(columnName: 'Speciality', value: e.speciality),

        ]))
            .toList();
      }
      else
        {
          columns = ["ID", "Name", "Email", "Phone"];
          _userData = models
              .map<DataGridRow>((e) => DataGridRow(cells: [
            DataGridCell<int>(columnName: 'ID', value: e.idInt),
            DataGridCell<String>(columnName: 'Name', value: e.name),
            DataGridCell<String>(columnName: 'Email', value: e.email),
            DataGridCell<String>(columnName: 'Phone', value: e.phoneNumber),
          ]))
              .toList();
        }

    }
  }

  List<DataGridRow> _userData = [];

  @override
  List<DataGridRow> get rows => _userData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      if (e.value is Widget) return e.value;
      return Container(
        alignment: Alignment.center,
        child: Text(
          e.value == null ? "" : e.value.toString(),
          style: TextStyle(fontSize: 12),
        ),
      );
    }).toList());
  }

  Future<bool> loadData() async {
    late API_Response response;
    if (type == UserDataSourceType.Admin) {
      response = await UserAPI.GetAdmins();
    } else if (type == UserDataSourceType.Assistant) {
      response = await UserAPI.GetAssistants();
    } else if (type == UserDataSourceType.Instructor) {
      response = await UserAPI.GetInstructors();
    } else if (type == UserDataSourceType.Secretary) {
      response = await UserAPI.GetSecretaries();
    }else if (type == UserDataSourceType.Candidate) {
      response = await UserAPI.GetCandidates();
    }

    if (response.statusCode == 200) {
      models = response.result as List<ApplicationUserModel>;
    }
    init();
    notifyListeners();

    return true;
  }
}
