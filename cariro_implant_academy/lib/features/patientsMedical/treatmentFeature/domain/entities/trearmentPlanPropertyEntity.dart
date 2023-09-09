import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';

class TreatmentPlanPropertyEntity extends Equatable {
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
  int? planPrice;

  TreatmentPlanPropertyEntity(
      {this.value = "",
      this.status = false,
      this.assignedToID,
      this.assignedTo,
      this.date,
      this.doneByAssistantID,
      this.doneByAssistant,
      this.doneBySupervisorID,
      this.doneBySupervisor,
      this.doneByCandidateID,
      this.doneByCandidate,
      this.doneByCandidateBatchID,
      this.doneByCandidateBatch,
      this.implantID,
      this.planPrice = 0,
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
        value,
        status,
        assignedToID,
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
}
