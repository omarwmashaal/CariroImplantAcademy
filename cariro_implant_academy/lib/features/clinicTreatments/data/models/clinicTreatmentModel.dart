import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/features/settings/data/models/ImplantModel.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/data/models/clinicImplantModel.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/data/models/orthoTreatmentModel.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/data/models/pedoModel.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/data/models/restorationModel.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/data/models/rootCanalTreatmentModel.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/data/models/tmdModel.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicImplantEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/pedoEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/restorationEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/rootCanalTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/tmdEntity.dart';

class ClinicTreatmentModel extends ClinicTreatmentEntity {
  ClinicTreatmentModel({
    super.patientId,
    super.restorations,
    super.clinicImplants,
    super.orthoTreatments,
    super.tmds,
    super.pedos,
    super.rootCanalTreatments,
  });

  factory ClinicTreatmentModel.fromEntity(ClinicTreatmentEntity entity) {
    return ClinicTreatmentModel(

      patientId:entity.patientId,
      restorations:entity.restorations,
      clinicImplants:entity.clinicImplants,
      orthoTreatments:entity.orthoTreatments,
      tmds:entity.tmds,
      pedos:entity.pedos,
      rootCanalTreatments:entity.rootCanalTreatments,
    );
  }

  factory ClinicTreatmentModel.fromJson(Map<String, dynamic> map) {
    return ClinicTreatmentModel(

      patientId:map['patientId'],
      restorations:((map['restorations']??[]) as List<dynamic>).map((e) => RestorationModel.fromJson(e as Map<String,dynamic>)).toList(),
      clinicImplants:((map['clinicImplants']??[]) as List<dynamic>).map((e) => ClinicImplantModel.fromJson(e as Map<String,dynamic>)).toList(),
      orthoTreatments:((map['orthoTreatments']??[]) as List<dynamic>).map((e) => OrthoTreatmentModel.fromJson(e as Map<String,dynamic>)).toList(),
      tmds:((map['tmds']??[]) as List<dynamic>).map((e) => TMDmodel.fromJson(e as Map<String,dynamic>)).toList(),
      pedos:((map['pedos']??[]) as List<dynamic>).map((e) => PedoModel.fromJson(e as Map<String,dynamic>)).toList(),
      rootCanalTreatments:((map['rootCanalTreatments']??[]) as List<dynamic>).map((e) => RootCanalTreatmentModel.fromJson(e as Map<String,dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['patientId']=this.patientId;
    data['restorations']=this.restorations?.map((e) => RestorationModel.fromEntity(e).toJson()).toList()??[];
    data['clinicImplants']=this.clinicImplants?.map((e) => ClinicImplantModel.fromEntity(e).toJson()).toList()??[];
    data['oOrthoTreatments']=this.orthoTreatments?.map((e) => OrthoTreatmentModel.fromEntity(e).toJson()).toList()??[];
    data['tmds']=this.tmds?.map((e) => TMDmodel.fromEntity(e).toJson()).toList()??[];
    data['pedos']=this.pedos?.map((e) => PedoModel.fromEntity(e).toJson()).toList()??[];
    data['rootCanalTreatments']=this.rootCanalTreatments?.map((e) => RootCanalTreatmentModel.fromEntity(e).toJson()).toList()??[];
    return data;
  }
}
