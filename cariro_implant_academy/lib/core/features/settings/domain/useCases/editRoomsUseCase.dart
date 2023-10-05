import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/roomEntity.dart';
import 'package:dartz/dartz.dart';

import 'addImplantsUseCase.dart';

class EditRoomsUseCase extends UseCases<NoParams, List<RoomEntity>> {
  final SettingsRepository settingsRepository;

  EditRoomsUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, NoParams>> call(List<RoomEntity> value) async {
    return await settingsRepository.editRooms(value).then((value) => value.fold(
          (l) => Left(l..message = "Edit Rooms: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

