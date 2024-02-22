import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/resetPasswordUseCase.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/searchUsersByWorkPlaceUseCase.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums/enums.dart';
import '../../domain/entities/enum.dart';
import '../../domain/usecases/changeRoleUseCase.dart';
import '../../domain/usecases/getCandidateDetailsUseCase.dart';
import '../../domain/usecases/getUsersSessions.dart';

abstract class UsersBloc_Events extends Equatable {}

class UsersBloc_SwitchEditViewEvent extends UsersBloc_Events {
  final bool edit;
  final UserEntity user;

  UsersBloc_SwitchEditViewEvent({required this.edit, required this.user});

  @override
  List<Object?> get props => [edit, user];
}

class UsersBloc_GetUserInfoEvent extends UsersBloc_Events {
  final int id;

  UsersBloc_GetUserInfoEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
class UsersBloc_RemoveUserEvent extends UsersBloc_Events {
  final int id;

  UsersBloc_RemoveUserEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
class UsersBloc_RefreshCandidatesDataEvent extends UsersBloc_Events {

  final int? batchId;
  UsersBloc_RefreshCandidatesDataEvent({this.batchId});
  @override
  List<Object?> get props => [batchId];
}

class UsersBloc_GetCandidateDetailsEvent extends UsersBloc_Events {
  final GetCandidateDetailsParams params;

  UsersBloc_GetCandidateDetailsEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class UsersBloc_ChangeRoleEvent extends UsersBloc_Events {
  final ChangeRoleParams params;

  UsersBloc_ChangeRoleEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class UsersBloc_ResetPasswordForUserEvent extends UsersBloc_Events {
  final int id;

  UsersBloc_ResetPasswordForUserEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class UsersBloc_ResetPasswordEvent extends UsersBloc_Events {
  final ResetPasswordParams params;

  UsersBloc_ResetPasswordEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class UsersBloc_GetSessionsDurationEvent extends UsersBloc_Events {
  final GetSessionsDurationParams params;

  UsersBloc_GetSessionsDurationEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class UsersBloc_UpdateUserInfoEvent extends UsersBloc_Events {
  final int id;
  final UserEntity userData;

  UsersBloc_UpdateUserInfoEvent({
    required this.id,
    required this.userData,
  });

  @override
  List<Object?> get props => [
        id,
        userData,
      ];
}

class UsersBloc_SearchUsersByRoleEvent extends UsersBloc_Events {
  final int? batchId;
  final String? search;
  final UserRoles role;
  final Website? accessWebsites;

  UsersBloc_SearchUsersByRoleEvent({
    this.batchId,
    this.search,
    this.accessWebsites,
    required this.role,
  });

  @override
  List<Object?> get props => [
        batchId,
        search,
        role,
        accessWebsites,
      ];
}

class UsersBloc_SearchUsersByWorkPlaceEvent extends UsersBloc_Events {
  final SearchUsersByWorkPlaceParams params;

  UsersBloc_SearchUsersByWorkPlaceEvent({required this.params});

  @override
  List<Object?> get props => [params];
}
