import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/complainEntity.dart';
import 'package:equatable/equatable.dart';

abstract class ComplainsBloc_Events extends Equatable {}

class ComplainsBloc_AddComplainEvent extends ComplainsBloc_Events {
  final ComplainsEntity complainsEntity;

  ComplainsBloc_AddComplainEvent({required this.complainsEntity});

  @override
  List<Object?> get props => [complainsEntity];
}

class ComplainsBloc_ResolveComplainEvent extends ComplainsBloc_Events {
  final int complainId;

  ComplainsBloc_ResolveComplainEvent({required this.complainId});

  @override
  List<Object?> get props => [complainId];
}

class ComplainsBloc_InqueueComplainEvent extends ComplainsBloc_Events {
  final int complainId;
  final String?  notes;

  ComplainsBloc_InqueueComplainEvent({required this.complainId,this.notes,});

  @override
  List<Object?> get props => [complainId,notes];
}
class ComplainsBloc_UpdateComplainNotesEvent extends ComplainsBloc_Events {
  final int complainId;
  final String?  notes;

  ComplainsBloc_UpdateComplainNotesEvent({required this.complainId,this.notes,});

  @override
  List<Object?> get props => [complainId,notes];
}

class ComplainsBloc_GetComplainsEvent extends ComplainsBloc_Events {
  final int? patientId;
  final String? search;
  final EnumComplainStatus? status;

  ComplainsBloc_GetComplainsEvent({
     this.patientId,
     this.status,
     this.search,
  });

  @override
  List<Object?> get props => [
        patientId,
        status,
        search,
      ];
}
