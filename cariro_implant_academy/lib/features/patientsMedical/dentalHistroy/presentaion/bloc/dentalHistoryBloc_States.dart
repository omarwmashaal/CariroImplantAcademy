import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/domain/entities/dentalHistoryEntity.dart';
import 'package:equatable/equatable.dart';

abstract class DentalHistoryBloc_States extends Equatable{}

class DentalHistoryBloc_InitialState extends DentalHistoryBloc_States{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}class DentalHistoryBloc_LoadingDataState extends DentalHistoryBloc_States{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}class DentalHistoryBloc_SavingDataState extends DentalHistoryBloc_States{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}class DentalHistoryBloc_SavedDataSuccessfullyState extends DentalHistoryBloc_States{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class DentalHistoryBloc_DataLoadedSuccessfullyState extends DentalHistoryBloc_States{
  final DentalHistoryEntity dentalHistoryEntity;
  DentalHistoryBloc_DataLoadedSuccessfullyState({required this.dentalHistoryEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [dentalHistoryEntity];

}
class DentalHistoryBloc_ErrorState extends DentalHistoryBloc_States{
  final String message;
  DentalHistoryBloc_ErrorState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];

}