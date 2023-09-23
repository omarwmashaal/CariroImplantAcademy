import '../../../../Models/Enum.dart';
import 'package:equatable/equatable.dart';

import '../../../core/domain/entities/BasicNameIdObjectEntity.dart';

class AuthenticationUserEntity extends Equatable {
  final String name;
  final int idInt;
  final String phoneNumber;
  final String phone;
  final String role;
  final String token;

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        idInt,
        phoneNumber,
        role,
        token,
        phone,
      ];

  const AuthenticationUserEntity({
    required this.name,
    required this.token,
    required this.idInt,
    required this.phoneNumber,
    required this.role,
    required this.phone,
  });
}
