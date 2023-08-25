import 'package:equatable/equatable.dart';

abstract class MedicalInfoShellBloc_State extends Equatable{}

class MedicalInfoBlocChangeViewEditState extends MedicalInfoShellBloc_State{
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