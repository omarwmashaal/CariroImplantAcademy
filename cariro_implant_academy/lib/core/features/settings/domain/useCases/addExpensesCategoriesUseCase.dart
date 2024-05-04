import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

import 'addImplantsUseCase.dart';

class AddExpensesCategoriesUseCase extends UseCases<NoParams, List<BasicNameIdObjectEntity>> {
  final SettingsRepository settingsRepository;

  AddExpensesCategoriesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, NoParams>> call(List<BasicNameIdObjectEntity> value) async {
    return await settingsRepository.addExpensesCategories(value).then((value) => value.fold(
          (l) => Left(l..message = "Add Expenses Categories: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

