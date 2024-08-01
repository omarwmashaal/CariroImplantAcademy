import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/enums/enums.dart';

class UserModel extends UserEntity {
  UserModel({
    super.name,
    super.roles,
    super.dateOfBirth,
    super.gender,
    super.graduatedFrom,
    super.classYear,
    super.speciality,
    super.maritalStatus,
    super.address,
    super.accessWebsites,
    super.city,
    super.idInt,
    super.registeredById,
    super.registeredBy,
    super.implantCount,
    super.registerationDate,
    super.id,
    super.userName,
    super.email,
    super.profileImageId,
    super.phoneNumber,
    super.workPlaceEnum,
    super.workPlace,
    super.workPlaceId,
    super.batch,
    super.batchId,
    super.instagramLink,
    super.facebookLink,
  });

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      name: entity.name,
      accessWebsites: entity.accessWebsites,
      batch: entity.batch,
      batchId: entity.batchId,
      roles: entity.roles,
      dateOfBirth: entity.dateOfBirth,
      gender: entity.gender,
      implantCount: entity.implantCount,
      graduatedFrom: entity.graduatedFrom,
      classYear: entity.classYear,
      speciality: entity.speciality,
      maritalStatus: entity.maritalStatus,
      address: entity.address,
      city: entity.city,
      idInt: entity.idInt,
      registeredById: entity.registeredById,
      registeredBy: entity.registeredBy,
      registerationDate: entity.registerationDate,
      id: entity.id,
      userName: entity.userName,
      email: entity.email,
      profileImageId: entity.profileImageId,
      phoneNumber: entity.phoneNumber,
      workPlaceEnum: entity.workPlaceEnum,
      workPlace: entity.workPlace,
      workPlaceId: entity.workPlaceId,
      instagramLink: entity.instagramLink,
      facebookLink: entity.facebookLink,
    );
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImageId = json['profileImageId'];
    instagramLink = json['instagramLink'];
    facebookLink = json['facebookLink'];
    dateOfBirth = DateTime.tryParse(json['dateOfBirth'] ?? "")?.toLocal();
    gender = json['gender'];
    accessWebsites =
        ((json['accessWebsites'] ?? []) as List<dynamic>).map((e) => Website.values.firstWhere((element) => element.index == e!)).toList();
    graduatedFrom = json['graduatedFrom'];
    classYear = json['classYear'];
    speciality = json['speciality'];
    implantCount = json['implantCount'] ?? 0;
    maritalStatus = json['maritalStatus'];
    address = json['address'];
    city = json['city'];
    workPlaceId = json['workPlaceId'];
    workPlace = json['workPlace'] == null ? null : BasicNameIdObjectModel.fromJson(json['workPlace']);
    idInt = json['idInt'];
    if (idInt == null)
      try {
        idInt = json['id'];
      } catch (e) {}
    ;
    try {
      id = json['id'];
    } catch (e) {
      id = json['idInt'];
    }

    registeredById = json['registeredById'];
    registeredBy = json['registeredBy'] == null ? null : BasicNameIdObjectModel.fromJson(json['registeredBy']);
    registerationDate = DateTime.tryParse(json['registerationDate'] ?? "")?.toLocal();
    workPlaceEnum = Website.values[json['workPlaceEnum'] ?? 0];
    /*try{
      id = json['id'];
    }catch(e){
      idInt = json['id'];
    }*/
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    batch = BasicNameIdObjectModel.fromJson(json['batch'] ?? Map<String, dynamic>());
    batchId = json['batchId'];
    phoneNumber2 = json['phoneNumber2'];
    workPlace = BasicNameIdObjectModel.fromJson(json['workPlace'] ?? Map<String, dynamic>());
    workPlaceId = json['workPlaceId'];
    roles = ((json['roles'] ?? []) as List<dynamic>).map((e) => e as String).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['workPlaceId'] = this.workPlaceId;
    data['instagramLink'] = this.instagramLink;
    data['facebookLink'] = this.facebookLink;
    data['dateOfBirth'] = this.dateOfBirth == null ? null : DateFormat("yyyy-MM-dd").format(this.dateOfBirth!);
    data['gender'] = this.gender;
    data['graduatedFrom'] = this.graduatedFrom;
    data['classYear'] = this.classYear;
    data['speciality'] = this.speciality;
    data['maritalStatus'] = this.maritalStatus;
    data['address'] = this.address;
    data['city'] = this.city;
    data['idInt'] = this.idInt;
    data['accessWebsites'] = this.accessWebsites?.map((e) => e.index).toList();
    data['id'] = this.id;
    //data['registeredById'] = this.registeredById;
    // data['registeredBy'] = this.registeredBy;
    //data['registerationDate'] = this.registerationDate;
    data['userName'] = this.userName;
    data['workPlace'] = workPlace == null ? null : BasicNameIdObjectModel.fromEntity(workPlace!).toJson();
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['batchId'] = this.batchId;
    data['batch'] = this.batch == null ? null : BasicNameIdObjectModel.fromEntity(this.batch!).toJson();
    data['roles'] = this.roles?.map((e) => e as String).toList();
    data['phoneNumber2'] = this.phoneNumber2;
    data['workPlace'] = this.workPlace != null ? BasicNameIdObjectModel.fromEntity(this.workPlace!).toJson() : null;
    data['workPlaceId'] = this.workPlaceId;
    data['workPlaceEnum'] = (this.workPlaceEnum ?? Website.CIA).index;
    return data;
  }
}
