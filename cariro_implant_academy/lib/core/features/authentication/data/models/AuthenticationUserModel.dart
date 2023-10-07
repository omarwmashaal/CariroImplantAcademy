import 'package:cariro_implant_academy/core/features/authentication/domain/entities/authenticationUserEntity.dart';

import '../../../../constants/enums/enums.dart';
import '../../../../data/models/BasicNameIdObjectModel.dart';
import '../../../../domain/entities/BasicNameIdObjectEntity.dart';

class AuthenticationUserModel extends AuthenticationUserEntity {
  AuthenticationUserModel({
    required name,
    required idInt,
    required phoneNumber,
    required role,
    required token,
    required phone,
    profileId,
  }) : super(
          name: name,
          token: token,
          idInt: idInt,
          phoneNumber: phoneNumber,
          role: role,
          phone: phone,
          profileId: profileId,
        );

  factory AuthenticationUserModel.fromJson(Map<String, dynamic> map) {
    return AuthenticationUserModel(
        name: map['name'] as String,
        token: map['token'] as String,
        idInt: map['idInt'] as int,
        phoneNumber: map['phoneNumber'] as String,
        role: map['role'] as String,
        profileId: map['profileImageId'] as int?,
        phone: map['phone'] as String);
  }
}
