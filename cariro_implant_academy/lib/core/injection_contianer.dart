import 'package:cariro_implant_academy/Controllers/SiteController.dart';
import 'package:cariro_implant_academy/SignalR/SignalR.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc.dart';
import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/data/dataSources/imageDataSource.dart';
import 'package:cariro_implant_academy/core/data/dataSources/loadingDatasource.dart';
import 'package:cariro_implant_academy/core/data/dataSources/loginStatusDataSource.dart';
import 'package:cariro_implant_academy/core/data/repositories/inputValidationRepoImpl.dart';
import 'package:cariro_implant_academy/core/data/repositories/loadingRepoImpl.dart';
import 'package:cariro_implant_academy/core/data/repositories/loginStatusRepoImpl.dart';
import 'package:cariro_implant_academy/core/domain/repositories/imagesRepo.dart';
import 'package:cariro_implant_academy/core/domain/repositories/inputValidationRepo.dart';
import 'package:cariro_implant_academy/core/domain/repositories/loadingRepo.dart';
import 'package:cariro_implant_academy/core/domain/repositories/loginStatusRepo.dart';
import 'package:cariro_implant_academy/core/domain/useCases/checkLogInStatus.dart';
import 'package:cariro_implant_academy/core/domain/useCases/downloadImageUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadCandidateBatchesUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadCandidateByBatchIdUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadWorPlacesUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/selectImageUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/uploadImageUseCase.dart';
import 'package:cariro_implant_academy/core/features/authentication/domain/usecases/registerUserUseCase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/data/datasource/receiptsDatasource.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/data/repositories/receiptRepoImpl.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/repositories/receiptReposiotry.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/usecases/addPatientReceiptUseCase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/usecases/addPaymentUsecase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/usecases/addReceiptUseCase.dart';
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
import 'package:cariro_implant_academy/core/features/notification/data/datasource/notificationDataSource.dart';
import 'package:cariro_implant_academy/core/features/notification/data/repositories/notificationRepoImpl.dart';
import 'package:cariro_implant_academy/core/features/notification/domain/repositories/notificationRepo.dart';
import 'package:cariro_implant_academy/core/features/notification/domain/usecases/getNotificationsUseCase.dart';
import 'package:cariro_implant_academy/core/features/notification/domain/usecases/markAllNotificationsAsReadUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/data/datasources/settingsDatasource.dart';
import 'package:cariro_implant_academy/core/features/settings/data/repositories/settingsRepoImpl.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addLabItemCompaniesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addLabItemShadesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addLabItemsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addLabOptionsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getDefaultProstheticComplicationsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getDefaultSurgicalComplicationsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getImplantCompaniesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getIncomeCategoriesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabItemParentsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabOptionsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabThresholdSettingsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getMedicalExpensesCategoriesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getMembraneCompaniesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getMembranesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getNonMedicalNonStockExpensesCategories.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getPaymentMethodsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getProstheticItemsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getProstheticNextVisitUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getProstheticMaterialUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getProstheticTechniqueUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getProstheticStatusUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getStockCategoriesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getSuppliersUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getTacsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getTeethClinicPrice.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/updateDefaultProstheticComplicationsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/updateDefaultSurgicalComplicationsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/updateLabOptionsPriceListUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/updateLabThresholdSettingsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/updateProstheticItemsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/updateProstheticNextVisitUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/updateProstheticTechniqueUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/updateProstheticMaterialUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/updateProstheticStatusUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/updateTeethClinicPrice.dart';
import 'package:cariro_implant_academy/core/helpers/dialogHelper.dart';
import 'package:cariro_implant_academy/core/presentation/bloc/dropdownSearchBloc.dart';
import 'package:cariro_implant_academy/core/presentation/bloc/siteChange/siteChange_bloc.dart';
import 'package:cariro_implant_academy/core/features/authentication/data/datasources/aut_ASP_DataSource.dart';
import 'package:cariro_implant_academy/core/features/authentication/data/repositories/authenticationRepoImpl.dart';
import 'package:cariro_implant_academy/core/features/authentication/domain/repositories/authenticationRepo.dart';
import 'package:cariro_implant_academy/core/features/authentication/domain/usecases/loginUseCase.dart';
import 'package:cariro_implant_academy/core/routing/routingBloc.dart';
import 'package:cariro_implant_academy/features/cashflow/data/datasources/cashFlowDatasources.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/repostiories/cashFlowRepository.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/addExpensesUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/addIncomeUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/addSettlementUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/createInstallmentPlanUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/getIncomeByCategoryUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/getInstallmentPlanForUserUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/getSummaryUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/listExpensesUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/listIncomeUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/payInstallmentUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/bloc/cashFlowBloc.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/data/datasources/clinicTreatmentDatasource.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/data/repositories/clinicTreatmentRepoImpl.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/repositories/clinicTreatmentRepo.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/useCases/getDoctorPercentageForPatientUseCase.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/useCases/getTreatmentsUseCase.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/useCases/updateClinicReceiptUseCase.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/useCases/updateTreatmentsUseCase.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc.dart';
import 'package:cariro_implant_academy/features/labRequest/data/datasource/labCustomerDatasource.dart';
import 'package:cariro_implant_academy/features/labRequest/data/datasource/labRequestDatasource.dart';
import 'package:cariro_implant_academy/features/labRequest/data/repositories/labRequestsRepository.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labCustomersRepository.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/getAllRequestsUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/getDefaultStepsUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/getLabItemStepsFroRequestUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestBloc.dart';
import 'package:cariro_implant_academy/features/patient/data/datasources/complainsDatasource.dart';
import 'package:cariro_implant_academy/features/patient/data/datasources/roomDatasource.dart';
import 'package:cariro_implant_academy/features/patient/data/datasources/toDoListDatasource.dart';
import 'package:cariro_implant_academy/features/patient/data/datasources/visitsDatasource.dart';
import 'package:cariro_implant_academy/features/patient/data/repositories/complainsRepositoryImpl.dart';
import 'package:cariro_implant_academy/features/patient/data/repositories/roomRepoImpl.dart';
import 'package:cariro_implant_academy/features/patient/data/repositories/toDoListRepoImpl.dart';
import 'package:cariro_implant_academy/features/patient/data/repositories/vistisRepoImpl.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/complainsRepository.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/roomRepo.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/toDoListRepo.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/visitsRepo.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/addComplainUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/addToDoListItemUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/addToMyPatientsUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/advancedProstheticSearchUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/advancedSearchPatientsUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/advancedTreatmentSearchUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/checkDuplicateIdUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/checkDuplicateNumberUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/createPatientUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getAllSchedulesUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getAvailableRoomsUsecase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getComplainsUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getPatientDataUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getRoomsUsecase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getToDoListUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getVisitsUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/patientEntersClinicUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/patientLeavesClinicUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/patientVisitsUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/removeFromMyPatientsUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/resolveComplaiUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/scheduleNewVisit.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/searchToDoListUseCase%20.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/updateComplainNotesUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/updatePatientDataUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/updateToDoListItemUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/updateVisit.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/advancedSearchBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/calendarBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/complainBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientVisitsBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/toDoListBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/data/datasources/complicationsDatasource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/data/repositories/complicationsRepository.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/repositories/complicationsRepository.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/useCases/getSurgeryTeethForComplicationsUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/useCases/udpateComplicationsAfterSurgeryUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/presentation/bloc/complicationsBloc.dart';
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
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/datasources/postSurgicalTreatmentDatasource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/datasources/treatmentPlanDataSource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/repositories/postSurgicalTreatmentRepoImpl.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/repositories/treatmentPlanRepoImpl.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/postSurgicalTreatmentRepo.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/treatmentPlanRepo.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/acceptChangesUseCASE.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/consumeImplantUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/getPostSurgicalTreatmentUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/getTreatmentDetailsUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/getTreatmentItemUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/getTreatmentPlanUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/savePostSurgeryDataUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/saveTreatmentDetailsUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/saveTreatmentPlanUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc.dart';
import 'package:cariro_implant_academy/features/stock/data/datasource/stockDatasource.dart';
import 'package:cariro_implant_academy/features/stock/data/repositories/stockRepoImpl.dart';
import 'package:cariro_implant_academy/features/stock/domain/repositories/stockRepository.dart';
import 'package:cariro_implant_academy/features/stock/domain/usecases/getLabStockUseCase.dart';
import 'package:cariro_implant_academy/features/stock/domain/usecases/getStockByNameUseCase.dart';
import 'package:cariro_implant_academy/features/stock/domain/usecases/getStockUseCase.dart';
import 'package:cariro_implant_academy/features/stock/presentation/bloc/stockBloc.dart';
import 'package:cariro_implant_academy/features/user/data/datasource/userDatasource.dart';
import 'package:cariro_implant_academy/features/user/data/repositories/userRepository.dart';
import 'package:cariro_implant_academy/features/user/domain/repositories/userRepository.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/changeRoleUseCase.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/getCandidateDetailsUseCase.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/getUserDataUseCase.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/getUsersSessions.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/refreshCandidateDataUseCase.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/removeUserUseCase.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/resetPasswordUseCase.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/searchUsersByRoleUseCase.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/searchUsersByWorkPlaceUseCase.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/updateUserInfoUseCase.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc.dart';
import 'package:cariro_implant_academy/core/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:cariro_implant_academy/presentation/bloc/imagesBloc.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalPagesStatesChangesBloc.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalPagesStatesChangesBloc_States.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/cashflow/data/repositories/cashFlowRepoImpl.dart';
import '../features/cashflow/domain/useCases/getExpensesByCategoryUseCase.dart';
import '../features/labRequest/data/repositories/labCustomersRepo.dart';
import '../features/labRequest/domain/usecases/addOrUpdateRequestReceiptUseCase.dart';
import '../features/labRequest/domain/usecases/assignTaskToTechnicianUseCase.dart';
import '../features/labRequest/domain/usecases/checkLabRequestsUseCase.dart';
import '../features/labRequest/domain/usecases/consumeLabItemUseCase.dart';
import '../features/labRequest/domain/usecases/createLabRequestUseCase.dart';
import '../features/labRequest/domain/usecases/createNewLabCustomerUseCase.dart';
import '../features/labRequest/domain/usecases/finishTaskUseCase.dart';
import '../features/labRequest/domain/usecases/getDefaultStepByNameUseCase.dart';
import '../features/labRequest/domain/usecases/getLabItemDetailsUseCase.dart';
import '../features/labRequest/domain/usecases/getPatientRequestsUseCase.dart';
import '../features/labRequest/domain/usecases/getRequestReceiptUseCase.dart';
import '../features/labRequest/domain/usecases/getRequestUseCase.dart';
import '../features/labRequest/domain/usecases/markRequestAsDoneUseCase.dart';
import '../features/labRequest/domain/usecases/payForRequestUseCase.dart';
import '../features/labRequest/domain/usecases/searchLabPatientsByTypeUseCase.dart';
import '../features/labRequest/domain/usecases/updateLabRequestUseCase.dart';
import '../features/patient/data/datasources/addOrRemoveMyPatientsDataSource.dart';
import '../features/patient/data/datasources/patientSearchDataSource.dart';
import '../features/patient/data/repositories/addOrRemoveMyPatientsRepoImpl.dart';
import '../features/patient/data/repositories/patientInfoRepoImpl.dart';
import '../features/patient/domain/repositories/addOrRemoveMyPatientsRangeRepo.dart';
import '../features/patient/domain/repositories/patientInfoRepo.dart';
import '../features/patient/domain/usecases/addRangeToMyPatientsUseCase.dart';
import '../features/patient/domain/usecases/getMySchedulesUseCase.dart';
import '../features/patient/domain/usecases/getNextAvailableIdUseCase.dart';
import '../features/patient/domain/usecases/inqueueComplaiUseCase.dart';
import '../features/patient/domain/usecases/patientSearchUseCase.dart';
import '../features/patient/domain/usecases/setPatientOutUseCase.dart';
import '../features/patient/presentation/bloc/addOrRemoveMyPatientsBloc.dart';
import '../features/patient/presentation/bloc/createOrViewPatientBloc.dart';
import '../features/patient/presentation/bloc/patientSearchBloc.dart';
import '../features/patientsMedical/complications/domain/useCases/getComplicationsAfterProsthesisUseCase.dart';
import '../features/patientsMedical/complications/domain/useCases/getComplicationsAfterSurgeryUseCase.dart';
import '../features/patientsMedical/complications/domain/useCases/udpateComplicationsAfterProsthesisUseCase.dart';
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
import '../features/stock/domain/usecases/getStockLogUseCase.dart';
import 'data/repositories/imageRepoImpl.dart';
import 'features/authentication/domain/usecases/resetPasswordForUserUseCase.dart';
import 'features/notification/domain/usecases/deleteNotificationsUseCase.dart';
import 'features/settings/domain/useCases/addExpensesCategoriesUseCase.dart';
import 'features/settings/domain/useCases/addImplantCompaniesUseCase.dart';
import 'features/settings/domain/useCases/addImplantLinesUseCase.dart';
import 'features/settings/domain/useCases/addImplantsUseCase.dart';
import 'features/settings/domain/useCases/addIncomeCategoriesUseCase.dart';
import 'features/settings/domain/useCases/addMembraneCompaniesUseCase.dart';
import 'features/settings/domain/useCases/addMembranesUseCase.dart';
import 'features/settings/domain/useCases/addPaymentMethodsUseCase.dart';
import 'features/settings/domain/useCases/addStockCategoriesUseCase.dart';
import 'features/settings/domain/useCases/addSuppliersUseCase.dart';
import 'features/settings/domain/useCases/addTacsCompaniesUseCase.dart';
import 'features/settings/domain/useCases/changeImplantCompanyNameUseCase.dart';
import 'features/settings/domain/useCases/changeImplantLineNameUseCase.dart';
import 'features/settings/domain/useCases/editRoomsUseCase.dart';
import 'features/settings/domain/useCases/editTreatmentPricesUseCase.dart';
import 'features/settings/domain/useCases/getExpensesCategoriesUseCase.dart';
import 'features/settings/domain/useCases/getImplantLinesUseCase.dart';
import 'features/settings/domain/useCases/getImplantSizesUseCase.dart';
import 'features/settings/domain/useCases/getLabItemsCompaniesUseCase.dart';
import 'features/settings/domain/useCases/getLabItemsLinesUseCase.dart';
import 'features/settings/domain/useCases/getLabItemsUseCase.dart';
import 'features/settings/domain/useCases/getNonMedicalStockCategories.dart';
import 'features/settings/domain/useCases/updateLabItemParentsUseCase.dart';
import 'features/settings/presentation/bloc/settingsBloc.dart';

final sl = GetIt.instance;

initInjection() async {
  print("initalizng injection");
  /*
  * SiteController
  * */

  sl.registerLazySingleton(() => SiteController());

  /**
   * Dialog Helper
   */
  sl.registerLazySingleton(() => DialogHelper());

  /**
   * SignalR
   */

  sl.registerLazySingleton(() => SignalR(bloc: sl()));
  //Shared preferences
  sl.registerSingletonAsync<SharedPreferences>(() => SharedPreferences.getInstance());
  await sl.isReady<SharedPreferences>(); // Add this line

  /**
   * Core
   */
  //bloc
  sl.registerFactory(() => DropDownSearchBloc(DropDownBlocStates()));
  sl.registerLazySingleton(() => RoutingBloc());
  //usecase
  sl.registerLazySingleton(() => LoadUsersUseCase(loadingRepo: sl()));
  sl.registerLazySingleton(() => LoadCandidateBatchesUseCase(loadingRepo: sl()));
  sl.registerLazySingleton(() => LoadCandidatesByBatchId(loadingRepo: sl()));
  sl.registerLazySingleton(() => LoadWorkPlacesCase(loadingRepo: sl()));
  //sl.registerLazySingleton(() => LoadCandidateBatchesUseCase(loadingRepo: sl()));
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
  //bloc
  sl.registerFactory(() => SettingsBloc(
        updateDefaultSurgicalComplicationsUseCase: sl(),
        getDefaultSurgicalComplicationsUseCase: sl(),
        getDefaultProstheticComplicationsUseCase: sl(),
        updateDefaultProstheticComplicationsUseCase: sl(),
        getProstheticItemsUseCase: sl(),
        getProstheticNextVisitUseCase: sl(),
        getProstheticMaterialUseCase: sl(),
        getProstheticTechniqueUseCase: sl(),
        getProstheticStatusUseCase: sl(),
        getImplantCompaniesUseCase: sl(),
        getImplantLinesUseCase: sl(),
        getImplantSizesUseCase: sl(),
        getTreatmentItemsUseCase: sl(),
        getTacsUseCase: sl(),
        getMembraneCompaniesUseCase: sl(),
        getMembranesUseCase: sl(),
        getIncomeCategoriesUseCase: sl(),
        getExpensesCategoriesUseCase: sl(),
        getPaymentMethodsUseCase: sl(),
        getMedicalExpensesCategoriesUseCase: sl(),
        getNonMedicalNonStockExpensesCategoriesUseCase: sl(),
        getNonMedicalStockCategoriesUseCase: sl(),
        getSuppliersUseCase: sl(),
        changeImplantCompanyNameUseCase: sl(),
        changeImplantLineNameUseCase: sl(),
        addImplantsUseCase: sl(),
        addImplantLinesUseCase: sl(),
        addImplantCompaniesUseCase: sl(),
        addMembranesUseCase: sl(),
        addTacsCompaniesUseCase: sl(),
        addMembraneCompaniesUseCase: sl(),
        addExpensesCategoriesUseCase: sl(),
        addIncomeCategoriesUseCase: sl(),
        addSuppliersUseCase: sl(),
        addStockCategoriesUseCase: sl(),
        addPaymentMethodsUseCase: sl(),
        editRoomsUseCase: sl(),
        editTreatmentPricesUseCase: sl(),
        getStockCategoriesUseCase: sl(),
        getRoomsUseCase: sl(),
        getTeethClinicPricesUseCase: sl(),
        updateTeethClinicPricesUseCase: sl(),
        getLabItemParentsUseCase: sl(),
        getLabItemsUseCase: sl(),
        getLabItemsLinesUseCase: sl(),
        getLabItemsCompaniesUseCase: sl(),
        updateLabItemsCompaniesUseCase: sl(),
        updateLabItemsShadesUseCase: sl(),
        updateLabItemsUseCase: sl(),
        updateLabItemsParentsUseCase: sl(),
        updateProstheticItemsUseCase: sl(),
        updateProstheticNextVisitUseCase: sl(),
        updateProstheticTechniqueUseCase: sl(),
        updateProstheticMaterialUseCase: sl(),
        updateProstheticStatusUseCase: sl(),
        getLabOptionsUseCase: sl(),
        updateLabOptionsUseCase: sl(),
        updateLabOptionsPriceListUseCase: sl(),
        getLabThresholdSettingsUseCase: sl(),
        updateLabThresholdSettingsUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => GetLabThresholdSettingsUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => UpdateLabThresholdSettingsUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => UpdateLabOptionsPriceListUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetDefaultSurgicalComplicationsUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetDefaultProstheticComplicationsUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => UpdateDefaultSurgicalComplicationsUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => UpdateDefaultProstheticComplicationsUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => UpdateProstheticItemsUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => UpdateProstheticNextVisitUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => UpdateProstheticTechniqueUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => UpdateProstheticMaterialUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => UpdateProstheticStatusUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetProstheticItemsUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetProstheticStatusUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetProstheticNextVisitUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetProstheticTechniqueUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetProstheticMaterialUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetLabItemParentsUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetTeethClinicPricesUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => UpdateTeethClinicPricesUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetImplantCompaniesUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetImplantLinesUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetImplantSizesUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => GetTacsUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetStockCategoriesUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => GetMembraneCompaniesUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => GetMembranesUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => GetIncomeCategoriesUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => GetExpensesCategoriesUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => GetPaymentMethodsUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => GetMedicalExpensesCategoriesUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => GetNonMedicalNonStockExpensesCategoriesUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => GetNonMedicalStockCategoriesUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => GetSuppliersUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => ChangeImplantCompanyNameUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => ChangeImplantLineNameUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => AddImplantsUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => AddImplantLinesUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => AddImplantCompaniesUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => AddMembranesUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => AddTacsCompaniesUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => AddMembraneCompaniesUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => AddExpensesCategoriesUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => AddIncomeCategoriesUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => AddSuppliersUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => AddStockCategoriesUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => AddPaymentMethodsUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => EditRoomsUseCase(settingsRepository: sl()));

  sl.registerLazySingleton(() => EditTreatmentPricesUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetLabItemsUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetLabOptionsUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetLabItemsLinesUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => GetLabItemsCompaniesUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => UpdateLabItemsCompaniesUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => UpdateLabItemsShadesUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => UpdateLabItemsUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => UpdateLabOptionsUseCase(settingsRepository: sl()));
  sl.registerLazySingleton(() => UpdateLabItemsParentsUseCase(settingsRepository: sl()));

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
        addReceiptUseCase: sl(),
        getReceiptByIdUseCase: sl(),
        getPaymentLogsForAReceipt: sl(),
        removePaymentUseCase: sl(),
        addPaymentUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => AddReceiptUseCase(receiptRepository: sl()));
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
        registerUserUseCase: sl(),
      ));
  //use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => CheckLoginStatusUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUserUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordForUserUseCase(sl()));
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
  sl.registerLazySingleton(() => AdvancedSearchBloc(
        advancedTreatmentSearchUseCase: sl(),
        advancedSearchPatientsUseCase: sl(),
        advancedProstheticSearchUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => AdvancedTreatmentSearchUseCase(patientInfoRepo: sl()));
  sl.registerLazySingleton(() => AdvancedSearchPatientsUseCase(patientInfoRepo: sl()));
  sl.registerLazySingleton(() => AdvancedProstheticSearchUseCase(patientInfoRepo: sl()));
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
        updatePatientDataUseCase: sl(),
        setPatientOutUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => CreatePatientUseCase(patientInfoRepo: sl(), imageRepo: sl()));
  sl.registerLazySingleton(() => CheckDuplicateNumberUseCase(patientRepo: sl(), inputValidationRepo: sl()));
  sl.registerLazySingleton(() => CheckDuplicateIdUseCase(sl()));
  sl.registerLazySingleton(() => GetNextAvailableIdUseCase(sl()));
  sl.registerLazySingleton(() => GetPatientDataUseCase(patientRepo: sl()));
  sl.registerLazySingleton(() => UpdatePatientDataUseCase(patientInfoRepo: sl()));
  sl.registerLazySingleton(() => SetPatientOutUseCase(patientRepo: sl()));
  //repos
  sl.registerLazySingleton<InputValidationRepo>(() => InputValidationRepoImpl());
  //dataSources

  /**
   * To Do List
   */

  // bloc
  sl.registerFactory(() => ToDoListBloc(
        getToDoListUseCase: sl(),
        searchToDoListUseCase: sl(),
        updateToDoListItemUseCase: sl(),
        addToDoListItemUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => SearchToDoListUseCase(sl()));
  sl.registerLazySingleton(() => AddToDoListItemUseCase(sl()));
  sl.registerLazySingleton(() => UpdateToDoListItemUseCase(sl()));
  sl.registerLazySingleton(() => GetToDoListUseCase(sl()));

  //repo
  sl.registerLazySingleton<ToDoListRepo>(() => ToDoListRepoImpl(toDoListDatasource: sl()));

  //datasource
  sl.registerLazySingleton<ToDoListDatasource>(() => ToDoListDatasourceImpl(httpRepo: sl()));

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
      updateVisitUseCase: sl()));
  //usecases
  sl.registerLazySingleton(() => GetVisitsUseCase(visitsRepo: sl()));
  sl.registerLazySingleton(() => PatientLeavesClinicUseCase(visitsRepo: sl()));
  sl.registerLazySingleton(() => PatientEntersClinicUseCase(visitsRepo: sl()));
  sl.registerLazySingleton(() => PatientVisitsUseCase(visitsRepo: sl()));
  sl.registerLazySingleton(() => UpdateVisitUseCase(visitsRepo: sl()));
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
   * Complains
   */
  sl.registerFactory(() => ComplainsBloc(
        getComplainsUseCase: sl(),
        updateComplainNotesUseCase: sl(),
        inqueueComplainUseCase: sl(),
        resolveComplainUseCase: sl(),
        addComplainUseCase: sl(),
        getPatientDataUseCase: sl(),
        getAllNonSurgicalTreatmentsUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => GetComplainsUseCase(sl()));
  sl.registerLazySingleton(() => UpdateComplainNotesUseCase(sl()));
  sl.registerLazySingleton(() => InqueueComplainUseCase(sl()));
  sl.registerLazySingleton(() => ResolveComplainUseCase(sl()));
  sl.registerLazySingleton(() => AddComplainUseCase(sl()));
  //respo
  sl.registerLazySingleton<ComplainsRepository>(() => ComplainsRepositoryImpl(complainsDatasource: sl()));
  //datasource
  sl.registerLazySingleton<ComplainsDatasource>(() => ComplainDatasourceImpl(httpRepo: sl()));
  /**
   * AppBar
   */
  //bloc

  sl.registerLazySingleton(() => AppBarBloc(
        getNotificationsUseCase: sl(),
        markAllNotificationsAsReadUseCase: sl(),
        deleteNotificationsUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => GetNotificationsUseCase(notificationRepo: sl()));
  sl.registerLazySingleton(() => MarkAllNotificationsAsReadUseCase(notificationRepo: sl()));
  sl.registerLazySingleton(() => DeleteNotificationsUseCase(notificationRepo: sl()));
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
        getTreatmentItemsUseCase: sl(),
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
        saveTreatmentDetailsUseCase: sl(),
        getTreatmentPlanUseCase: sl(),
        consumeImplantUseCase: sl(),
        consumeItemByIdUseCase: sl(),
        consumeItemByNameUseCase: sl(),
        getPostSurgicalTreatmentUseCase: sl(),
        saveTreatmentPlanUseCase: sl(),
        getTacsUseCase: sl(),
        acceptChangesUseCase: sl(),
        getTreatmentDetailsUseCase: sl(),
        savePostSurgeryDataUseCase: sl(),
        getTreatmentItemsUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => SaveTreatmentDetailsUseCase(treatmentPlanRepo: sl()));
  sl.registerLazySingleton(() => SaveTreatmentPlanUseCase(treatmentPlanRepo: sl()));
  sl.registerLazySingleton(() => GetTreatmentPlanUseCase(treatmentPlanRepo: sl()));
  sl.registerLazySingleton(() => GetTreatmentDetailsUseCase(treatmentPlanRepo: sl()));
  sl.registerLazySingleton(() => ConsumeImplantUseCase(treatmentPlanRepo: sl()));
  sl.registerLazySingleton(() => GetPostSurgicalTreatmentUseCase(surgicalTreatmentRepo: sl()));
  sl.registerLazySingleton(() => AcceptChangesUseCase(surgicalTreatmentRepo: sl()));
  sl.registerLazySingleton(() => SavePostSurgeryDataUseCase(postSurgeryRepo: sl()));
  sl.registerLazySingleton(() => GetTreatmentItemsUseCase(treatmentPlanRepo: sl()));

  //repositories
  sl.registerLazySingleton<TreatmentPlanRepo>(() => TreatmentPlanRepoImplementation(treatmentPlanDataSource: sl()));
  sl.registerLazySingleton<PostSurgicalTreatmentRepo>(() => PostSurgicalTreatmentRepoImpl(postSurgicalTreatmentDatasource: sl()));
  //datasources
  sl.registerLazySingleton<TreatmentPlanDataSource>(() => TreatmentPlanDatasourceImpl(httpRepo: sl()));
  sl.registerLazySingleton<PostSurgicalTreatmentDatasource>(() => SurgicalTreatmentDatasourceImpl(httpRepo: sl()));

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

  /**
   * Users
   */
  //bloc
  sl.registerFactory(() => UsersBloc(
        updateUserInfoUseCase: sl(),
        searchUsersByRoleUseCase: sl(),
        getUserInfoUseCase: sl(),
        resetPasswordUseCase: sl(),
        getUsersSessionsUseCase: sl(),
        resetPasswordForUserUseCase: sl(),
        changeRoleUseCase: sl(),
        searchUsersByWorkPlaceUseCase: sl(),
        getCandidateDetailsUseCase: sl(),
        refreshCandidatesDataUseCase: sl(),
        removeUserUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => UpdateUserInfoUseCase(usersRepository: sl()));
  sl.registerLazySingleton(() => SearchUsersByRoleUseCase(usersRepository: sl()));
  sl.registerLazySingleton(() => GetUserDataUseCase(usersRepository: sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(usersRepository: sl()));
  sl.registerLazySingleton(() => GetUsersSessionsUseCase(usersRepository: sl()));
  sl.registerLazySingleton(() => ChangeRoleUseCase(usersRepository: sl()));
  sl.registerLazySingleton(() => RefreshCandidatesDataUseCase(usersRepository: sl()));
  sl.registerLazySingleton(() => SearchUsersByWorkPlaceUseCase(usersRepository: sl()));
  sl.registerLazySingleton(() => GetCandidateDetailsUseCase(usersRepository: sl()));
  sl.registerLazySingleton(() => RemoveUserUseCase(usersRepository: sl()));
  //repo
  sl.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(userDatasource: sl()));
  //DATASOURCE
  sl.registerLazySingleton<UserDatasource>(() => UserDatasourceImpl(httpRepo: sl()));

  /**
   * Stock
   */
  //bloc
  sl.registerFactory(() => StockBloc(
        getStockLogUseCase: sl(),
        getStockUseCase: sl(),
        getLabStockUseCase: sl(),
        consumeItemByIdUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => GetStockUseCase(stockRepository: sl()));
  sl.registerLazySingleton(() => GetLabStockUseCase(stockRepository: sl()));
  sl.registerLazySingleton(() => GetStockLogUseCase(stockRepository: sl()));
  sl.registerLazySingleton(() => GetStockByNameUseCase(stockRepository: sl()));
  //repo
  sl.registerLazySingleton<StockRepository>(() => StockRepoImpl(stockDatasource: sl()));
  //datasource
  sl.registerLazySingleton<StockDatasource>(() => StockDatasourceImpl(httpRepo: sl()));

  /**
   * Cash Flow
   */
  //bloc
  sl.registerFactory(() => CashFlowBloc(
        listIncomeUseCase: sl(),
        listExpensesUseCase: sl(),
        getSummaryUseCase: sl(),
        getIncomeByCategoryUseCase: sl(),
        getExpensesByCategoryUseCase: sl(),
        addSettlementUseCase: sl(),
        addExpensesUseCase: sl(),
        addIncomeUseCase: sl(),
        createInstallmentPlanUseCase: sl(),
        getInstallmentPlanForUserUseCase: sl(),
        payInstallmentUseCase: sl(),
      ));

  //use cases
  sl.registerLazySingleton(() => CreateInstallmentPlanUseCase(cashFlowRepository: sl()));
  sl.registerLazySingleton(() => GetInstallmentPlanForUserUseCase(cashFlowRepository: sl()));
  sl.registerLazySingleton(() => PayInstallmentUseCase(cashFlowRepository: sl()));
  sl.registerLazySingleton(() => ListIncomeUseCase(cashFlowRepository: sl()));
  sl.registerLazySingleton(() => ListExpensesUseCase(cashFlowRepository: sl()));
  sl.registerLazySingleton(() => GetSummaryUseCase(cashFlowRepository: sl()));
  sl.registerLazySingleton(() => GetIncomeByCategoryUseCase(cashFlowRepository: sl()));
  sl.registerLazySingleton(() => GetExpensesByCategoryUseCase(cashFlowRepository: sl()));
  sl.registerLazySingleton(() => AddSettlementUseCase(cashFlowRepository: sl()));
  sl.registerLazySingleton(() => AddExpensesUseCase(cashFlowRepository: sl()));
  sl.registerLazySingleton(() => AddIncomeUseCase(cashFlowRepository: sl()));
  //repos
  sl.registerLazySingleton<CashFlowRepository>(() => CashFlowRepoImpl(cashFlowDatasource: sl()));
  //datasources
  sl.registerLazySingleton<CashFlowDatasource>(() => CashFlowDataSourceImpl(httpRepo: sl()));

  /*
  * Complications
  * */

  //blocs
  sl.registerFactory(() => ComplicationsBloc(
        updateComplicationsAfterSurgeryUseCase: sl(),
        updateComplicationsAfterProsthesisUseCase: sl(),
        getComplicationsAfterSurgeryUseCase: sl(),
        getComplicationsAfterProsthesisUseCase: sl(),
        getSurgeryTeethForComplicationsUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => UpdateComplicationsAfterSurgeryUseCase(complicationsRepo: sl()));
  sl.registerLazySingleton(() => UpdateComplicationsAfterProsthesisUseCase(complicationsRepo: sl()));
  sl.registerLazySingleton(() => GetComplicationsAfterSurgeryUseCase(complicationsRepo: sl()));
  sl.registerLazySingleton(() => GetComplicationsAfterProsthesisUseCase(complicationsRepo: sl()));
  sl.registerLazySingleton(() => GetSurgeryTeethForComplicationsUseCase(complicationsRepo: sl()));

  //REPOS
  sl.registerLazySingleton<ComplicationsRepo>(() => ComplicationsRepoImpl(complicationsDatasource: sl()));
  //datasources
  sl.registerLazySingleton<ComplicationsDatasource>(() => ComplicationsDatasourceImpl(httpRepo: sl()));
  /**
   * Lab Requests
   */

  //blocs
  sl.registerLazySingleton(() => LabRequestsBloc(
        getAllLabRequestsUseCase: sl(),
        createNewLabCustomerUseCase: sl(),
        searchLabPatientsByTypeUseCase: sl(),
        createLabRequestUseCase: sl(),
        getDefaultStepByNameUseCase: sl(),
        getPatientLabRequestsUseCase: sl(),
        finishTaskUseCase: sl(),
        getLabRequestUseCase: sl(),
        assignTaskToTechnicianUseCase: sl(),
        markRequestAsDoneUseCase: sl(),
        updateLabRequestUseCase: sl(),
        consumeLabItemUseCase: sl(),
        getLabItemDetailsUseCase: sl(),
        getRequestReceiptUseCase: sl(),
        payRequestUseCase: sl(),
        getLabItemStepsFroRequestUseCase: sl(),
      ));
  //useCases
  sl.registerLazySingleton(() => GetAllLabRequestsUseCase(labRequestRepository: sl()));
  sl.registerLazySingleton(() => GetDefaultStepsUseCase(labRequestRepository: sl()));
  sl.registerLazySingleton(() => CreateLabRequestUseCase(labRequestRepository: sl()));
  sl.registerLazySingleton(() => GetDefaultStepByNameUseCase(labRequestRepository: sl()));
  sl.registerLazySingleton(() => GetPatientLabRequestsUseCase(labRequestRepository: sl()));
  sl.registerLazySingleton(() => AssignTaskToTechnicianUseCase(labRequestRepository: sl()));
  sl.registerLazySingleton(() => MarkRequestAsDoneUseCase(labRequestRepository: sl()));
  sl.registerLazySingleton(() => GetLabRequestUseCase(labRequestRepository: sl()));
  sl.registerLazySingleton(() => FinishTaskUseCase(labRequestRepository: sl()));
  sl.registerLazySingleton(() => CheckLabRequestsUseCase(labRequestRepository: sl()));
  sl.registerLazySingleton(() => CreateNewLabCustomerUseCase(labCustomersRepository: sl()));
  sl.registerLazySingleton(() => SearchLabPatientsByTypeUseCase(labCustomersRepository: sl()));
  sl.registerLazySingleton(() => UpdateLabRequestUseCase(labRequestRepository: sl()));
  sl.registerLazySingleton(() => ConsumeLabItemUseCase(labRequestRepository: sl()));
  sl.registerLazySingleton(() => GetLabItemDetailsUseCase(labRequestRepository: sl()));
  sl.registerLazySingleton(() => GetRequestReceiptUseCase(labRequestRepository: sl()));
  sl.registerLazySingleton(() => PayRequestUseCase(labRequestRepository: sl()));
  sl.registerLazySingleton(() => GetLabItemStepsFroRequestUseCase(labRequestRepo: sl()));
  //repo
  sl.registerLazySingleton<LabRequestRepository>(() => LabRequestRepoImpl(labRequestDatasource: sl()));
  sl.registerLazySingleton<LabCustomersRepository>(() => LabCustomerRepoImpl(labCustomerDatasource: sl()));
  //datasource
  sl.registerLazySingleton<LabRequestDatasource>(() => LabRequestsDatasourceImpl(httpRepo: sl()));
  sl.registerLazySingleton<LabCustomerDatasource>(() => LabCustomerDataSourceImpl(httpRepo: sl()));

  /**
   * Clinic Treatments
   */
  //bloc
  sl.registerFactory(() => ClinicTreatmentBloc(
        updateClinicTreatmentsUseCase: sl(),
        getClinicTreatmentsUseCase: sl(),
        getTeethClinicPricesUseCase: sl(),
        getDoctorPercentageForPatientUseCase: sl(),
        updateClinicReceiptUseCase: sl(),
      ));
  //usecases
  sl.registerLazySingleton(() => GetClinicTreatmentsUseCase(clinicTreatmentRepo: sl()));
  sl.registerLazySingleton(() => UpdateClinicTreatmentsUseCase(clinicTreatmentRepo: sl()));
  sl.registerLazySingleton(() => GetDoctorPercentageForPatientUseCase(clinicTreatmentRepo: sl()));
  sl.registerLazySingleton(() => UpdateClinicReceiptUseCase(clinicTreatmentRepo: sl()));
  //repo
  sl.registerLazySingleton<ClinicTreatmentRepo>(() => ClinicTreatmentRepoImpl(clinicTreatmentDatasource: sl()));
  //datasource
  sl.registerLazySingleton<ClinicTreatmentDatasource>(() => ClinicTreatmentDataSourceImpl(httpRepo: sl()));
}
