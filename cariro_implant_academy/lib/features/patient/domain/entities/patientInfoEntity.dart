import 'dart:typed_data';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums/enums.dart';

class PatientInfoEntity extends Equatable {
  String? name;
  int? id;
  String? secondaryId;
  EnumGender? gender;
  EnumPatientCallHistory? callHistoryStatus;
  String? phone;
  bool? listed;
  int? age;
  EnumMaritalStatus? maritalStatus;
  String? relative;
  int? relativePatientId;
  String? doctor;
  int? doctorId;
  String? nationalId;
  String? phone2;
  DateTime? dateOfBirth;
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
  Website website;
  bool out;
  String? outReason;

  PatientInfoEntity({
    this.name,
    this.callHistoryStatus,
    this.id,
    this.gender,
    this.phone,
    this.listed = true,
    this.age,
    this.out = false,
    this.maritalStatus,
    this.relative,
    this.doctor,
    this.outReason = "",
    this.doctorId,
    this.city,
    this.dateOfBirth,
    this.profileImageId,
    this.idBackImageId,
    this.idFrontImageId,
    this.registeredBy,
    this.nationalId,
    this.address,
    this.secondaryId,
    this.phone2,
    this.registrationDate,
    this.relativePatientId,
    this.idBackImage,
    this.idFrontImage,
    this.profileImage,
    this.website = Website.CIA,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        id,
        gender,
        phone,
        listed,
        secondaryId,
        maritalStatus,
        relative,
        outReason,
        doctor,
        out,
        doctorId,
        city,
        dateOfBirth,
        nationalId,
        address,
        phone2,
        relativePatientId,
        website,
      ];
}
