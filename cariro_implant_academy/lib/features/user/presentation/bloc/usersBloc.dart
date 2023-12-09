import 'package:cariro_implant_academy/core/features/authentication/domain/usecases/resetPasswordForUserUseCase.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/canidateDetailsEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/changeRoleUseCase.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/getCandidateDetailsUseCase.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/getUsersSessions.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc_Events.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc_States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../Constants/Controllers.dart';
import '../../../../Controllers/SiteController.dart';
import '../../../../Widgets/Horizontal_RadioButtons.dart';
import '../../../../core/injection_contianer.dart';
import '../../../patient/domain/entities/advancedPatientSearchEntity.dart';
import '../../domain/entities/enum.dart';
import '../../domain/usecases/getUserDataUseCase.dart';
import '../../domain/usecases/resetPasswordUseCase.dart';
import '../../domain/usecases/searchUsersByRoleUseCase.dart';
import '../../domain/usecases/searchUsersByWorkPlaceUseCase.dart';
import '../../domain/usecases/updateUserInfoUseCase.dart';

class UsersBloc extends Bloc<UsersBloc_Events, UsersBloc_States> {
  final GetUserDataUseCase getUserInfoUseCase;
  final SearchUsersByRoleUseCase searchUsersByRoleUseCase;
  final SearchUsersByWorkPlaceUseCase searchUsersByWorkPlaceUseCase;
  final UpdateUserInfoUseCase updateUserInfoUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final GetUsersSessionsUseCase getUsersSessionsUseCase;
  final ResetPasswordForUserUseCase resetPasswordForUserUseCase;
  final ChangeRoleUseCase changeRoleUseCase;
  final GetCandidateDetailsUseCase getCandidateDetailsUseCase;
  bool edit = false;

  UsersBloc({
    required this.updateUserInfoUseCase,
    required this.searchUsersByRoleUseCase,
    required this.getUserInfoUseCase,
    required this.resetPasswordUseCase,
    required this.getUsersSessionsUseCase,
    required this.changeRoleUseCase,
    required this.searchUsersByWorkPlaceUseCase,
    required this.resetPasswordForUserUseCase,
    required this.getCandidateDetailsUseCase,
  }) : super(UsersBloc_LoadingUserState()) {
    on<UsersBloc_GetUserInfoEvent>(
      (event, emit) async {
        emit(UsersBloc_LoadingUserState());
        final result = await getUserInfoUseCase(event.id);
        result.fold(
          (l) => emit(UsersBloc_LoadingUserErrorState(message: l.message ?? "")),
          (r) => emit(UsersBloc_LoadedSingleUserSuccessfullyState(userData: r)),
        );
      },
    );
    on<UsersBloc_SearchUsersByRoleEvent>(
      (event, emit) async {
        emit(UsersBloc_LoadingUserState());
        final result = await searchUsersByRoleUseCase(SearchUsersByRoleParams(
          role: event.role.name,
          search: event.search,
          batch: event.batchId,
        ));
        result.fold(
          (l) => emit(UsersBloc_LoadingUserErrorState(message: l.message ?? "")),
          (r) => emit(UsersBloc_LoadedMultiUsersSuccessfullyState(usersData: r)),
        );
      },
    );
    on<UsersBloc_GetCandidateDetailsEvent>(
      (event, emit) async {
        emit(UsersBloc_LoadingCandidateDetailsState());
        final result = await getCandidateDetailsUseCase(event.params);
        result.fold(
          (l) => emit(UsersBloc_LoadingCandidateDetailsErrorState(message: l.message ?? "")),
          (r) => emit(UsersBloc_LoadedCandidateDetailsSuccessfullyState(data: r)),
        );
      },
    );
    on<UsersBloc_SearchUsersByWorkPlaceEvent>(
      (event, emit) async {
        emit(UsersBloc_LoadingUserState());
        final result = await searchUsersByWorkPlaceUseCase(event.params);
        result.fold(
          (l) => emit(UsersBloc_LoadingUserErrorState(message: l.message ?? "")),
          (r) => emit(UsersBloc_LoadedMultiUsersSuccessfullyState(usersData: r)),
        );
      },
    );
    on<UsersBloc_UpdateUserInfoEvent>(
      (event, emit) async {
        emit(UsersBloc_UpdatingUserInfoState());
        final result = await updateUserInfoUseCase(UpdateUserInfoParams(
          id: event.id,
          userData: event.userData,
        ));
        result.fold(
          (l) => emit(UsersBloc_UpdatingUserInfoErrorState(message: l.message ?? "")),
          (r) => emit(UsersBloc_UpdatedUserInfoSuccessfullyState()),
        );
      },
    );

    on<UsersBloc_ResetPasswordEvent>(
      (event, emit) async {
        emit(UsersBloc_ResettingPasswordState());
        final result = await resetPasswordUseCase(event.params);
        result.fold(
          (l) => emit(UsersBloc_ResettingPasswordErrorState(message: l.message ?? "")),
          (r) => emit(UsersBloc_ResetPasswordSuccessfullyState()),
        );
      },
    );
    on<UsersBloc_GetSessionsDurationEvent>(
      (event, emit) async {
        emit(UsersBloc_LoadingSessionsState());
        final result = await getUsersSessionsUseCase(event.params);
        result.fold(
          (l) => emit(UsersBloc_LoadingSessionsErrorState(message: l.message ?? "")),
          (r) => emit(UsersBloc_LoadedSessionsSuccessfullyState(sessions: r)),
        );
      },
    );
    on<UsersBloc_SwitchEditViewEvent>(
      (event, emit) {
        edit = event.edit;
        emit(UsersBloc_SwitchEditViewModeState(edit: edit, user: event.user));
      },
    );

    on<UsersBloc_ResetPasswordForUserEvent>(
      (event, emit) async {
        emit(UsersBloc_ResettingPasswordForUserState());
        final result = await resetPasswordForUserUseCase(event.id);
        result.fold(
          (l) => emit(UsersBloc_ResettingPasswordForUserErrorState(message: l.message ?? "")),
          (r) => emit(UsersBloc_ResetPasswordForUserSuccessfullyState()),
        );
      },
    );
    on<UsersBloc_ChangeRoleEvent>(
      (event, emit) async {
        emit(UsersBloc_ChangingRoleState());
        final result = await changeRoleUseCase(event.params);
        result.fold(
          (l) => emit(UsersBloc_ChangingRoleErrorState(message: l.message ?? "")),
          (r) => emit(UsersBloc_ChangedRoleSuccessfullyState()),
        );
      },
    );
  }
}

class UsersDataGridSource extends DataGridSource {
  UserRoles type;
  UsersBloc usersBloc;
  List<UserEntity> models = <UserEntity>[];
  List<String> columns = [
    "ID",
    "Name",
    "Email",
    "Phone",
  ];

  ///Creates the visit data source class with required details.
  UsersDataGridSource({
    required this.type,
    required this.usersBloc,
  }) {
    init();
  }

  init() {
    String? role = siteController.getRole();
    if (role == "admin") {
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
                          //await UserAPI.RemoveUser(e.idInt!);
                          //await loadData();
                        },
                      )),
                ]))
            .toList();
      }
      else if (type == UserRoles.Secretary) {
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
                          //await UserAPI.RemoveUser(e.idInt!);
                          //await loadData();
                        },
                      )),
                  DataGridCell<Widget>(
                      columnName: "Reset Password",
                      value: IconButton(
                        icon: Icon(Icons.lock),
                        onPressed: () async {
                          usersBloc.add(UsersBloc_ResetPasswordForUserEvent(id: e.idInt!));
                        },
                      )),
                ]))
            .toList();
      }
      else if (type == UserRoles.Assistant || type == UserRoles.Instructor) {
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
                        usersBloc.add(UsersBloc_ChangeRoleEvent(params: ChangeRoleParams(role: value.toLowerCase(), id: e.idInt!)));
                        //await loadData();
                      },
                    ),
                  ),
                  DataGridCell<Widget>(
                      columnName: 'Remove',
                      value: IconButton(
                        icon: Icon(Icons.delete_forever),
                        onPressed: () async {
                          //await UserAPI.RemoveUser(e.idInt!);
                          //await loadData();
                        },
                      )),
                  DataGridCell<Widget>(
                      columnName: "Reset Password",
                      value: IconButton(
                        icon: Icon(Icons.lock),
                        onPressed: () async {
                          usersBloc.add(UsersBloc_ResetPasswordForUserEvent(id: e.idInt!));
                        },
                      )),
                ]))
            .toList();
      }
      else if (type == UserRoles.Technician || type == UserRoles.OutSource || type == UserRoles.LabModerator) {
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
                          //await UserAPI.RemoveUser(e.idInt!);
                          //await loadData();
                        },
                      )),
                  DataGridCell<Widget>(
                      columnName: "Reset Password",
                      value: IconButton(
                        icon: Icon(Icons.lock),
                        onPressed: () async {
                          usersBloc.add(UsersBloc_ResetPasswordForUserEvent(id: e.idInt!));
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
                        usersBloc.add(UsersBloc_ChangeRoleEvent(params: ChangeRoleParams(role: value.toLowerCase(), id: e.idInt!)));
                        //await loadData();
                      },
                    ),
                  ),
                  DataGridCell<Widget>(
                      columnName: 'Remove',
                      value: IconButton(
                        icon: Icon(Icons.delete_forever),
                        onPressed: () async {
                          //await UserAPI.RemoveUser(e.idInt!);
                          //await loadData();
                        },
                      )),
                  DataGridCell<Widget>(
                      columnName: "Reset Password",
                      value: IconButton(
                        icon: Icon(Icons.lock),
                        onPressed: () async {
                          usersBloc.add(UsersBloc_ResetPasswordForUserEvent(id: e.idInt!));
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

  Future<bool> updateData({required List<UserEntity> newData}) async {
    models = newData;
    init();
    notifyListeners();

    return true;
  }
}



class CandidateDetailsDataSource extends DataGridSource {
  List<CandidateDetailsEntity> models = <CandidateDetailsEntity>[];

  List<String> columns = [
    "Patient Id",
    "Patient Name",
    "Procedures",
    "Tooth",
    "Date",
    "Implant",
    // "Implant Count",
    //"Other Procedures",
    "Total Implant Counts",
  ];

  /// Creates the visit data source class with required details.
  CandidateDetailsDataSource() {
    init();
  }
  init() {

    _userData = models
        .map<DataGridRow>((e) =>
        DataGridRow(cells: [
          DataGridCell<int>(columnName: 'Id', value: e.patientId),
          DataGridCell<String>(columnName: 'Patient Name', value: e.patient?.name),
          DataGridCell<String>(columnName: 'Procedures', value: e.procedure),
          DataGridCell<int>(columnName: 'Tooth', value: e.tooth),
          DataGridCell<DateTime>(columnName: 'Date', value: e.date),
          DataGridCell<String>(columnName: 'Implant', value: e.implant?.size),
          DataGridCell<int>(columnName: 'Implant Count', value: e.implantCount),
          // DataGridCell<List<String>>(columnName: 'Other Procedures', value: e.otherProcedures),
          // DataGridCell<int>(columnName: 'Total Implant Counts', value: e.totalImplantCounts),

        ]))
        .toList();
  }

  List<DataGridRow> _userData = [];

  @override
  List<DataGridRow> get rows => _userData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          var returnedValue = e.value;
          if (returnedValue is Widget) return returnedValue;
          if(e.columnName=="Date")returnedValue = DateFormat("dd-MM-yyyy").format(e.value);
          return Container(
            alignment: Alignment.center,
            child: Text(
              returnedValue == null ? "" : returnedValue.toString(),
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          );
        }).toList());
  }

  Future<bool> loadData(List<CandidateDetailsEntity> data) async {

    models = data;
    init();
    notifyListeners();

    return true;
  }

}


