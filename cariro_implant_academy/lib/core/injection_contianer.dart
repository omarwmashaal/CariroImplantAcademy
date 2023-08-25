import 'package:cariro_implant_academy/Widgets/AppBarBloc.dart';
import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/data/dataSources/imageDataSource.dart';
import 'package:cariro_implant_academy/core/data/dataSources/loginStatusDataSource.dart';
import 'package:cariro_implant_academy/core/data/dataSources/notificationDataSource.dart';
import 'package:cariro_implant_academy/core/data/repositories/inputValidationRepoImpl.dart';
import 'package:cariro_implant_academy/core/data/repositories/loginStatusRepoImpl.dart';
import 'package:cariro_implant_academy/core/data/repositories/notificationRepoImpl.dart';
import 'package:cariro_implant_academy/core/domain/repositories/imagesRepo.dart';
import 'package:cariro_implant_academy/core/domain/repositories/inputValidationRepo.dart';
import 'package:cariro_implant_academy/core/domain/repositories/loginStatusRepo.dart';
import 'package:cariro_implant_academy/core/domain/repositories/notificationRepo.dart';
import 'package:cariro_implant_academy/core/domain/useCases/checkLogInStatus.dart';
import 'package:cariro_implant_academy/core/domain/useCases/downloadImageUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/getNotificationsUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/selectImageUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/uploadImageUseCase.dart';
import 'package:cariro_implant_academy/core/presentation/bloc/siteChange/siteChange_bloc.dart';
import 'package:cariro_implant_academy/data/authentication/dataSources/aut_ASP_DataSource.dart';
import 'package:cariro_implant_academy/data/authentication/repositories/authenticationRepoImpl.dart';
import 'package:cariro_implant_academy/domain/authentication/repositories/authenticationRepo.dart';
import 'package:cariro_implant_academy/domain/authentication/useCases/loginUseCase.dart';
import 'package:cariro_implant_academy/domain/patients/usecases/addToMyPatientsUseCase.dart';
import 'package:cariro_implant_academy/domain/patients/usecases/checkDuplicateIdUseCase.dart';
import 'package:cariro_implant_academy/domain/patients/usecases/checkDuplicateNumberUseCase.dart';
import 'package:cariro_implant_academy/domain/patients/usecases/createPatientUseCase.dart';
import 'package:cariro_implant_academy/domain/patients/usecases/getPatientDataUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/data/datasources/dentalHistoryDatasource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/domain/useCases/getDentalHistoryUseCsae.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/data/datasources/medicalHistoryDatasource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/data/repositories/medicalHistoryRepoImpl.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/domain/repositories/medicalExaminationRepo.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/domain/usecases/getMedicalExaminationUseCsae.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/presentation/bloc/medicaHistoryBloc.dart';
import 'package:cariro_implant_academy/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:cariro_implant_academy/presentation/bloc/imagesBloc.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc_States.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalPagesStatesChangesBloc.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalPagesStatesChangesBloc_States.dart';
import 'package:get_it/get_it.dart';

import '../data/patients/dataSrouces/addOrRemoveMyPatientsDataSource.dart';
import '../data/patients/dataSrouces/patientSearchDataSource.dart';
import '../data/patients/repositories/addOrRemoveMyPatientsRepoImpl.dart';
import '../data/patients/repositories/patientInfoRepoImpl.dart';
import '../domain/patients/repositories/addOrRemoveMyPatientsRangeRepo.dart';
import '../domain/patients/repositories/patientInfoRepo.dart';
import '../domain/patients/usecases/addRangeToMyPatientsUseCase.dart';
import '../domain/patients/usecases/getNextAvailableIdUseCase.dart';
import '../domain/patients/usecases/patientSearchUseCase.dart';
import '../features/patientsMedical/dentalExamination/data/datasources/dentalExaminationDataSource.dart';
import '../features/patientsMedical/dentalExamination/data/repositories/dentalExaminationRepoImpl.dart';
import '../features/patientsMedical/dentalExamination/domain/repositories/dentalExaminationRepo.dart';
import '../features/patientsMedical/dentalExamination/domain/useCases/getDentalExaminationUseCsae.dart';
import '../features/patientsMedical/dentalExamination/domain/useCases/saveDentalExaminationUseCsae.dart';
import '../features/patientsMedical/dentalExamination/presentation/bloc/dentalExaminationBloc.dart';
import '../features/patientsMedical/dentalHistroy/data/repositories/dentalHistoryRepoImpl.dart';
import '../features/patientsMedical/dentalHistroy/domain/repositories/dentalHistoryRepo.dart';
import '../features/patientsMedical/dentalHistroy/domain/useCases/saveDentalHistoryUseCsae.dart';
import '../features/patientsMedical/dentalHistroy/presentaion/bloc/dentalHistoryBloc.dart';
import '../features/patientsMedical/medicalExamination/domain/usecases/saveMedicalExaminationUseCsae.dart';
import '../presentation/patients/bloc/addOrRemoveMyPatientsBloc.dart';
import '../presentation/patients/bloc/createOrViewPatientBloc.dart';
import '../presentation/patients/bloc/patientSearchBloc.dart';
import 'data/repositories/imageRepoImpl.dart';

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

  /**
   * Patient Search
   */

  //bloc
  sl.registerFactory(() => PatientSearchBloc(searchUseCase: sl()));
  sl.registerFactory(() => AddToMyPatientsRangeBloc(addRangeUseCase: sl(), addToMyPatientsUseCase: sl()));
  //usecases
  sl.registerLazySingleton(() => PatientSearchUseCase(sl()));
  sl.registerLazySingleton(() => AddRangeToMyPatientsUseCase(sl()));
  sl.registerLazySingleton(() => AddToMyPatientsUseCase(patientInfoRepo: sl(), addOrRemoveMyPatientsRepo: sl()));
  //repo
  sl.registerLazySingleton<PatientInfoRepo>(() => PatientInfoRepoImpl(sl()));
  sl.registerLazySingleton<AddOrRemoveMyPatientsRepo>(() => AddOrRemoveMyPatientsRepoImpl(sl()));
  //dataSource
  sl.registerLazySingleton<PatientSearchDataSource>(() => PatientSearchDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AddOrRemoveMyPatientsDataSource>(() => AddOrRemoveMyPatientsDataSourceImpl(sl()));

  /**
   * Create or view patient
   */
  //bloc
  sl.registerFactory(() => CreateOrViewPatientBloc(
        checkDuplicateIdUseCase: sl(),
        checkDuplicateNumberUseCase: sl(),
        createPatientUseCase: sl(),
        getNextAvailableIdUseCase: sl(),
        patientSearchUseCase: sl(),
        getPatientDataUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => CreatePatientUseCase(patientInfoRepo: sl(), imageRepo: sl()));
  sl.registerLazySingleton(() => CheckDuplicateNumberUseCase(patientRepo: sl(), inputValidationRepo: sl()));
  sl.registerLazySingleton(() => CheckDuplicateIdUseCase(sl()));
  sl.registerLazySingleton(() => GetNextAvailableIdUseCase(sl()));
  sl.registerLazySingleton(() => GetPatientDataUseCase(patientRepo: sl()));
  //repos
  sl.registerLazySingleton<InputValidationRepo>(() => InputValidationRepoImpl());
  //dataSources

  /**
   * Image Features
   */

  //bloc
  sl.registerFactory(() => ImageBloc(uploadImageUseCase: sl(), selectImageUseCase: sl(), downloadImageUseCase: sl()));
  //usecases
  sl.registerLazySingleton(() => SelectImageUseCase());
  sl.registerLazySingleton(() => UploadImageUseCase(imageRepo: sl()));
  sl.registerLazySingleton(() => DownloadImageUseCase(imageRepo: sl()));
  //repos
  sl.registerLazySingleton<ImageRepo>(() => ImageRepoImpl(dataSource: sl()));
  //dataSources
  sl.registerLazySingleton<ImageDataSource>(() => ImageDataSourceImpl(httpRepo: sl()));

  /**
   * AppBar
   */
  //bloc
  sl.registerLazySingleton(() => AppBarBloc(getNotificationsUseCase: sl()));
  //usecases
  sl.registerLazySingleton(() => GetNotificationsUseCase(notificationRepo: sl()));
  //repo
  sl.registerLazySingleton<NotificationRepo>(() => NotificationRepoImpl(notificationDataSource: sl()));
  //datasource
  sl.registerLazySingleton<NotificationDataSource>(() => NotificationDataSourceImpl(httpRepo: sl()));
  /**
   * PatientMedical
   */

  /*
  * Medical History
   */

  //bloc
  sl.registerFactory(() => MedicalHistoryBloc(
        getMedicalExaminationUseCase: sl(),
        saveMedicalExaminationUseCase: sl(),
      ));
  //usecase
  sl.registerLazySingleton(() => GetMedicalExaminationUseCase(medicalExaminationRepo: sl()));
  sl.registerLazySingleton(() => SaveMedicalExaminationUseCase(medicalExaminationRepo: sl()));
  //Repo
  sl.registerLazySingleton<MedicalHistoryRepo>(() => MedicalHistoryRepoImpl(medicalHistoryDataSource: sl()));
  //Datasource
  sl.registerLazySingleton<MedicalHistoryDatasource>(() => MedicalHistoryDatasourceImpl(httpRepo: sl()));
   
   
    /*
    * Dental History
   */

  //bloc
  sl.registerFactory(() => DentalHistoryBloc(
        getDentalHistoryUseCase: sl(),
        saveDentalHistoryUseCase: sl(),
      ));
  //usecase
  sl.registerLazySingleton(() => GetDentalHistoryUseCase(dentalHistoryRepo: sl()));
  sl.registerLazySingleton(() => SaveDentalHistoryUseCase(dentalHistoryRepo: sl()));
  //Repo
  sl.registerLazySingleton<DentalHistoryRepo>(() => DentalHistoryRepoImpl(dentalHistoryDataSource: sl()));
  //Datasource
  sl.registerLazySingleton<DentalHistoryDataSource>(() => DentalHistoryDataSrouceImpl(httpRepo: sl()));
    
    /*
    * Dental Examination
   */

  //bloc
  sl.registerFactory(() => DentalExaminationBloc(
        getDentalExaminationUseCase: sl(),
        saveDentalExaminationUseCase: sl(),
      ));
  //usecase
  sl.registerLazySingleton(() => GetDentalExaminationUseCase(dentalExaminationRepo: sl()));
  sl.registerLazySingleton(() => SaveDentalExaminationUseCase(dentalExaminationRepo: sl()));
  //Repo
  sl.registerLazySingleton<DentalExaminationRepo>(() => DentalExaminationRepoImpl(dentalExaminationDataSource: sl()));
  //Datasource
  sl.registerLazySingleton<DentalExaminationDataSource>(() => DentalExaminationDatasourceImpl(httpRepo: sl()));
  
  //bloc
  sl.registerFactory(() => MedicalInfoShellBloc(MedicalInfoBlocChangeViewEditState(edit: false)));
  sl.registerFactory(() => MedicalPagesStatesChangesBloc(Initial()));
  }
