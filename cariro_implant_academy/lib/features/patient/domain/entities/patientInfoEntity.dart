import 'dart:typed_data';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:equatable/equatable.dart';

class PatientInfoEntity extends Equatable {
  String? name;
  int? id;
  EnumGender? gender;
  String? phone;
  int? age;
  EnumMaritalStatus? maritalStatus;
  String? relative;
  int? relativePatientId;
  String? doctor;
  int? doctorId;
  String? nationalId;
  String? phone2;
  String? dateOfBirth;
  String? address;
  String? city;
  int? profileImageId;
  int? idFrontImageId;
  int? idBackImageId;
  Uint8List? profileImage;
  Uint8List? idFrontImage;
  Uint8List? idBackImage;
  String? registrationDate;
  String? registeredBy;

  PatientInfoEntity(
      { this.name,
       this.id,
       this.gender,
       this.phone,
       this.age,
       this.maritalStatus,
      this.relative,
      this.doctor,
      this.doctorId,
      this.city,
      this.dateOfBirth,
      this.profileImageId,
      this.idBackImageId,
      this.idFrontImageId,
      this.registeredBy,
      this.nationalId,
      this.address,
      this.phone2,
      this.registrationDate,
      this.relativePatientId,
      this.idBackImage,
        this.idFrontImage,
        this.profileImage,
      });

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        id,
        gender,
        phone,
        maritalStatus,
        relative,
        doctor,
        doctorId,
        city,
        dateOfBirth,
        nationalId,
        address,
      phone2,
        relativePatientId,

      ];


}