import '../Helpers/CIA_DateConverters.dart';
import 'DTOs/DropDownDTO.dart';
import 'Enum.dart';

class LAB_StepModel {
  int? id;
  int? technicianId;
  DropDownDTO? technician;
  String? date;
  LabStepStatus? status;
  int? requestId;
  DropDownDTO? request;
  int? stepId;
  DropDownDTO? step;
  String? notes;
  int? price;

  LAB_StepModel({
    this.id,
    this.technicianId,
    this.technician,
    this.date,
    this.status,
    this.requestId,
    this.step,
    this.stepId,
    this.notes = "",
    this.price = 0,
    this.request,}){
    technician = DropDownDTO();
    status = LabStepStatus.NotYet;
    request =DropDownDTO();
    //step = DropDownDTO();
  }
  LAB_StepModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notes = json['notes'];
    price = json['price'];
    technicianId = json['technicianId'];
    technician = DropDownDTO.fromJson(json['technician']??Map<String,dynamic>());
    date = CIA_DateConverters.fromBackendToDateTime(json['date']);
    status = LabStepStatus.values[json['status']??2];
    requestId = json['requestId'];
    request = DropDownDTO.fromJson(json['request']??Map<String,dynamic>());
  stepId = json['stepId'];
    step = DropDownDTO.fromJson(json['step']??Map<String,dynamic>());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notes'] = this.notes;
    data['price'] = this.price;
    data['technicianId'] = this.technicianId;
    //data['date'] = this.date;
    data['status'] = (this.status??LabStepStatus.NotYet).index;
    data['stepId'] = this.stepId;
    return data;
  }
}