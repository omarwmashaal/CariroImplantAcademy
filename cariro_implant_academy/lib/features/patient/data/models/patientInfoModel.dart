import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/enums/enums.dart';
import 'package:age_calculator/age_calculator.dart';

import '../../domain/entities/patientInfoEntity.dart';

class PatientInfoModel extends PatientInfoEntity {
  PatientInfoModel.fromEntity(PatientInfoEntity patientEntity)
      : super(
          phone: patientEntity.phone,
          name: patientEntity.name,
          id: patientEntity.id,
          missingTeeth: patientEntity.missingTeeth,
          diseases: patientEntity.diseases,
          listed: patientEntity.listed,
          outReason: patientEntity.outReason,
          secondaryId: patientEntity.secondaryId,
          gender: patientEntity.gender,
          age: patientEntity.age,
          maritalStatus: patientEntity.maritalStatus,
          doctor: patientEntity.doctor,
          doctorId: patientEntity.doctorId,
          relative: patientEntity.relative,
          out: patientEntity.out,
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
          website: patientEntity.website,
          callHistoryStatus: patientEntity.callHistoryStatus,
        );

  PatientInfoModel({
    name,
    id,
    gender,
    phone,
    secondaryId,
    out,
    age,
    listed,
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
    diseases,
    missingTeeth,
    outReason,
    address,
    phone2,
    registrationDate,
    relativePatientId,
    profileImage,
    idFrontImage,
    idBackImage,
    callHistoryStatus,
    website,
  }) : super(
          phone: phone,
          diseases: diseases,
          missingTeeth: missingTeeth,
          secondaryId: secondaryId,
          name: name,
          id: id,
          listed: listed,
          gender: gender,
          age: age,
          callHistoryStatus: callHistoryStatus,
          maritalStatus: maritalStatus,
          doctor: doctor,
          outReason: outReason,
          doctorId: doctorId,
          out: out,
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
          website: website,
        );

  factory PatientInfoModel.fromMap(Map<String, dynamic> map) {
    return PatientInfoModel(
      name: map['name'] as String?,
      diseases: ((map['diseases'] ?? []) as List<dynamic>).map((e) => DiseasesEnum.values[(e as int)]).toList(),
      missingTeeth: ((map['missingTeeth'] ?? []) as List<dynamic>).map((e) => e as int).toList(),
      listed: map['listed'] as bool?,
      website: Website.values[map['website'] ?? 0],
      callHistoryStatus: map['callHistoryStatus'] == null ? null : EnumPatientCallHistory.values[map['callHistoryStatus']],
      id: map['id'] as int?,
      secondaryId: map['secondaryId'] as String?,
      gender: EnumGender.values[map['gender']],
      phone: map['phone'] as String?,
      outReason: map['outReason'] as String?,
      out: map['out'] ?? false,
      age: () {
        var age = (AgeCalculator.age(DateTime.parse(map['dateOfBirth'])).years) as int;
        if (age < 0) return null;
        return age;
      }(),
      maritalStatus: mapToEnum(EnumMaritalStatus.values, map['maritalStatus']),
      relative: () {
        if (map['relativePatient'] == null) return null;
        try {
          return map['relativePatient'] as String?;
        } catch (e) {
          return (map['relativePatient'] as Map<String, dynamic>)['name'];
        }
      }(),
      relativePatientId: map['relativePatientID'] as int?,
      doctor: map['doctor'] as String?,
      doctorId: map['doctorID'] as int?,
      nationalId: map['nationalID'] as String?,
      phone2: map['phone2'] as String?,
      dateOfBirth: DateTime.tryParse(map['dateOfBirth'] ?? "")?.toLocal(),
      address: map['address'] as String?,
      city: map['city'] as String?,
      profileImageId: map['profileImageId'] as int?,
      idFrontImageId: map['idFrontImageId'] as int?,
      idBackImageId: map['idBackImageId'] as int?,
      registrationDate: DateTime.tryParse(map['registerationDate']??"")?.toLocal(),
      registeredBy: map['registeredBy'] as String?,
      // profileImage: map['profileImage'] == null ? null : Uint8List.fromList((map['profileImage'] as List<dynamic>).map((e) => e as int).toList()),
      // idBackImage: map['idBackImage'] == null ? null : Uint8List.fromList((map['idBackImage'] as List<dynamic>).map((e) => e as int).toList()),
      // idFrontImage: map['idFrontImage'] == null ? null : Uint8List.fromList((map['idFrontImage'] as List<dynamic>).map((e) => e as int).toList()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'missingTeeth': this.missingTeeth,
      'diseases': this.diseases?.map((e) => e.index).toList(),
      'callHistoryStatus': this.callHistoryStatus?.index,
      'listed': this.listed,
      'out': this.out,
      'id': this.id,
      'gender': this.gender?.index,
      'secondaryId': this.secondaryId,
      'phone': this.phone,
      'outReason': this.outReason,
      'maritalStatus': getEnumName(this.maritalStatus),
      'relativePatient': this.relative,
      'relativePatientId': this.relativePatientId,
      'doctor': this.doctor,
      'doctorID': this.doctorId,
      'nationalId': this.nationalId,
      'phone2': this.phone2,
      'dateOfBirth': this.dateOfBirth == null ? null : DateFormat("yyyy-MM-dd").format(this.dateOfBirth!),
      'address': this.address,
      'city': this.city,
      'website': this.website?.index,
    };
  }
}
