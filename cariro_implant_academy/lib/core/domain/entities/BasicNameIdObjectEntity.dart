import 'package:equatable/equatable.dart';

class BasicNameIdObjectEntity extends Equatable{
  final String? name;
  final int? id;

  const BasicNameIdObjectEntity({
    this.name ="",
     this.id,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name,id];


}