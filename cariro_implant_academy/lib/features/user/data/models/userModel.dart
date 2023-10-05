import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:intl/intl.dart';

import '../../../../Models/Enum.dart';

class UserModel extends UserEntity {
  UserModel({
    super.name,
    super.role,
    super.dateOfBirth,
    super.gender,
    super.graduatedFrom,
    super.classYear,
    super.speciality,
    super.maritalStatus,
    super.address,
    super.city,
    super.idInt,
    super.registeredById,
    super.registeredBy,
    super.registerationDate,
    super.id,
    super.userName,
    super.email,
    super.profileImageId,
    super.phoneNumber,
    super.workPlaceEnum,
    super.batch,
    super.batchId,
  });

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      name: entity.name,
      batch: entity.batch,
      batchId: entity.batchId,
      role: entity.role,
      dateOfBirth: entity.dateOfBirth,
      gender: entity.gender,
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
    );
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImageId = json['profileImageId'];
    dateOfBirth = DateTime.tryParse(json['dateOfBirth'] ?? "")?.toLocal();
    gender = json['gender'];
    graduatedFrom = json['graduatedFrom'];
    classYear = json['classYear'];
    speciality = json['speciality'];
    maritalStatus = json['maritalStatus'];
    address = json['address'];
    city = json['city'];
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
    workPlaceEnum = EnumLabRequestSources.values[json['workPlaceEnum'] ?? 0];
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
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dateOfBirth'] = this.dateOfBirth == null ? null : DateFormat("yyyy-MM-dd").format(this.dateOfBirth!);
    data['gender'] = this.gender;
    data['graduatedFrom'] = this.graduatedFrom;
    data['classYear'] = this.classYear;
    data['speciality'] = this.speciality;
    data['maritalStatus'] = this.maritalStatus;
    data['address'] = this.address;
    data['city'] = this.city;
    data['idInt'] = this.idInt;
    data['id'] = this.id;
    //data['registeredById'] = this.registeredById;
    // data['registeredBy'] = this.registeredBy;
    //data['registerationDate'] = this.registerationDate;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['batchId'] = this.batchId;
    data['batch'] = this.batch==null?null:BasicNameIdObjectModel.fromEntity(this.batch!).toJson();
    data['role'] = this.role ?? "";
    data['phoneNumber2'] = this.phoneNumber2;
    data['workPlace'] = this.workPlace != null ? BasicNameIdObjectModel.fromEntity(this.workPlace!).toJson() : null;
    data['workPlaceId'] = this.workPlaceId;
    data['workPlaceEnum'] = (this.workPlaceEnum ?? EnumLabRequestSources.CIA).index;
    return data;
  }
}
