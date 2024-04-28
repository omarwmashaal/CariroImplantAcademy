import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/requestChangeEntity.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class TreatmentDetailsEntity extends Equatable {
  int? id;
  int? patientId;
  int? postSurgeryModelId;
  BasicNameIdObjectEntity? patient;
  String? value;
  bool? status;
  int? assignedToID;
  BasicNameIdObjectEntity? assignedTo;
  DateTime? date;
  int? doneByAssistantID;
  BasicNameIdObjectEntity? doneByAssistant;
  int? doneBySupervisorID;
  BasicNameIdObjectEntity? doneBySupervisor;
  int? doneByCandidateID;
  BasicNameIdObjectEntity? doneByCandidate;
  int? doneByCandidateBatchID;
  BasicNameIdObjectEntity? doneByCandidateBatch;
  int? implantID;
  BasicNameIdObjectEntity? implant;
  int? implantIDRequest;
  BasicNameIdObjectEntity? implantRequest;
  int? planPrice;
  RequestChangeEntity? requestChangeModel;
  int? requestChangeId;
  int? tooth;
  String? title;
  String? name;

  TreatmentDetailsEntity(
      {this.id,
      this.patientId,
      this.postSurgeryModelId,
      this.patient,
      this.tooth,
      this.value = "",
      this.status = false,
      this.assignedToID,
      this.assignedTo,
      this.date,
      this.name,
      this.doneByAssistantID,
      this.doneByAssistant,
      this.doneBySupervisorID,
      this.doneBySupervisor,
      this.doneByCandidateID,
      this.doneByCandidate,
      this.doneByCandidateBatchID,
      this.doneByCandidateBatch,
      this.implantIDRequest,
      this.implantRequest,
      this.implantID,
      this.requestChangeId,
      this.requestChangeModel,
      this.planPrice,
      this.implant}) {
    doneByAssistant = BasicNameIdObjectEntity();
    doneByCandidate = BasicNameIdObjectEntity();
    doneByCandidateBatch = BasicNameIdObjectEntity();
    doneBySupervisor = BasicNameIdObjectEntity();
    implant = BasicNameIdObjectEntity();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.id,
        this.patientId,
        this.patient,
        this.tooth,
        value,
        this.name,
        status,
        assignedToID,
        postSurgeryModelId,
        this.implantIDRequest,
        this.implantRequest,
        this.requestChangeId,
        this.requestChangeModel,
        //assignedTo,
        date,
        doneByAssistantID,
        //  doneByAssistant,
        doneBySupervisorID,
        //  doneBySupervisor,
        doneByCandidateID,
        //  doneByCandidate,
        doneByCandidateBatchID,
        //  doneByCandidateBatch,
        implantID,
        planPrice,
        //   implant
      ];

  static TreatmentDetailsEntity? getTreatment({required List<TreatmentDetailsEntity> data, required String query, required int tooth}) {
    return data.firstWhereOrNull(
        (element) => element.name?.removeAllWhitespace.toLowerCase() == query.removeAllWhitespace.toLowerCase() && element.tooth == tooth);
  }

  static List<TreatmentDetailsEntity> getTreatments({required List<TreatmentDetailsEntity> data, required String query}) {
    return data.where((element) => element.name?.removeAllWhitespace.toLowerCase() == query.removeAllWhitespace.toLowerCase()).toList();
  }

  bool hasPrice() {
    return this.name?.removeAllWhitespace.toLowerCase() == "Simple Implant".removeAllWhitespace.toLowerCase() ||
        this.name?.removeAllWhitespace.toLowerCase() == "immediateImplant".removeAllWhitespace.toLowerCase() ||
        this.name?.removeAllWhitespace.toLowerCase() == "guidedImplant".removeAllWhitespace.toLowerCase() ||
        this.name?.removeAllWhitespace.toLowerCase() == "expansionWithImplant".removeAllWhitespace.toLowerCase() ||
        this.name?.removeAllWhitespace.toLowerCase() == "splittingWithImplant".removeAllWhitespace.toLowerCase() ||
        this.name?.removeAllWhitespace.toLowerCase() == "gbrWithImplant".removeAllWhitespace.toLowerCase() ||
        this.name?.removeAllWhitespace.toLowerCase() == "closedSinusWithImplant".removeAllWhitespace.toLowerCase() ||
        this.name?.removeAllWhitespace.toLowerCase() == "openSinusWithImplant".removeAllWhitespace.toLowerCase() ||
        this.name?.removeAllWhitespace.toLowerCase() == "restoration".removeAllWhitespace.toLowerCase() ||
        this.name?.removeAllWhitespace.toLowerCase() == "rootcanaltreatment".removeAllWhitespace.toLowerCase() ||
        this.name?.removeAllWhitespace.toLowerCase() == "extraction".removeAllWhitespace.toLowerCase() ||
        this.name?.removeAllWhitespace.toLowerCase() == "crown".removeAllWhitespace.toLowerCase() ||
        this.name?.removeAllWhitespace.toLowerCase() == "scaling".removeAllWhitespace.toLowerCase();
  }

  bool hasAssign() {
    return this.name?.removeAllWhitespace.toLowerCase() == "restoration".removeAllWhitespace.toLowerCase() ||
        this.name?.removeAllWhitespace.toLowerCase() == "rootcanaltreatment".removeAllWhitespace.toLowerCase() ||
        this.name?.removeAllWhitespace.toLowerCase() == "extraction".removeAllWhitespace.toLowerCase();
  }
}
