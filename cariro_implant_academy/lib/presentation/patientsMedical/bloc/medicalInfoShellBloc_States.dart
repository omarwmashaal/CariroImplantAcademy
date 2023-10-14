import 'package:equatable/equatable.dart';

abstract class MedicalInfoShellBloc_State extends Equatable{}

class MedicalInfoBlocInitState extends MedicalInfoShellBloc_State{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}class MedicalInfoBlocChangeViewEditState extends MedicalInfoShellBloc_State{
  final bool edit;
  MedicalInfoBlocChangeViewEditState({required this.edit});

  @override
  // TODO: implement props
  List<Object?> get props => [edit];
}
class MedicalInfoBlocChangeTitleState extends MedicalInfoShellBloc_State{
  final String title;
  MedicalInfoBlocChangeTitleState({required this.title});

  @override
  // TODO: implement props
  List<Object?> get props => [title];
}
class MedicalInfoBlocChangeDateState extends MedicalInfoShellBloc_State{
  final DateTime? date;
  final dynamic? data;
  MedicalInfoBlocChangeDateState({required this.date,required this.data});

  @override
  // TODO: implement props
  List<Object?> get props => [date,identityHashCode(this)];
}