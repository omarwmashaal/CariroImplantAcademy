import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:equatable/equatable.dart';

class CBCT_Entity extends Equatable {
  bool? done;
  DateTime? date;

  CBCT_Entity({
    this.date,
    this.done,
  });

  bool isNull()=> !(done??false) || date==null;

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.date,
        this.done,
      ];
}
