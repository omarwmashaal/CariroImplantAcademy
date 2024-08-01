import 'package:cariro_implant_academy/API/AuthenticationAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/Horizontal_RadioButtons.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../API/UserAPI.dart';
import '../features/user/domain/entities/enum.dart';
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
  int? workPlaceId;
  DropDownDTO? workPlace;
  String? phoneNumber2;
  Website? workPlaceEnum;
  int? profileImageId;

  ApplicationUserModel({
    this.name = "",
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
    this.profileImageId,
    this.phoneNumber,
    this.workPlaceEnum,
  });

  ApplicationUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImageId = json['profileImageId'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    graduatedFrom = json['graduatedFrom'];
    classYear = json['classYear'];
    speciality = json['speciality'];
    maritalStatus = json['maritalStatus'];
    address = json['address'];
    city = json['city'];
    idInt = json['idInt'];
    if (idInt == null)
      try {
        idInt = json['id'];
      } catch (e) {}
    ;
    try {
      id = json['id'];
    } catch (e) {
      id = json['idInt'];
    }

    registeredById = json['registeredById'];
    registeredBy = json['registeredBy'] == null ? DropDownDTO() : DropDownDTO.fromJson(json['registeredBy']);
    registerationDate = CIA_DateConverters.fromBackendToDateTime(json['registerationDate']);
    workPlaceEnum = Website.values[json['workPlaceEnum'] ?? 0];
    /*try{
      id = json['id'];
    }catch(e){
      idInt = json['id'];
    }*/
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    batch = DropDownDTO.fromJson(json['batch'] ?? Map<String, dynamic>());
    batchId = json['batchId'];
    phoneNumber2 = json['phoneNumber2'];
    workPlace = DropDownDTO.fromJson(json['workPlace'] ?? Map<String, dynamic>());
    workPlaceId = json['workPlaceId'];
    role = json['role'];
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
    data['id'] = this.id;
    //data['registeredById'] = this.registeredById;
    // data['registeredBy'] = this.registeredBy;
    data['registerationDate'] = this.registerationDate;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['batchId'] = this.batchId;
    data['batch'] = this.batch;
    data['role'] = this.role ?? "";
    data['phoneNumber2'] = this.phoneNumber2;
    data['workPlace'] = this.workPlace != null ? this.workPlace!.toJson() : null;
    data['workPlaceId'] = this.workPlaceId;
    data['workPlaceEnum'] = (this.workPlaceEnum ?? Website.CIA).index;
    return data;
  }
}

class ApplicationUserDataSource extends DataGridSource {
  UserRoles type;
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
    if (siteController.getRole()!.contains("admin")) {
      if (type == UserRoles.Candidate) {
        columns = ["ID", "Name", "Batch", "Email", "Phone", "Remove"];
        _userData = models
            .map<DataGridRow>((e) => DataGridRow(cells: [
                  DataGridCell<int>(columnName: 'ID', value: e.idInt),
                  DataGridCell<String>(columnName: 'Name', value: e.name),
                  DataGridCell<String>(columnName: 'Batch', value: e.batch != null ? e.batch!.name ?? "" : ""),
                  DataGridCell<String>(columnName: 'Email', value: e.email),
                  DataGridCell<String>(columnName: 'Phone', value: e.phoneNumber),
                  DataGridCell<Widget>(
                      columnName: 'Remove',
                      value: IconButton(
                        icon: Icon(Icons.delete_forever),
                        onPressed: () async {
                          await UserAPI.RemoveUser(e.idInt!);
                          await loadData();
                        },
                      )),
                ]))
            .toList();
      } else if (type == UserRoles.Secretary) {
        columns = ["ID", "Name", "Email", "Phone", "Remove", "Reset Password"];
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
                        onPressed: () async {
                          await UserAPI.RemoveUser(e.idInt!);
                          await loadData();
                        },
                      )),
                  DataGridCell<Widget>(
                      columnName: "Reset Password",
                      value: IconButton(
                        icon: Icon(Icons.lock),
                        onPressed: () async {
                          await AuthenticationAPI.ResetPasswordForUser(e.idInt!);
                        },
                      )),
                ]))
            .toList();
      } else if (type == UserRoles.Assistant || type == UserRoles.Instructor) {
        columns = ["ID", "Name", "Email", "Phone", "Graduated", "Class Year", "Speciality", "Role", "Remove", "Reset Password"];
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
                      groupValue: type == UserRoles.Admin
                          ? "Admin"
                          : type == UserRoles.Assistant
                              ? "Assistant"
                              : type == UserRoles.Instructor
                                  ? "Instructor"
                                  : type == UserRoles.Secretary
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
                        onPressed: () async {
                          await UserAPI.RemoveUser(e.idInt!);
                          await loadData();
                        },
                      )),
                  DataGridCell<Widget>(
                      columnName: "Reset Password",
                      value: IconButton(
                        icon: Icon(Icons.lock),
                        onPressed: () async {
                          await AuthenticationAPI.ResetPasswordForUser(e.idInt!);
                        },
                      )),
                ]))
            .toList();
      } else if (type == UserRoles.Technician || type == UserRoles.OutSource || type == UserRoles.LabModerator) {
        columns = ["ID", "Name", "Email", "Phone", "Remove", "Reset Password"];
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
                        onPressed: () async {
                          await UserAPI.RemoveUser(e.idInt!);
                          await loadData();
                        },
                      )),
                  DataGridCell<Widget>(
                      columnName: "Reset Password",
                      value: IconButton(
                        icon: Icon(Icons.lock),
                        onPressed: () async {
                          await AuthenticationAPI.ResetPasswordForUser(e.idInt!);
                        },
                      )),
                ]))
            .toList();
      } else {
        columns = ["ID", "Name", "Email", "Phone", "Role", "Remove", "Reset Password"];
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
                      groupValue: type == UserRoles.Admin
                          ? "Admin"
                          : type == UserRoles.Assistant
                              ? "Assistant"
                              : type == UserRoles.Instructor
                                  ? "Instructor"
                                  : type == UserRoles.Secretary
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
                        onPressed: () async {
                          await UserAPI.RemoveUser(e.idInt!);
                          await loadData();
                        },
                      )),
                  DataGridCell<Widget>(
                      columnName: "Reset Password",
                      value: IconButton(
                        icon: Icon(Icons.lock),
                        onPressed: () async {
                          await AuthenticationAPI.ResetPasswordForUser(e.idInt!);
                        },
                      )),
                ]))
            .toList();
      }
    } else {
      if (type == UserRoles.Candidate) {
        columns = ["ID", "Name", "Batch", "Email", "Phone"];
        _userData = models
            .map<DataGridRow>((e) => DataGridRow(cells: [
                  DataGridCell<int>(columnName: 'ID', value: e.idInt),
                  DataGridCell<String>(columnName: 'Name', value: e.name),
                  DataGridCell<String>(columnName: 'Batch', value: e.batch != null ? e.batch!.name ?? "" : ""),
                  DataGridCell<String>(columnName: 'Email', value: e.email),
                  DataGridCell<String>(columnName: 'Phone', value: e.phoneNumber),
                ]))
            .toList();
      } else if (type == UserRoles.Secretary) {
        columns = ["ID", "Name", "Email", "Phone"];
        _userData = models
            .map<DataGridRow>((e) => DataGridRow(cells: [
                  DataGridCell<int>(columnName: 'ID', value: e.idInt),
                  DataGridCell<String>(columnName: 'Name', value: e.name),
                  DataGridCell<String>(columnName: 'Email', value: e.email),
                  DataGridCell<String>(columnName: 'Phone', value: e.phoneNumber),
                ]))
            .toList();
      } else if (type == UserRoles.Assistant || type == UserRoles.Instructor) {
        columns = ["ID", "Name", "Email", "Phone", "Graduated", "Class Year", "Speciality"];
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
      } else if (type == UserRoles.Technician || type == UserRoles.OutSource) {
        columns = ["ID", "Name", "Email", "Phone"];
        _userData = models
            .map<DataGridRow>((e) => DataGridRow(cells: [
                  DataGridCell<int>(columnName: 'ID', value: e.idInt),
                  DataGridCell<String>(columnName: 'Name', value: e.name),
                  DataGridCell<String>(columnName: 'Email', value: e.email),
                  DataGridCell<String>(columnName: 'Phone', value: e.phoneNumber),
                ]))
            .toList();
      } else {
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

  Future<bool> loadData({int? batch, String? search}) async {
    late API_Response response;

    response = await UserAPI.SearcshUsersByRole(search: search, role: type, batch: batch);

    if (response.statusCode == 200) {
      models = response.result as List<ApplicationUserModel>;
    }
    init();
    notifyListeners();

    return true;
  }
}

class CustomerDataSource extends DataGridSource {
  List<ApplicationUserModel> models = <ApplicationUserModel>[];

  /// Creates the customer data source class with required details.
  CustomerDataSource() {
    _customerData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.idInt),
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<String>(columnName: 'Phone', value: e.phoneNumber),
              DataGridCell<String>(columnName: 'Clinic Name', value: e.workPlace!.name),
            ]))
        .toList();
  }

  List<DataGridRow> _customerData = [];

  @override
  List<DataGridRow> get rows => _customerData;

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
