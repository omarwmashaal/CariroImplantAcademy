import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/data/dataSources/loginStatusDataSource.dart';
import 'package:cariro_implant_academy/core/data/repositories/loginStatusRepoImpl.dart';
import 'package:cariro_implant_academy/core/domain/repositories/loginStatusRepo.dart';
import 'package:cariro_implant_academy/core/domain/useCases/checkLogInStatus.dart';
import 'package:cariro_implant_academy/core/presentation/bloc/siteChange/siteChange_bloc.dart';
import 'package:cariro_implant_academy/data/authentication/dataSources/aut_ASP_DataSource.dart';
import 'package:cariro_implant_academy/data/authentication/repositories/authenticationRepoImpl.dart';
import 'package:cariro_implant_academy/domain/authentication/repositories/authenticationRepo.dart';
import 'package:cariro_implant_academy/domain/authentication/useCases/loginUseCase.dart';
import 'package:cariro_implant_academy/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

init() {
  /*************************
   * Features
   **************************/
  /**
   * Authentication
   */
  //bloc
  sl.registerFactory(() => AuthenticationBloc(
        loginUseCase: sl(),
        checkLoginStatusUseCase: sl(),
      ));
  //use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => CheckLoginStatusUseCase(sl()));
  //repos
  sl.registerLazySingleton<AuthenticationRepo>(() => AuthenticationRepoImpl(sl()));
  sl.registerLazySingleton<CheckLoginStatusRepo>(() => LoginStatusRepoImpl(sl()));
  //dataSources
  sl.registerLazySingleton<Auth_ASP_DataSource>(() => Auth_ASP_DataSourceImpl(sl()));
  sl.registerLazySingleton<LoginStatusDataSource>(() => LoginStatusDataSourceImpl(sl()));
  //external
  sl.registerLazySingleton<HttpRepo>(() => HttpClientImpl());

  /**
   * Site Change
   */
  //bloc
  sl.registerFactory(() => SiteChangeBloc());
}
