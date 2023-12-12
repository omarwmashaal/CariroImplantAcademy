import 'package:equatable/equatable.dart';

class BasicNameIdObjectEntity extends Equatable{
   String? name;
   int? id;
   String? secondaryId;

   BasicNameIdObjectEntity({
    this.name ="",
     this.id,
     this.secondaryId,
  });

  @override
  List<Object?> get props => [name,id,secondaryId];


}