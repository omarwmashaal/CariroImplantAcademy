import 'dart:typed_data';

import 'package:cariro_implant_academy/API/AuthenticationAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/Horizontal_RadioButtons.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserEntity extends Equatable {
  String? name;
  DateTime? dateOfBirth;
  String? gender;
  String? graduatedFrom;
  String? classYear;
  String? speciality;
  String? maritalStatus;
  String? address;
  String? city;
  int? idInt;
  int? registeredById;
  BasicNameIdObjectEntity? registeredBy;
  DateTime? registerationDate;
  String? id;
  String? userName;
  String? email;
  String? phoneNumber;
  int? batchId;
  BasicNameIdObjectEntity? batch;
  List<String>? roles;
  int? workPlaceId;
  BasicNameIdObjectEntity? workPlace;
  String? phoneNumber2;
  String? instagramLink;
  String? facebookLink;
  Website? workPlaceEnum;
  int? profileImageId;
  Uint8List? profileImage;
  List<Website>? accessWebsites;
  int? implantCount;

  UserEntity({
    this.name = "",
    this.roles,
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
    this.implantCount,
    this.email,
    this.profileImageId,
    this.phoneNumber,
    this.workPlaceEnum,
    this.batch,
    this.batchId,
    this.workPlace,
    this.workPlaceId,
    this.accessWebsites,
    this.instagramLink,
    this.facebookLink,
  });

  @override
  List<Object?> get props => [
        this.name,
        this.roles,
        this.instagramLink,
        this.facebookLink,
        this.dateOfBirth,
        this.gender,
        this.graduatedFrom,
        this.classYear,
        this.accessWebsites,
        this.implantCount,
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
      ];
}
/*

class ApplicationUserDataSource extends DataGridSource {
  UserRoles type;
  List<UserEntity> models = <UserEntity>[];
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
      models = response.result as List<UserEntity>;
    }
    init();
    notifyListeners();

    return true;
  }
}

class CustomerDataSource extends DataGridSource {
  List<UserEntity> models = <UserEntity>[];

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
*/
