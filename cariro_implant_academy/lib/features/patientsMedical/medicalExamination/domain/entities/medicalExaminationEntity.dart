import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/domain/entities/hba1cEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enums/enums.dart';
import 'bloodPressureEntity.dart';
import 'diabeticEntity.dart';

class MedicalExaminationEntity extends Equatable {
  int? id;
  int? patientId;
  GeneralHealthEnum? generalHealth;
  PregnancyEnum? pregnancyStatus;
  String? areYouTreatedFromAnyThing;
  String? recentSurgery;
  String? comment;
  List<DiseasesEnum>? diseases;
  String? otherDiseases;
  BloodPressureEntity? bloodPressure;
  DiabeticEntity? diabetic;
  List<HbA1cEntity>? hbA1c;
  bool? penicillin;
  bool? sulfa;
  bool? otherAllergy;
  String? otherAllergyComment;
  bool? prolongedBleedingOrAspirin;
  bool? chronicDigestion;
  String? illegalDrugs;
  String? operatorComments;
  List<String>? drugsTaken;
  int? operatorId;
  BasicNameIdObjectEntity? operator;
  DateTime? date;  DateTime? notification_Hba1c;


  @override
  // TODO: implement props
  List<Object?> get props => [
/*this.id,
        this.patientId,
        this.generalHealth,
        this.pregnancyStatus,
        this.areYouTreatedFromAnyThing,
        this.recentSurgery,
        this.comment,
        this.diseases,*/
        this.bloodPressure,
        /*this.diabetic,
        this.hbA1c,
        this.otherDiseases,
        this.penicillin,
        this.sulfa,
        this.otherAllergy,
        this.otherAllergyComment,
        this.prolongedBleedingOrAspirin,
        this.chronicDigestion,
        this.illegalDrugs,
        this.operatorComments,
        this.drugsTaken,
        this.operatorId,
        this.operator,
        this.date,*/
      ];

  MedicalExaminationEntity({
    this.id,
    this.patientId,
    this.generalHealth,
    this.pregnancyStatus,
    this.areYouTreatedFromAnyThing,
    this.recentSurgery,
    this.comment,
    this.otherDiseases,
    this.diseases,
    this.bloodPressure,
    this.diabetic,
    this.hbA1c,
    this.notification_Hba1c,
    this.penicillin,
    this.sulfa,
    this.otherAllergy,
    this.otherAllergyComment,
    this.prolongedBleedingOrAspirin,
    this.chronicDigestion,
    this.illegalDrugs,
    this.operatorComments,
    this.drugsTaken,
    this.operatorId,
    this.operator,
    this.date,
  });
}
