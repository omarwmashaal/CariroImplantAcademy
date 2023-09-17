import 'package:cariro_implant_academy/Widgets/AppBarBloc.dart';
import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/data/dataSources/imageDataSource.dart';
import 'package:cariro_implant_academy/core/data/dataSources/loadingDatasource.dart';
import 'package:cariro_implant_academy/core/data/dataSources/loginStatusDataSource.dart';
import 'package:cariro_implant_academy/core/data/dataSources/notificationDataSource.dart';
import 'package:cariro_implant_academy/core/data/repositories/inputValidationRepoImpl.dart';
import 'package:cariro_implant_academy/core/data/repositories/loadingRepoImpl.dart';
import 'package:cariro_implant_academy/core/data/repositories/loginStatusRepoImpl.dart';
import 'package:cariro_implant_academy/core/data/repositories/notificationRepoImpl.dart';
import 'package:cariro_implant_academy/core/domain/repositories/imagesRepo.dart';
import 'package:cariro_implant_academy/core/domain/repositories/inputValidationRepo.dart';
import 'package:cariro_implant_academy/core/domain/repositories/loadingRepo.dart';
import 'package:cariro_implant_academy/core/domain/repositories/loginStatusRepo.dart';
import 'package:cariro_implant_academy/core/domain/repositories/notificationRepo.dart';
import 'package:cariro_implant_academy/core/domain/useCases/checkLogInStatus.dart';
import 'package:cariro_implant_academy/core/domain/useCases/downloadImageUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/getNotificationsUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadCandidateBatchesUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadCandidateByBatchIdUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/selectImageUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/uploadImageUseCase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/data/datasource/receiptsDatasource.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/data/repositories/receiptRepoImpl.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/repositories/receiptReposiotry.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/usecases/addPatientReceiptUseCase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/usecases/addPaymentUsecase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/usecases/getAllPaymentLogsUsecase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/usecases/getLastReceiptUsecase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/usecases/getPaymentLogsForAReceiptUsecase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/usecases/getReceiptByIdUsecase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/usecases/getReceipts.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/usecases/getTodaysReceiptUsecase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/usecases/getTotalDeptUseCase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/usecases/removePaymentUsecase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/blocs/receiptBloc.dart';
import 'package:cariro_implant_academy/core/features/coreStock/data/datasources/coreStockDatasource.dart';
import 'package:cariro_implant_academy/core/features/coreStock/data/repositories/coreStockRepoImpl.dart';
import 'package:cariro_implant_academy/core/features/coreStock/domain/repositories/coreStockRepository.dart';
import 'package:cariro_implant_academy/core/features/coreStock/domain/usecases/consumeItemById.dart';
import 'package:cariro_implant_academy/core/features/coreStock/domain/usecases/consumeItemByName.dart';
import 'package:cariro_implant_academy/core/features/settings/data/datasources/settingsDatasource.dart';
import 'package:cariro_implant_academy/core/features/settings/data/repositories/settingsRepoImpl.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getImplantCompaniesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getMembraneCompaniesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getMembranesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getTacsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getTreatmentPricesUseCase.dart';
import 'package:cariro_implant_academy/core/presentation/bloc/dropdownSearchBloc.dart';
import 'package:cariro_implant_academy/core/presentation/bloc/siteChange/siteChange_bloc.dart';
import 'package:cariro_implant_academy/data/authentication/dataSources/aut_ASP_DataSource.dart';
import 'package:cariro_implant_academy/data/authentication/repositories/authenticationRepoImpl.dart';
import 'package:cariro_implant_academy/domain/authentication/repositories/authenticationRepo.dart';
import 'package:cariro_implant_academy/domain/authentication/useCases/loginUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/addToMyPatientsUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/checkDuplicateIdUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/checkDuplicateNumberUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/createPatientUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getPatientDataUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getVisitsUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/patientEntersClinicUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/patientLeavesClinicUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/patientVisitsUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/removeFromMyPatientsUseCase.dart';
import 'package:cariro_implant_academy/features/patient/data/datasources/roomDatasource.dart';
import 'package:cariro_implant_academy/features/patient/data/datasources/visitsDatasource.dart';
import 'package:cariro_implant_academy/features/patient/data/repositories/roomRepoImpl.dart';
import 'package:cariro_implant_academy/features/patient/data/repositories/vistisRepoImpl.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/roomRepo.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/visitsRepo.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getAllSchedulesUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getAvailableRoomsUsecase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getRoomsUsecase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/scheduleNewVisit.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/calendarBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientVisitsBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/data/datasources/dentalHistoryDatasource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/domain/useCases/getDentalHistoryUseCsae.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/data/datasources/medicalHistoryDatasource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/data/repositories/medicalHistoryRepoImpl.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/domain/repositories/medicalExaminationRepo.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/domain/usecases/getMedicalExaminationUseCsae.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/presentation/bloc/medicaHistoryBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/data/datasources/nonSurgicalTreatmentDatasource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/data/repositories/nonSurgicalTreatmentRpoImpl.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/repositories/nonSurgicalTreatmentRepo.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/usecases/checkNonSurgicalTreatementTeethStatusUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/usecases/getAllNonSurgicalTreatmentsUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/usecases/getNonSurgicalTreatmentUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/usecases/getTreatmentPlanItemUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/usecases/saveNonSurgicalTreatmentUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/datasources/prostheticDatasource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/repositories/prostheticRepoImpl.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/repositories/prostheticRepository.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/usecases/getPatientProstheticTreatmentDiagnosticUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/usecases/getPatientProstheticTreatmentFinalProthesisFullArchUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/usecases/updatePatientProstheticTreatmentFinalProthesisFullArchUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/datasources/surgicalTreatmentDatasource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/datasources/treatmentPlanDataSource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/repositories/surgicalTreatmentRepoImpl.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/repositories/treatmentPlanRepoImpl.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/surgicalTreatmentRepo.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/treatmentPlanRepo.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/consumeImplantUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/getSurgicalTreatmentUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/getTreatmentPlanUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/saveSurgicalTreatmentUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/saveTreatmentPlanUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc.dart';
import 'package:cariro_implant_academy/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:cariro_implant_academy/presentation/bloc/imagesBloc.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc_States.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalPagesStatesChangesBloc.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalPagesStatesChangesBloc_States.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/patient/data/datasources/addOrRemoveMyPatientsDataSource.dart';
import '../features/patient/data/datasources/patientSearchDataSource.dart';
import '../features/patient/data/repositories/addOrRemoveMyPatientsRepoImpl.dart';
import '../features/patient/data/repositories/patientInfoRepoImpl.dart';
import '../features/patient/domain/repositories/addOrRemoveMyPatientsRangeRepo.dart';
import '../features/patient/domain/repositories/patientInfoRepo.dart';
import '../features/patient/domain/usecases/addRangeToMyPatientsUseCase.dart';
import '../features/patient/domain/usecases/getNextAvailableIdUseCase.dart';
import '../features/patient/domain/usecases/patientSearchUseCase.dart';
import '../features/patient/domain/usecases/getMySchedulesUseCase.dart';
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
import '../features/patientsMedical/prosthetic/domain/usecases/getPatientProstheticTreatmentFinalProthesisSingleBridge.dart';
import '../features/patientsMedical/prosthetic/domain/usecases/updatePatientProstheticTreatmentDiagnosticUseCase.dart';
import '../features/patientsMedical/prosthetic/domain/usecases/updatePatientProstheticTreatmentFinalProthesisSingleBridgeUseCase.dart';
import '../features/patient/presentation/bloc/addOrRemoveMyPatientsBloc.dart';
import '../features/patient/presentation/bloc/createOrViewPatientBloc.dart';
import '../features/patient/presentation/bloc/patientSearchBloc.dart';
import 'data/repositories/imageRepoImpl.dart';
import 'features/settings/domain/useCases/getImplantLinesUseCase.dart';
import 'features/settings/domain/useCases/getImplantSizesUseCase.dart';

final sl = GetIt.instance;

init() async {
  //Shared preferences
  sl.registerSingletonAsync<SharedPreferences>(() => SharedPreferences.getInstance());
  await sl.isReady<SharedPreferences>(); // Add this line

  /**
   * Core
   */
  //bloc
  sl.registerFactory(() => DropDownSearchBloc(DropDownBlocStates()));
  //usecase
  sl.registerLazySingleton(() => LoadUsersUseCase(loadingRepo: sl()));
  sl.registerLazySingleton(() => LoadCandidateBatchesUseCase(loadingRepo: sl()));
  sl.registerLazySingleton(() => LoadCandidatesByBatchId(loadingRepo: sl()));
  //repo
  sl.registerLazySingleton<LoadingRepo>(() => LoadingRepoImpl(loadingDatasource: sl()));
  //datasource
  sl.registerLazySingleton<LoadingDatasource>(() => LoadingDataSourceImpl(httpRepo: sl()));

  /**
   * Calendar
   */
  //bloc
  sl.registerFactory(() => CalendarBloc(
        getAllSchedulesUseCase: sl(),
        getRoomsUseCase: sl(),
        getAvailableRoomsUseCase: sl(),
        getMySchedulesUseCase: sl(),
        scheNewVisitUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => GetAllSchedulesUseCase(visitsRepo: sl()));
  sl.registerLazySingleton(() => GetMySchedulesUseCase(visitsRepo: sl()));
  sl.registerLazySingleton(() => GetRoomsUseCase(roomRepo: sl()));
  sl.registerLazySingleton(() => GetAvailableRoomsUseCase(roomRepo: sl()));
  sl.registerLazySingleton(() => ScheduleNewVisitUseCase(visitsRepo: sl()));
  //repo
  sl.registerLazySingleton<VisitsRepo>(() => VisitsRepoImpl(visitsDataSource: sl()));
  sl.registerLazySingleton<RoomRepo>(() => RoomRepoImpl(roomDatasource: sl()));
  //datasource
  sl.registerLazySingleton<VisitsDataSource>(() => VisitsDatasourceImpl(httpRepo: sl()));
  sl.registerLazySingleton<RoomDatasource>(() => RoomDatasourceImpl(httpRepo: sl()));

  /**
   * Settings
   */
  //usecases
  sl.registerLazySingleton(() => GetTreatmentPricesUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetImplantCompaniesUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetImplantLinesUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetImplantSizesUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetMembranesUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetMembraneCompaniesUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetTacsUseCase(settingsRepository: sl()));
  //repositories
  sl.registerLazySingleton<SettingsRepository>(() => SettingsRepoImpl(settingsDatasource: sl()));
  //datasources
  sl.registerLazySingleton<SettingsDatasource>(() => SettingsDatasourceImpl(httpRepo: sl()));

  /**
   * Stock
   */
  //usecases
  sl.registerLazySingleton(() => ConsumeItemByIdUseCase(coreStockRepository: sl()));
  sl.registerLazySingleton(() => ConsumeItemByNameUseCase(coreStockRepository: sl()));
  //repositoies
  sl.registerLazySingleton<CoreStockRepository>(() => CoreStockRepoImpl(coreStockDatasource: sl()));
  //datsource
  sl.registerLazySingleton<CoreStockDatasource>(() => CoreStockDatasourceImpl(httpRepo: sl()));

  /**
   * Receipt
   */
  //bloc
  sl.registerFactory(() => ReceiptBloc(
        getReceiptsUsecase: sl(),
        getReceiptByIdUseCase: sl(),
        getPaymentLogsForAReceipt: sl(),
        removePaymentUseCase: sl(),
        addPaymentUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => AddPaymentUseCase(receiptRepository: sl()));
  sl.registerLazySingleton(() => GetAllPaymentLogsUsecase(receiptRepository: sl()));
  sl.registerLazySingleton(() => GetLastReceiptUsecase(receiptRepository: sl()));
  sl.registerLazySingleton(() => GetPaymentLogsForAReceiptUseCase(receiptRepository: sl()));
  sl.registerLazySingleton(() => GetReceiptByIdUseCase(receiptRepository: sl()));
  sl.registerLazySingleton(() => GetReceiptsUsecase(receiptRepository: sl()));
  sl.registerLazySingleton(() => GetTodaysReceiptUsecase(receiptRepository: sl()));
  sl.registerLazySingleton(() => RemovePaymentUseCase(receiptRepository: sl()));
  sl.registerLazySingleton(() => GetTotalDebtUsecase(receiptRepository: sl()));
  sl.registerLazySingleton(() => AddPatientReceiptUseCase(receiptRepository: sl()));
  //REPOS
  sl.registerLazySingleton<ReceiptRepository>(() => ReceiptRepositoryImpl(receiptDataSource: sl()));
  //datasource
  sl.registerLazySingleton<ReceiptsDatasource>(() => ReceiptsDatasourceImpl(httpRepo: sl()));

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
  sl.registerFactory(() => AddToMyPatientsRangeBloc(
        addRangeUseCase: sl(),
        addToMyPatientsUseCase: sl(),
        removeFromMyPatientsUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => PatientSearchUseCase(sl()));
  sl.registerLazySingleton(() => AddRangeToMyPatientsUseCase(sl()));
  sl.registerLazySingleton(() => AddToMyPatientsUseCase(patientInfoRepo: sl(), addOrRemoveMyPatientsRepo: sl()));
  sl.registerLazySingleton(() => RemoveFromMyPatientsUseCase(patientInfoRepo: sl(), addOrRemoveMyPatientsRepo: sl()));
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
   * Patient Visits
   * **/
  //bloc
  sl.registerFactory(() => PatientVisitsBloc(
        getVisitsUseCase: sl(),
        getPatientDataUseCase: sl(),
        patientEntersClinicUseCase: sl(),
        patientLeavesClinicUseCase: sl(),
        patientVisitsUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => GetVisitsUseCase(visitsRepo: sl()));
  sl.registerLazySingleton(() => PatientLeavesClinicUseCase(visitsRepo: sl()));
  sl.registerLazySingleton(() => PatientEntersClinicUseCase(visitsRepo: sl()));
  sl.registerLazySingleton(() => PatientVisitsUseCase(visitsRepo: sl()));
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
  sl.registerFactory(() => MedicalInfoShellBloc());
  sl.registerFactory(() => MedicalPagesStatesChangesBloc(Initial()));

  /**
   * Non Surgical Treatment
   */

  //bloc
  sl.registerFactory(() => NonSurgicalTreatmentBloc(
        checkNonSurgicalTreatmentTeethStatusUseCase: sl(),
        getNonSurgicalTreatmentUseCase: sl(),
        getAllNonSurgicalTreatmentsUseCase: sl(),
        saveNonSurgicalTreatmentUseCase: sl(),
        getDentalExaminationUseCase: sl(),
        saveDentalExaminationUseCase: sl(),
        getTreatmentPlanItemUsecase: sl(),
        addPatientReceiptUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => GetNonSurgicalTreatmentUseCase(nonSurgicalTreatmentRepo: sl()));
  sl.registerLazySingleton(() => SaveNonSurgicalTreatmentUseCase(nonSurgicalTreatmentRepo: sl()));
  sl.registerLazySingleton(() => GetAllNonSurgicalTreatmentsUseCase(nonSurgicalTreatmentRepo: sl()));
  sl.registerLazySingleton(() => CheckNonSurgicalTreatmentTeethStatusUseCase(nonSurgicalTreatmentRepo: sl()));
  sl.registerLazySingleton(() => GetTreatmentPlanItemUsecase(nonSurgicalTreatmentRepo: sl()));
  //repo
  sl.registerLazySingleton<NonSurgicalTreatmentRepo>(() => NonSurgicalTreatmentRepoImpl(nonSurgicalTreatmentDatasource: sl()));
  //datasource
  sl.registerLazySingleton<NonSurgicalTreatmentDatasource>(() => NonSurgicalTreatmentDatasourceImpl(httpRepo: sl()));

  /**
   * Treatment
   */
  //bloc
  sl.registerFactory(() => TreatmentBloc(
        saveTreatmentPlanUseCase: sl(),
        getTreatmentPlanUseCase: sl(),
        getTreatmentPricesUseCase: sl(),
        consumeImplantUseCase: sl(),
        consumeItemByIdUseCase: sl(),
        consumeItemByNameUseCase: sl(),
        getSurgicalTreatmentUseCase: sl(),
        saveSurgicalTreatmentUseCase: sl(),
        getTacsUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => SaveTreatmentPlanUseCase(treatmentPlanRepo: sl()));
  sl.registerLazySingleton(() => GetTreatmentPlanUseCase(treatmentPlanRepo: sl()));
  sl.registerLazySingleton(() => ConsumeImplantUseCase(treatmentPlanRepo: sl()));
  sl.registerLazySingleton(() => GetSurgicalTreatmentUseCase(surgicalTreatmentRepo: sl()));
  sl.registerLazySingleton(() => SaveSurgicalTreatmentUseCase(surgicalTreatmentRepo: sl()));

  //repositories
  sl.registerLazySingleton<TreatmentPlanRepo>(() => TreatmentPlanRepoImplementation(treatmentPlanDataSource: sl()));
  sl.registerLazySingleton<SurgicalTreatmentRepo>(() => SurgicalTreatmentRepoImpl(surgicalTreatmentDatasource: sl()));
  //datasources
  sl.registerLazySingleton<TreatmentPlanDataSource>(() => TreatmentPlanDatasourceImpl(httpRepo: sl()));
  sl.registerLazySingleton<SurgicalTreatmentDatasource>(() => SurgicalTreatmentDatasourceImpl(httpRepo: sl()));

  /**
   * Prosthetic Treatment
   */
  //bloc
  sl.registerFactory(() => ProstheticBloc(
        getPatientProstheticTreatmentFinalProthesisSingleBridgeUseCase: sl(),
        getPatientProstheticTreatmentFinalProthesisFullArchUseCase: sl(),
        getPatientProstheticTreatmentDiagnosticUseCase: sl(),
        updatePatientProstheticTreatmentFinalProthesisSingleBridgeUseCase: sl(),
        updatePatientProstheticTreatmentFinalProthesisFullArchUseCase: sl(),
        updatePatientProstheticTreatmentDiagnosticUseCase: sl(),
      ));

  //usecases
  sl.registerLazySingleton(() => GetPatientProstheticTreatmentDiagnosticUseCase(prostheticRepository: sl()));
  sl.registerLazySingleton(() => GetPatientProstheticTreatmentFinalProthesisSingleBridgeUseCase(prostheticRepository: sl()));
  sl.registerLazySingleton(() => GetPatientProstheticTreatmentFinalProthesisFullArchUseCase(prostheticRepository: sl()));
  sl.registerLazySingleton(() => UpdatePatientProstheticTreatmentDiagnosticUseCase(prostheticRepository: sl()));
  sl.registerLazySingleton(() => UpdatePatientProstheticTreatmentFinalProthesisSingleBridgeUseCase(prostheticRepository: sl()));
  sl.registerLazySingleton(() => UpdatePatientProstheticTreatmentFinalProthesisFullArchUseCase(prostheticRepository: sl()));
  //respositories
  sl.registerLazySingleton<ProstheticRepository>(() => ProstheticRepoImpl(prostheticDatasource: sl()));
  //datasource
  sl.registerLazySingleton<ProstheticDatasource>(() => ProstheticDatasourceImpl(httpRepo: sl()));
}
