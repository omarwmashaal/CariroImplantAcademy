import '../Helpers/CIA_DateConverters.dart';
import 'DTOs/DropDownDTO.dart';
import 'Enum.dart';

class LAB_StepModel {
  int? id;
  String? name;
  int? technicianId;
  DropDownDTO? technician;
  String? date;
  LabStepStatus? status;
  int? requestId;
  DropDownDTO? request;

  LAB_StepModel({
    this.id,
    this.name="",
    this.technicianId,
    this.technician,
    this.date,
    this.status,
    this.requestId,
    this.request,}){
    technician = DropDownDTO();
    status = LabStepStatus.NotYet;
    request =DropDownDTO();
  }
  LAB_StepModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']??"";
    technicianId = json['technicianId'];
    technician = DropDownDTO.fromJson(json['technician']??Map<String,dynamic>);
    date = CIA_DateConverters.fromBackendToDateTime(json['date']);
    status = LabStepStatus.values[json['status']??2];
    requestId = json['requestId'];
    request = DropDownDTO.fromJson(json['request']??Map<String,dynamic>);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['technicianId'] = this.technicianId;
    data['technician'] = this.technician!=null?this.technician!.toJson():null;
    data['date'] = this.date;
    data['status'] = (this.status??LabStepStatus.NotYet).index;
    data['requestId'] = this.requestId;
    data['request'] = this.request!=null?this.request!.toJson():null;
    return data;
  }
}