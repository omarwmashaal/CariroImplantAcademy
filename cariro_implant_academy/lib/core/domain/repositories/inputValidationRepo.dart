import 'package:dartz/dartz.dart';

import '../../error/failure.dart';

abstract class InputValidationRepo {
  Either<Failure,bool> validateStringToInt(String value);
}
