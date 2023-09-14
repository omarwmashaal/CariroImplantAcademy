import 'package:equatable/equatable.dart';

class BasicNameIdObjectEntity extends Equatable{
   String? name;
   int? id;

   BasicNameIdObjectEntity({
    this.name ="",
     this.id,
  });

  @override
  List<Object?> get props => [name,id];


}