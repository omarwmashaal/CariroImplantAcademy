import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/domain/patients/usecases/getNextAvailableIdUseCase.dart';
import 'package:cariro_implant_academy/presentation/patients/bloc/createOrViewPatientBloc_Events.dart';
import 'package:cariro_implant_academy/presentation/patients/bloc/createOrViewPatientBloc_States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/patients/usecases/checkDuplicateIdUseCase.dart';
import '../../../domain/patients/usecases/checkDuplicateNumberUseCase.dart';
import '../../../domain/patients/usecases/createPatientUseCase.dart';
import '../../../domain/patients/usecases/getPatientDataUseCase.dart';
import '../../../domain/patients/usecases/patientSearchUseCase.dart';

const SERVER_FAILURE_MESSAGE = "Internal Server Error";
const UNKNOWN_FAILURE_MESSAGE = "Unknown Error";

class CreateOrViewPatientBloc extends Bloc<CreateOrViewPatientBloc_Events, CreateOrViewPatientBloc_State> {
  final CheckDuplicateIdUseCase checkDuplicateIdUseCase;
  final CreatePatientUseCase createPatientUseCase;
  final CheckDuplicateNumberUseCase checkDuplicateNumberUseCase;
  final GetNextAvailableIdUseCase getNextAvailableIdUseCase;
  final PatientSearchUseCase patientSearchUseCase;
  final GetPatientDataUseCase getPatientDataUseCase;
  PageState pageState= PageState.view;
  CreateOrViewPatientBloc(
      {required this.createPatientUseCase,
      required this.checkDuplicateNumberUseCase,
      required this.checkDuplicateIdUseCase,
      required this.getNextAvailableIdUseCase,
      required this.patientSearchUseCase,
      required this.getPatientDataUseCase
      })
      : super(LoadingPatientInfoState()) {
    on<CheckDuplicateNumberEvent>(
      (event, emit) async {
        emit(LoadingDuplicateNumber());
        final result = await checkDuplicateNumberUseCase(event.number);
        result.fold(
          (l) {
            if (l is HttpInternalServerErrorFailure)
              emit(Error(SERVER_FAILURE_MESSAGE));
            else if (l is InputValidationFailure)
              emit(Error(l.message??""));
            else
              emit(Error(UNKNOWN_FAILURE_MESSAGE));
          },
          (r) {
            emit(LoadedDuplicateNumber(r));
          },
        );
      },
    );
    on<CheckAvailableIdEvent>(
      (event, emit) async {
        emit(LoadingId());
        final result = await checkDuplicateIdUseCase(event.id);
        result.fold(
          (l) {
            if (l is HttpInternalServerErrorFailure)
              emit(Error(SERVER_FAILURE_MESSAGE));
            //else if (l is InputValidationFailure) emit(Error(l.message));
            else
              emit(Error(UNKNOWN_FAILURE_MESSAGE));
          },
          (r) {
            emit(LoadedAvailableId(message: r ? "Duplicate Id" : null));
          },
        );
      },
    );
    on<CreatePatientEvent>(
      (event, emit) async {
        emit(CreatingPatientState());
        final result = await createPatientUseCase(event.patient);
        result.fold(
          (l) {
            emit(Error(l.message??""));
          },
          (r) {
            if(r == true)
              emit(CreatedPatientState());
          },
        );
      },
    );
    on<InitialEvent>(
      (event, emit) async {
        final result = await getNextAvailableIdUseCase(NoParams());
        result.fold(
          (l) {
            emit(Error(SERVER_FAILURE_MESSAGE));
          },
          (r) {
            emit(LoadedGetNextId(message: r.toString()));
          },
        );
      },
    );
    on<SearchPatientsEvent>(
      (event, emit) async {
        emit(LoadingPatients());
        final result = await patientSearchUseCase(PatientSearchParams(myPatients: false, query: event.query, filter: "Name"));
        result.fold((l) {
          if (l is HttpInternalServerErrorFailure)
            emit(Error(SERVER_FAILURE_MESSAGE));
          else
            emit(Error(UNKNOWN_FAILURE_MESSAGE));
        }, (r) {
          emit(LoadedPatients(patients: r));
        });
      },
    );
    on<GetPatientInfoEvent>(
      (event, emit)async {
        emit(LoadingPatientInfoState());
        final result = await getPatientDataUseCase(event.id);
        result.fold((l) => emit(Error(l.message??"")), (r) {
          emit(LoadedPatientInfoState(patient: r));
        });
      },
    );
    on<ChangePageStateEvent>((event, emit) {
      this.pageState = event.pageState;
      print("current state is ${pageState.name}");
      emit(ChangePageState(this.pageState.name));
    },);

  }
}
