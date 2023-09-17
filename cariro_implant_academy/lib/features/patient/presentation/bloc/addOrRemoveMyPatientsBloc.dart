import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/removeFromMyPatientsUseCase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/addRangeToMyPatientsUseCase.dart';
import '../../domain/usecases/addToMyPatientsUseCase.dart';
import 'addOrRemoveMyPatientsBloc_states.dart';

const SERVER_FAILURE_MESSAGE = "Internal Server Error";
const DATA_CONVERSION_FAILURE_MESSAGE = "Wrong response";

class AddToMyPatientsRangeBloc extends Cubit<AddToMyPatientsRangeBloc_States> {
  final AddRangeToMyPatientsUseCase addRangeUseCase;
  final AddToMyPatientsUseCase addToMyPatientsUseCase;
  final RemoveFromMyPatientsUseCase removeFromMyPatientsUseCase;

  AddToMyPatientsRangeBloc({
    required this.addRangeUseCase,
    required this.addToMyPatientsUseCase,
    required this.removeFromMyPatientsUseCase,
  }) : super(InitialState());

  void addToMyPatientsRange(int from, int to) async {
    emit(LoadingState());
    final result = await addRangeUseCase(AddRangePatientsParams(from: from, to: to));
    result.fold(
      (l) {
        if (l is HttpInternalServerErrorFailure)
          emit(ErrorState(message: SERVER_FAILURE_MESSAGE));
        else if (l is DataConversionFailure) emit(ErrorState(message: DATA_CONVERSION_FAILURE_MESSAGE));
      },
      (r) {
        emit(DoneState());
      },
    );
  }

  void addToMyPatients(int id) async {
    emit(LoadingState());
    final result = await addToMyPatientsUseCase(id);
    result.fold(
      (l) {
        if (l is HttpInternalServerErrorFailure)
          emit(ErrorState(message: SERVER_FAILURE_MESSAGE));
        else if (l is BadRequestFailure) emit(ErrorState(message: l.message ?? ""));
      },
      (r) {
        emit(DoneState());
      },
    );
  }

  void removeFromMyPatients(int id) async {
    emit(LoadingState());
    final result = await removeFromMyPatientsUseCase(id);
    result.fold(
      (l) {
        if (l is HttpInternalServerErrorFailure)
          emit(ErrorState(message: SERVER_FAILURE_MESSAGE));
        else if (l is BadRequestFailure) emit(ErrorState(message: l.message ?? ""));
      },
      (r) {
        emit(DoneState());
      },
    );
  }
}
