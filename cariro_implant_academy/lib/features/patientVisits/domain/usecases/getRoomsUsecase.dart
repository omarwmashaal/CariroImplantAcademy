import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientVisits/data/models/roomModel.dart';
import 'package:cariro_implant_academy/features/patientVisits/domain/entity/roomEntity.dart';
import 'package:cariro_implant_academy/features/patientVisits/domain/entity/visitEntity.dart';
import 'package:cariro_implant_academy/features/patientVisits/domain/repositories/roomRepo.dart';
import 'package:cariro_implant_academy/features/patientVisits/domain/repositories/visitsRepo.dart';
import 'package:dartz/dartz.dart';

class GetRoomsUseCase extends UseCases<List<RoomEntity>, NoParams> {
  final RoomRepo roomRepo;

  GetRoomsUseCase({required this.roomRepo});

  @override
  Future<Either<Failure, List<RoomEntity>>> call(NoParams params) async {
    return await roomRepo.getRooms()
      ..fold(
        (l) => Left("Get Rooms:${l.message}"),
        (r) => Right(r),
      );
  }
}
