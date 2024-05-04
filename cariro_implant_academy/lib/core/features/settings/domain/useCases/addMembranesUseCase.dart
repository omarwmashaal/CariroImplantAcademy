import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';

import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

import '../entities/membraneCompanyEnity.dart';
import '../entities/membraneEnity.dart';
import 'addImplantsUseCase.dart';

class AddMembranesUseCase extends UseCases<NoParams, AddMembraneParams> {
  final SettingsRepository settingsRepository;

  AddMembranesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, NoParams>> call(AddMembraneParams value) async {
    return await settingsRepository.addMembranes(value).then((value) => value.fold(
          (l) => Left(l..message = "Add Membranes: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

class AddMembraneParams {
  final int companyId;
  final List<MembraneEntity> data;
  AddMembraneParams({required this.companyId, required this.data});
}
