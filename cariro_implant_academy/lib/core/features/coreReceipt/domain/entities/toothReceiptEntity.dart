import 'package:equatable/equatable.dart';

class ToothReceiptEntity extends Equatable {
  int? tooth;
  int? price;
  String? name;

  ToothReceiptEntity({
    this.tooth,
    this.name,
    this.price = 0,
  });

  @override
  List<Object?> get props => [
        this.name,
        this.price,
        this.tooth,
      ];
}
