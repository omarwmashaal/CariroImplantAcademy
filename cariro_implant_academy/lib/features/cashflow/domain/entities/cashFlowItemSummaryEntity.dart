import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';

class CashFlowItemSummaryEntity extends Equatable{
  BasicNameIdObjectEntity? category;
  int? total;


  CashFlowItemSummaryEntity({this.category,this.total});

  @override
  // TODO: implement props
  List<Object?> get props => [category,total,];



}