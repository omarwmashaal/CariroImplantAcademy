import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/getUsersSessions.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc_Events.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc_States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../Constants/Controllers.dart';
import '../../../../Controllers/SiteController.dart';
import '../../../../Widgets/Horizontal_RadioButtons.dart';
import '../../../../core/injection_contianer.dart';
import '../../domain/entities/enum.dart';
import '../../domain/usecases/getUserDataUseCase.dart';
import '../../domain/usecases/resetPasswordUseCase.dart';
import '../../domain/usecases/searchUsersByRoleUseCase.dart';
import '../../domain/usecases/updateUserInfoUseCase.dart';

class UsersBloc extends Bloc<UsersBloc_Events, UsersBloc_States> {
  final GetUserDataUseCase getUserInfoUseCase;
  final SearchUsersByRoleUseCase searchUsersByRoleUseCase;
  final UpdateUserInfoUseCase updateUserInfoUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final GetUsersSessionsUseCase getUsersSessionsUseCase;
  bool edit = false;

  UsersBloc({
    required this.updateUserInfoUseCase,
    required this.searchUsersByRoleUseCase,
    required this.getUserInfoUseCase,
    required this.resetPasswordUseCase,
    required this.getUsersSessionsUseCase,
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
    on<UsersBloc_SwitchEditViewEvent>((event, emit) {
      edit = event.edit;
      emit(UsersBloc_SwitchEditViewModeState(edit: edit,user: event.user));
    },);
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

  /// Creates the visit data source class with required details.
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
                          //  await loadData();
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
                          // await UserAPI.RemoveUser(e.idInt!);
                          //  await loadData();
                        },
                      )),
                  DataGridCell<Widget>(
                      columnName: "Reset Password",
                      value: IconButton(
                        icon: Icon(Icons.lock),
                        onPressed: () async {
                          //    await AuthenticationAPI.ResetPasswordForUser(e.idInt!);
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
                        //await UserAPI.ChangeRole(e.idInt!, value.toLowerCase());
                        //   await loadData();
                      },
                    ),
                  ),
                  DataGridCell<Widget>(
                      columnName: 'Remove',
                      value: IconButton(
                        icon: Icon(Icons.delete_forever),
                        onPressed: () async {
                          // await UserAPI.RemoveUser(e.idInt!);
                          //     await loadData();
                        },
                      )),
                  DataGridCell<Widget>(
                      columnName: "Reset Password",
                      value: IconButton(
                        icon: Icon(Icons.lock),
                        onPressed: () async {
                          //   await AuthenticationAPI.ResetPasswordForUser(e.idInt!);
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
                          //   await UserAPI.RemoveUser(e.idInt!);
                          //    await loadData();
                        },
                      )),
                  DataGridCell<Widget>(
                      columnName: "Reset Password",
                      value: IconButton(
                        icon: Icon(Icons.lock),
                        onPressed: () async {
                          // await AuthenticationAPI.ResetPasswordForUser(e.idInt!);
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
                        //  await UserAPI.ChangeRole(e.idInt!, value.toLowerCase());
                        //  await loadData();
                      },
                    ),
                  ),
                  DataGridCell<Widget>(
                      columnName: 'Remove',
                      value: IconButton(
                        icon: Icon(Icons.delete_forever),
                        onPressed: () async {
                          //  await UserAPI.RemoveUser(e.idInt!);
                          //     await loadData();
                        },
                      )),
                  DataGridCell<Widget>(
                      columnName: "Reset Password",
                      value: IconButton(
                        icon: Icon(Icons.lock),
                        onPressed: () async {
                          //  await AuthenticationAPI.ResetPasswordForUser(e.idInt!);
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
