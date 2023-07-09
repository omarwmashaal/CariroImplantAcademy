import 'package:equatable/equatable.dart';

class BasicNameIdObjectEntity extends Equatable{
  final String name;
  final int id;

  const BasicNameIdObjectEntity({
    required this.name,
    required this.id,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name,id];


}