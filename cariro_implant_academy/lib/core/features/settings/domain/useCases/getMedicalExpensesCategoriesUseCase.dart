import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class GetMedicalExpensesCategoriesUseCase extends LoadingUseCases {
  final SettingsRepository settingsRepository;

  GetMedicalExpensesCategoriesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> call(NoParams) async {
    return await settingsRepository.getMedicalExpensesCategories().then((value) => value.fold(
          (l) => Left(l..message = "Get Medical Expenses Categories: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
