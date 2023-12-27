import 'package:cariro_implant_academy/core/features/authentication/domain/entities/authenticationUserEntity.dart';

import '../../../../constants/enums/enums.dart';
import '../../../../data/models/BasicNameIdObjectModel.dart';
import '../../../../domain/entities/BasicNameIdObjectEntity.dart';

class AuthenticationUserModel extends AuthenticationUserEntity {
  AuthenticationUserModel({
    required name,
    required idInt,
    required phoneNumber,
    required roles,
    required token,
    required phone,
    profileId,
  }) : super(
          name: name,
          token: token,
          idInt: idInt,
          phoneNumber: phoneNumber,
          roles: roles,
          phone: phone,
          profileId: profileId,
        );

  factory AuthenticationUserModel.fromJson(Map<String, dynamic> map) {
    return AuthenticationUserModel(
        name: map['name'] as String,
        token: map['token'] as String,
        idInt: map['idInt'] as int,
        phoneNumber: map['phoneNumber'] as String,
        roles: ((map['roles']??[]) as List<dynamic>).map((e) => e as String).toList(),
        profileId: map['profileImageId'] as int?,
        phone: map['phone'] as String);
  }
}
