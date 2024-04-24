import 'package:cariro_implant_academy/features/patient/domain/entities/todoListEntity.dart';

abstract class ToDoListBloc_States {}

class ToDoListBlocState_InitState extends ToDoListBloc_States {}

class ToDoListBlocState_GettingDataState extends ToDoListBloc_States {}

class ToDoListBlocState_GettingDataFailed extends ToDoListBloc_States {
  final String message;
  ToDoListBlocState_GettingDataFailed({required this.message});
}

class ToDoListBlocState_GettingDataSuccess extends ToDoListBloc_States {
  final List<ToDoListEntity> data;
  ToDoListBlocState_GettingDataSuccess({required this.data});
}

class ToDoListBlocState_UpdatingDataState extends ToDoListBloc_States {}

class ToDoListBlocState_UpdatingDataFailed extends ToDoListBloc_States {
  final String message;
  ToDoListBlocState_UpdatingDataFailed({required this.message});
}

class ToDoListBlocState_UpdatingDataSuccess extends ToDoListBloc_States {}

class ToDoListBlocState_AddingDataState extends ToDoListBloc_States {}

class ToDoListBlocState_AddingDataFailed extends ToDoListBloc_States {
  final String message;
  ToDoListBlocState_AddingDataFailed({required this.message});
}

class ToDoListBlocState_AddingDataSuccess extends ToDoListBloc_States {}
