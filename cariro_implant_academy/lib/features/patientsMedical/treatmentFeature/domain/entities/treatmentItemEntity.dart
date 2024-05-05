import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:equatable/equatable.dart';

class TreatmentItemEntity extends Equatable {
  int? id;
  String? name;
  int? price;
  String? priceAction;
  Website website;
  bool allowAssign;
  bool showInSurgical;
  TreatmentItemEntity({
    this.id,
    this.name,
    this.price,
    this.priceAction,
    this.allowAssign = true,
    this.showInSurgical = true,
    this.website = Website.CIA,
  });

  @override
  List<Object?> get props => [
        this.id,
        this.name,
        this.price,
        this.priceAction,
        this.allowAssign,
        this.showInSurgical,
        this.website,
      ];

  bool isImplant() => (name?.toLowerCase().contains("implant") ?? false) && !(name?.toLowerCase().contains("without") ?? false);
}
