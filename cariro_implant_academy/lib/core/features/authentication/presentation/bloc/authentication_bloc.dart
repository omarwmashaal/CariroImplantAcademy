import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/core/features/authentication/presentation/bloc/authentication_blocEvents.dart';
import 'package:cariro_implant_academy/core/features/authentication/presentation/bloc/authentication_blocStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/useCases/checkLogInStatus.dart';
import '../../../../injection_contianer.dart';
import '../../domain/usecases/loginUseCase.dart';
import '../../domain/usecases/registerUserUseCase.dart';

const LOGIN_FAILURE_MESSAGE = "Wrong credentials";
const SERVER_FAILURE_MESSAGE = "Internal Server Error";

class AuthenticationBloc extends Bloc<Authentication_blocEvent, Authentication_blocState> {
  final LoginUseCase loginUseCase;
  final CheckLoginStatusUseCase checkLoginStatusUseCase;
  final RegisterUserUseCase registerUserUseCase;

  AuthenticationBloc({
    required this.loginUseCase,
    required this.registerUserUseCase,
    required this.checkLoginStatusUseCase,
  }) : super(LoggedOutState()) {
    on<LogInEvent>(
      (event, emit) async {
        emit(LoggingInState());
        final result = await loginUseCase(event.loginParams);
        result.fold(
          (l) {
            if (l is HttpInternalServerErrorFailure)
              emit(ErrorState(message: SERVER_FAILURE_MESSAGE));
            else if (l is LoginFailure)
              emit(ErrorState(message: LOGIN_FAILURE_MESSAGE));
            else
              emit(ErrorState(message: l.message ?? ""));
          },
          (r) {
            emit(LoggedIn(user: r));
          },
        );
      },
    );
    on<CheckLogInStatusEvent>(
      (event, emit) async {
        final result = await checkLoginStatusUseCase(NoParams());
        result.fold(
          (l) {
            emit(LoggedOutState());
          },
          (r) {
            emit(LoggedIn(user: r));
          },
        );
      },
    );
    on<RegisterUserEvent>(
      (event, emit) async {
        emit(RegisteringUserState());
        final result = await registerUserUseCase(event.user);
        result.fold(
          (l) => emit(RegisteringUserErrorState(message: l.message ?? "")),
          (r) => emit(RegisteredUserSuccessfullyState()),
        );
      },
    );
  }
}
