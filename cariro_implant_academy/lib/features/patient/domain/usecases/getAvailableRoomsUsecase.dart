import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/data/models/roomModel.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/roomEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/visitEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/roomRepo.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/visitsRepo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAvailableRoomsUseCase extends UseCases<List<RoomEntity>, GetAvailableRoomsParams> {
  final RoomRepo roomRepo;

  GetAvailableRoomsUseCase({required this.roomRepo});

  @override
  Future<Either<Failure, List<RoomEntity>>> call(GetAvailableRoomsParams params) async {
    return await roomRepo.getAvailableRooms(params)
      ..fold(
        (l) => Left("Get Rooms:${l.message}"),
        (r) => Right(r),
      );
  }
}

class GetAvailableRoomsParams extends Equatable {
  final DateTime from;
  final DateTime to;

  GetAvailableRoomsParams({
    required this.from,
    required this.to,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        from,
        to,
      ];
}
