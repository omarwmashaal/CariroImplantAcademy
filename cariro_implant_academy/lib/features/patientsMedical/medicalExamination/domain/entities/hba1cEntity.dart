
import 'package:equatable/equatable.dart';

import '../../../../../Helpers/CIA_DateConverters.dart';

class HbA1cEntity extends Equatable{
  DateTime? date;
  double? reading;

  HbA1cEntity({this.date, this.reading});

  @override
  List<Object?> get props => [this.date, this.reading];
}
