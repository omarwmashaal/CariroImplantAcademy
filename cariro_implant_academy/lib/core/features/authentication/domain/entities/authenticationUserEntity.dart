import '../../../../constants/enums/enums.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/BasicNameIdObjectEntity.dart';

class AuthenticationUserEntity extends Equatable {
  final String name;
  final int idInt;
  final String phoneNumber;
  final String phone;
  final List<String> roles;
  final String token;
  final int? profileId;

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        idInt,
        phoneNumber,
        roles,
        token,
        phone,
      ];

  const AuthenticationUserEntity({
    required this.name,
    required this.token,
    required this.idInt,
    required this.phoneNumber,
    required this.roles,
    required this.phone,
     this.profileId,
  });
}
