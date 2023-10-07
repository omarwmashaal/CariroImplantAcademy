import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:equatable/equatable.dart';

abstract class MedicalPagesStatesChangesBloc_States extends Equatable{}

class Initial extends MedicalPagesStatesChangesBloc_States{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ChangeSmokingStatusState extends MedicalPagesStatesChangesBloc_States{
  final SmokingStatus smokingStatus;
  ChangeSmokingStatusState({required this.smokingStatus});
  @override
  // TODO: implement props
  List<Object?> get props => [smokingStatus];
}