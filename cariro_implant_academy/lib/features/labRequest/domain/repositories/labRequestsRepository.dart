import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemParentEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labstepItemEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/features/coreReceipt/domain/entities/receiptEntity.dart';
import '../entities/labItemEntity.dart';
import '../usecases/getAllRequestsUseCase.dart';

abstract class LabRequestRepository {
  Future<Either<Failure, List<LabRequestEntity>>> getAllLabRequests(GetAllRequestsParams params);
  Future<Either<Failure, List<LabStepItemEntity>>> getLabItemStepsFroRequest(int id);

  Future<Either<Failure, List<LabRequestEntity>>> getPatientLabRequests(int id);
  Future<Either<Failure, List<LabItemParentEntity>>> getLabItemsFromSettings();

  Future<Either<Failure, LabRequestEntity>> getLabRequest(int id);
  Future<Either<Failure, NoParams>> deleteLabRequest(int id);
  Future<Either<Failure, NoParams>> checkLabRequests(int id);

  Future<Either<Failure, NoParams>> addRequest(LabRequestEntity model);
  Future<Either<Failure, NoParams>> updateLabRequest(LabRequestEntity model);

  Future<Either<Failure, BasicNameIdObjectEntity>> getDefaultStepByName(String name);

  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getDefaultSteps();

  Future<Either<Failure, NoParams>> addToMyTasks(int id);

  Future<Either<Failure, NoParams>> assignTaskToTechnician(int id, int technicianId, int? designerId);

  Future<Either<Failure, NoParams>> finishTask(int id, int? nextTaskId, int? assignToId, String? notes);

  Future<Either<Failure, NoParams>> markRequestAsDone(int id, String? notes);

  // Future<Either<Failure, NoParams>> addOrUpdateRequestReceipt(int id, List<LabStepEntity> steps);

  Future<Either<Failure, NoParams>> payForRequest(int id, int amount);
  Future<Either<Failure, LabItemEntity>> getLabItemDetails(int id);
  Future<Either<Failure, ReceiptEntity?>> getRequestReceipt(int id);
  Future<Either<Failure, NoParams>> consumeLabItem(int id, int? number, bool consumeWholeBlock);
}
