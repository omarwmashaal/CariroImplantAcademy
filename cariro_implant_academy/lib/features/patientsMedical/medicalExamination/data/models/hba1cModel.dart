
import 'package:intl/intl.dart';

import '../../../../../Helpers/CIA_DateConverters.dart';
import '../../domain/entities/hba1cEntity.dart';

class HBA1CModel extends HbA1cEntity {
  HBA1CModel({
    date,
    reading,
  }) : super(
          date: date,
          reading: reading,
        );

  HBA1CModel.fromJson(Map<String, dynamic> json) {
    date =  DateTime.tryParse(json['date']??"")?.toLocal();
    reading = json['reading'] == null? null:json['reading'];
  }

  HBA1CModel.fromEntity(HbA1cEntity hbA1cEntity) {
    date =  hbA1cEntity.date;
    reading = hbA1cEntity.reading;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date==null?null:DateFormat("yyyy-MM-dd").format(this.date!);
    data['reading'] = this.reading;
    return data;
  }
}
