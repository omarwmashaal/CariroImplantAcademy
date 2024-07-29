import 'package:cariro_implant_academy/Widgets/CIA_CheckBoxWidget.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/todoListEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/searchToDoListUseCase%20.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cariro_implant_academy/features/patient/domain/usecases/addToDoListItemUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getToDoListUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/updateToDoListItemUseCase.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/toDoListBloc_States.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:collection/collection.dart';

class ToDoListBloc extends Cubit<ToDoListBloc_States> {
  final GetToDoListUseCase getToDoListUseCase;
  final SearchToDoListUseCase searchToDoListUseCase;
  final UpdateToDoListItemUseCase updateToDoListItemUseCase;
  final AddToDoListItemUseCase addToDoListItemUseCase;
  ToDoListBloc({
    required this.getToDoListUseCase,
    required this.searchToDoListUseCase,
    required this.updateToDoListItemUseCase,
    required this.addToDoListItemUseCase,
  }) : super(ToDoListBlocState_InitState());

  getToList(int? patientId) async {
    emit(ToDoListBlocState_GettingDataState());
    final result = await getToDoListUseCase(patientId);
    result.fold(
      (l) => emit(ToDoListBlocState_GettingDataFailed(message: l.message ?? "")),
      (r) => emit(ToDoListBlocState_GettingDataSuccess(data: r)),
    );
  }

  searchToList(SearchToDoListParams params) async {
    emit(ToDoListBlocState_GettingDataState());
    final result = await searchToDoListUseCase(params);
    result.fold(
      (l) => emit(ToDoListBlocState_GettingDataFailed(message: l.message ?? "")),
      (r) => emit(ToDoListBlocState_GettingDataSuccess(data: r)),
    );
  }

  updateToListItem(ToDoListEntity toDoListEntity, bool delete) async {
    emit(ToDoListBlocState_UpdatingDataState());
    final result = await updateToDoListItemUseCase(UpdateToDoListItemParams(toDoListEntity: toDoListEntity, delete: delete));
    result.fold(
      (l) => emit(ToDoListBlocState_UpdatingDataFailed(message: l.message ?? "")),
      (r) => emit(ToDoListBlocState_UpdatingDataSuccess()),
    );
  }

  addToDoListItem(ToDoListEntity toDoListEntity) async {
    emit(ToDoListBlocState_AddingDataState());
    final result = await addToDoListItemUseCase(toDoListEntity);
    result.fold(
      (l) => emit(ToDoListBlocState_AddingDataFailed(message: l.message ?? "")),
      (r) => emit(ToDoListBlocState_AddingDataSuccess()),
    );
  }
}

class ToDoListDataGridSource extends DataGridSource {
  BuildContext context;
  ToDoListBloc toDoListBloc;
  List<ToDoListEntity> models = [];

  ToDoListDataGridSource(this.context, this.toDoListBloc);

  init(List<ToDoListEntity> _models) {
    models = _models;
    _toDoListItems = models
        .mapIndexed<DataGridRow>((i, e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'Id', value: e.patientId),
              DataGridCell<String>(columnName: 'Patient', value: e.patient?.name),
              DataGridCell<Widget>(
                columnName: 'Delete',
                value: IconButton(
                  onPressed: () {
                    toDoListBloc.updateToListItem(e, true);
                  },
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                ),
              ),
              DataGridCell<Widget>(
                columnName: 'Data',
                value: CIA_CheckBoxWidget(
                  text: e.data,
                  value: e.done,
                  onChange: (value) {
                    e.done = value;
                    toDoListBloc.updateToListItem(e, false);
                  },
                ),
              ),
              DataGridCell<DateTime>(columnName: 'Create Date', value: e.createDate),
              DataGridCell<DateTime>(columnName: 'Due Date', value: e.dueDate),
            ]))
        .toList();
  }

  List<DataGridRow> _toDoListItems = [];

  @override
  List<DataGridRow> get rows => _toDoListItems;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      if (e.value is Widget) return e.value;
      return Container(
        alignment: Alignment.center,
        child: Text(e.value is DateTime && e.value != null ? DateFormat("dd-MM-yyyy").format(e.value) : e.value.toString()),
      );
    }).toList());
  }
}
