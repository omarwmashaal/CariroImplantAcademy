import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

abstract class CoreStockRepository{
  Future<Either<Failure,NoParams>> consumeItemById(int id,int count);
  Future<Either<Failure,NoParams>> consumeItemByName(String name,int count);
}