import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/features/patientVisits/data/datasource/roomDatasource.dart';
import 'package:cariro_implant_academy/features/patientVisits/data/datasource/visitsDatasource.dart';
import 'package:cariro_implant_academy/features/patientVisits/domain/entity/roomEntity.dart';
import 'package:cariro_implant_academy/features/patientVisits/domain/entity/visitEntity.dart';
import 'package:cariro_implant_academy/features/patientVisits/domain/repositories/visitsRepo.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/roomRepo.dart';
import '../../domain/usecases/getAvailableRoomsUsecase.dart';

class RoomRepoImpl implements RoomRepo{
  final RoomDatasource roomDatasource;
  RoomRepoImpl({required this.roomDatasource});

  @override
  Future<Either<Failure, List<RoomEntity>>> getRooms() async{
    try{
      final result = await  roomDatasource.getRooms();
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<RoomEntity>>> getAvailableRooms(GetAvailableRoomsParams params) async{
    try{
      final result = await  roomDatasource.getAvailableRooms(params);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

}