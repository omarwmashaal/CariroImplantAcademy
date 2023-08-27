import 'package:cariro_implant_academy/features/patientVisits/domain/entity/roomEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/visitEntity.dart';
import '../usecases/getAvailableRoomsUsecase.dart';

abstract class RoomRepo{
  Future<Either<Failure,List<RoomEntity>>> getRooms();
  Future<Either<Failure,List<RoomEntity>>> getAvailableRooms(GetAvailableRoomsParams params);
}