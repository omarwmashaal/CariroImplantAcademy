import 'package:equatable/equatable.dart';

abstract class MedicalInfoShellBloc_Event extends Equatable{}

class MedicalInfoShell_ChangeTitleEvent extends MedicalInfoShellBloc_Event{
  final String title;
  MedicalInfoShell_ChangeTitleEvent({required this.title});
  @override
  List<Object?> get props => [title];
}
class MedicalInfoShell_ChangeViewEditEvent extends MedicalInfoShellBloc_Event{
  final bool allowEdit;
  MedicalInfoShell_ChangeViewEditEvent({required this.allowEdit});
  @override
  List<Object?> get props => [allowEdit];
}