import 'dart:typed_data';

import 'package:get/get.dart';

import '../../../../../core/constants/enums/enums.dart';
import 'package:age_calculator/age_calculator.dart';

import '../../domain/entities/patientInfoEntity.dart';

class PatientInfoModel extends PatientInfoEntity {
  PatientInfoModel.fromEntity(PatientInfoEntity patientEntity)
      : super(
          phone: patientEntity.phone,
          name: patientEntity.name,
          id: patientEntity.id,
          gender: patientEntity.gender,
          age: patientEntity.age,
          maritalStatus: patientEntity.maritalStatus,
          doctor: patientEntity.doctor,
          doctorId: patientEntity.doctorId,
          relative: patientEntity.relative,
          dateOfBirth: patientEntity.dateOfBirth,
          city: patientEntity.city,
          address: patientEntity.address,
          idBackImageId: patientEntity.idBackImageId,
          idFrontImageId: patientEntity.idFrontImageId,
          nationalId: patientEntity.nationalId,
          phone2: patientEntity.phone2,
          profileImageId: patientEntity.profileImageId,
          registeredBy: patientEntity.registeredBy,
          registrationDate: patientEntity.registrationDate,
          relativePatientId: patientEntity.relativePatientId,
          profileImage: patientEntity.profileImage,
          idFrontImage: patientEntity.idFrontImage,
          idBackImage: patientEntity.idBackImage,
        );

  PatientInfoModel({
    name,
    id,
    gender,
    phone,
    age,
    maritalStatus,
    relative,
    doctor,
    doctorId,
    city,
    dateOfBirth,
    profileImageId,
    idBackImageId,
    idFrontImageId,
    registeredBy,
    nationalId,
    address,
    phone2,
    registrationDate,
    relativePatientId,
    profileImage,
    idFrontImage,
    idBackImage,
  }) : super(
          phone: phone,
          name: name,
          id: id,
          gender: gender,
          age: age,
          maritalStatus: maritalStatus,
          doctor: doctor,
          doctorId: doctorId,
          relative: relative,
          dateOfBirth: dateOfBirth,
          city: city,
          address: address,
          idBackImageId: idBackImageId,
          idFrontImageId: idFrontImageId,
          nationalId: nationalId,
          phone2: phone2,
          profileImageId: profileImageId,
          registeredBy: registeredBy,
          registrationDate: registrationDate,
          relativePatientId: relativePatientId,
          profileImage: profileImage,
          idFrontImage: idFrontImage,
          idBackImage: idBackImage,
        );

  factory PatientInfoModel.fromMap(Map<String, dynamic> map) {
    return PatientInfoModel(
      name: map['name'] as String?,
      id: map['id'] as int?,
      gender: mapToEnum(EnumGender.values, map['gender']),
      phone: map['phone'] as String?,
      age: (){
        var age = (AgeCalculator.age(DateTime.parse(map['dateOfBirth'])).years) as int;
        if(age<0) return null;
        return age;
      }(),
      maritalStatus: mapToEnum(EnumMaritalStatus.values, map['maritalStatus']),
      relative: map['relativePatient'] as String?,
      relativePatientId: map['relativePatientID'] as int?,
      doctor: map['doctor'] as String?,
      doctorId: map['doctorID'] as int?,
      nationalId: map['nationalID'] as String?,
      phone2: map['phone2'] as String?,
      dateOfBirth: map['dateOfBirth'] as String?,
      address: map['address'] as String?,
      city: map['city'] as String?,
      profileImageId: map['profileImageId'] as int?,
      idFrontImageId: map['idFrontImageId'] as int?,
      idBackImageId: map['idBackImageId'] as int?,
      registrationDate: map['registrationDate'] as String?,
      registeredBy: map['registeredBy'] as String?,
      profileImage: map['profileImage'] == null ? null : Uint8List.fromList((map['profileImage'] as List<dynamic>).map((e) => e as int).toList()),
      idBackImage: map['idBackImage'] == null ? null : Uint8List.fromList((map['idBackImage'] as List<dynamic>).map((e) => e as int).toList()),
      idFrontImage: map['idFrontImage'] == null ? null : Uint8List.fromList((map['idFrontImage'] as List<dynamic>).map((e) => e as int).toList()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'id': this.id,
      'gender': getEnumName(this.gender),
      'phone': this.phone,
      'maritalStatus': getEnumName(this.maritalStatus),
      'relativePatient': this.relative,
      'relativePatientId': this.relativePatientId,
      'doctor': this.doctor,
      'doctorID': this.doctorId,
      'nationalId': this.nationalId,
      'phone2': this.phone2,
      'dateOfBirth': this.dateOfBirth,
      'address': this.address,
      'city': this.city,
    };
  }
}
