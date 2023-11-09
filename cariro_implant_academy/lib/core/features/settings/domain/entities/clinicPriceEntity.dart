import 'package:equatable/equatable.dart';

import '../../../../constants/enums/enums.dart';

class ClinicPriceEntity extends Equatable {
  int? id;
  EnumClinicPrices? category;
  int? price;
  int? tooth;

  ClinicPriceEntity({
    this.id,
    this.category,
    this.price,
    this.tooth,
  });

  @override
  List<Object?> get props => [
        this.id,
        this.category,
        this.price,
        this.tooth,
      ];
}
