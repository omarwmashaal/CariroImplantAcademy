import 'package:cariro_implant_academy/domain/authentication/entities/authenticationUserEntity.dart';

import '../../../Models/Enum.dart';
import '../../../core/data/models/BasicNameIdObjectModel.dart';
import '../../../core/domain/entities/BasicNameIdObjectEntity.dart';

class AuthenticationUserModel extends AuthenticationUserEntity {
  AuthenticationUserModel({
    required name,
    required idInt,
    required phoneNumber,
    required role,
    required token,
    required phone,
  }) : super(
          name: name,
          token: token,
          idInt: idInt,
          phoneNumber: phoneNumber,
          role: role,
          phone: phone,
        );

  factory AuthenticationUserModel.fromJson(Map<String, dynamic> map) {
    return AuthenticationUserModel(
        name: map['name'] as String,
        token: map['token'] as String,
        idInt: map['idInt'] as int,
        phoneNumber: map['phoneNumber'] as String,
        role: map['role'] as String,
        phone: map['phone'] as String);
  }
}
