import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/domain/entities/dentalHistoryEntity.dart';
import 'package:equatable/equatable.dart';

abstract class DentalHistoryBloc_Events extends Equatable{}
class DentalHistoryBloc_GetDentalHistoryEvent extends DentalHistoryBloc_Events{
  final int patientId;
  DentalHistoryBloc_GetDentalHistoryEvent({required this.patientId});
  @override
  // TODO: implement props
  List<Object?> get props => [patientId];

}class DentalHistoryBloc_SaveDentalHistoryEvent extends DentalHistoryBloc_Events{
  final DentalHistoryEntity dentalHistoryEntity;
  DentalHistoryBloc_SaveDentalHistoryEvent({required this.dentalHistoryEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [dentalHistoryEntity];

}