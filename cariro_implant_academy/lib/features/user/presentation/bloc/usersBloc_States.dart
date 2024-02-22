import 'package:cariro_implant_academy/features/patient/domain/entities/visitEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/canidateDetailsEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:equatable/equatable.dart';

abstract class UsersBloc_States extends Equatable {}

class UsersBloc_ResettingPasswordState extends UsersBloc_States {
  @override
  List<Object?> get props => [];
}
class UsersBloc_LoadingCandidateDetailsState extends UsersBloc_States {
  @override
  List<Object?> get props => [];
}
class UsersBloc_LoadedCandidateDetailsSuccessfullyState extends UsersBloc_States {
  final List<CandidateDetailsEntity>data ;
  UsersBloc_LoadedCandidateDetailsSuccessfullyState({required this.data});
  @override
  List<Object?> get props => [];
}
class UsersBloc_LoadingCandidateDetailsErrorState extends UsersBloc_States {
  final String message;
  UsersBloc_LoadingCandidateDetailsErrorState({required this.message});
  @override
  List<Object?> get props => [];
}

class UsersBloc_ResetPasswordSuccessfullyState extends UsersBloc_States {
  @override
  List<Object?> get props => [];
}

class UsersBloc_ResettingPasswordErrorState extends UsersBloc_States {
  final String message;

  UsersBloc_ResettingPasswordErrorState({required this.message});

  @override
  List<Object?> get props => [message,identityHashCode(this)];
}
class UsersBloc_RemovedUserSuccessfullyState extends UsersBloc_States {
  @override
  List<Object?> get props => [];
}

class UsersBloc_RemovingUserState extends UsersBloc_States {
  @override
  List<Object?> get props => [];
}

class UsersBloc_RemovingUserErrorState extends UsersBloc_States {
  final String message;

  UsersBloc_RemovingUserErrorState({required this.message});

  @override
  List<Object?> get props => [message,identityHashCode(this)];
}
class UsersBloc_RefreshedCandidatesDataSuccessfullyState extends UsersBloc_States {
  @override
  List<Object?> get props => [];
}

class UsersBloc_RefreshingCandidateDatatate extends UsersBloc_States {
  @override
  List<Object?> get props => [];
}

class UsersBloc_RefreshingCandidateDataErrorState extends UsersBloc_States {
  final String message;

  UsersBloc_RefreshingCandidateDataErrorState({required this.message});

  @override
  List<Object?> get props => [message,identityHashCode(this)];
}
class UsersBloc_ChangingRoleState extends UsersBloc_States {
  @override
  List<Object?> get props => [];
}

class UsersBloc_ChangedRoleSuccessfullyState extends UsersBloc_States {
  @override
  List<Object?> get props => [];
}

class UsersBloc_ChangingRoleErrorState extends UsersBloc_States {
  final String message;

  UsersBloc_ChangingRoleErrorState({required this.message});

  @override
  List<Object?> get props => [message,identityHashCode(this)];
}
class UsersBloc_ResettingPasswordForUserState extends UsersBloc_States {
  @override
  List<Object?> get props => [];
}

class UsersBloc_ResetPasswordForUserSuccessfullyState extends UsersBloc_States {
  @override
  List<Object?> get props => [];
}

class UsersBloc_ResettingPasswordForUserErrorState extends UsersBloc_States {
  final String message;

  UsersBloc_ResettingPasswordForUserErrorState({required this.message});

  @override
  List<Object?> get props => [message,identityHashCode(this)];
}

class UsersBloc_LoadingUserState extends UsersBloc_States {
  @override
  List<Object?> get props => [];
}

class UsersBloc_LoadingSessionsState extends UsersBloc_States {
  @override
  List<Object?> get props => [];
}

class UsersBloc_UpdatingUserInfoState extends UsersBloc_States {
  @override
  List<Object?> get props => [];
}

class UsersBloc_UpdatedUserInfoSuccessfullyState extends UsersBloc_States {
  @override
  List<Object?> get props => [];
}

class UsersBloc_UpdatingUserInfoErrorState extends UsersBloc_States {
  final String message;

  UsersBloc_UpdatingUserInfoErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class UsersBloc_LoadingUserErrorState extends UsersBloc_States {
  final String message;

  UsersBloc_LoadingUserErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
class UsersBloc_LoadingSessionsErrorState extends UsersBloc_States {
  final String message;

  UsersBloc_LoadingSessionsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class UsersBloc_LoadedSessionsSuccessfullyState extends UsersBloc_States {
  final List<VisitEntity> sessions;

  UsersBloc_LoadedSessionsSuccessfullyState({required this.sessions});

  @override
  List<Object?> get props => [sessions];
}
class UsersBloc_LoadedSingleUserSuccessfullyState extends UsersBloc_States {
  final UserEntity userData;

  UsersBloc_LoadedSingleUserSuccessfullyState({required this.userData});

  @override
  List<Object?> get props => [userData];
}

class UsersBloc_LoadedMultiUsersSuccessfullyState extends UsersBloc_States {
  final List<UserEntity> usersData;

  UsersBloc_LoadedMultiUsersSuccessfullyState({required this.usersData});

  @override
  List<Object?> get props => [usersData];
}

class UsersBloc_SwitchEditViewModeState extends UsersBloc_States {
  final bool edit;
  final UserEntity user;
  UsersBloc_SwitchEditViewModeState({required this.edit,required this.user});
  @override
  List<Object?> get props => [edit,user];
}
