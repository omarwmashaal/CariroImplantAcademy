import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/TabsLayout.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/usecases/addPaymentUsecase.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/CIA_GestureWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/usecases/getTreatmentPlanItemUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/usecases/updateNonSurgicalTreatmentNotesUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc_States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '';
import '../../../../../Widgets/CIA_PopUp.dart';
import '../../../../../Widgets/CIA_TextFormField.dart';
import '../../../../../core/features/coreReceipt/domain/usecases/addPatientReceiptUseCase.dart';
import '../../../dentalExamination/domain/useCases/getDentalExaminationUseCsae.dart';
import '../../../dentalExamination/domain/useCases/saveDentalExaminationUseCsae.dart';
import '../../domain/entities/nonSurgialTreatmentEntity.dart';
import '../../domain/usecases/checkNonSurgicalTreatementTeethStatusUseCase.dart';
import '../../domain/usecases/getAllNonSurgicalTreatmentsUseCase.dart';
import '../../domain/usecases/getNonSurgicalTreatmentUseCase.dart';
import '../../domain/usecases/saveNonSurgicalTreatmentUseCase.dart';

class NonSurgicalTreatmentBloc extends Bloc<NonSurgicalTreatmentBloc_Events, NonSurgicalTreatmentBloc_States> {
  final SaveNonSurgicalTreatmentUseCase saveNonSurgicalTreatmentUseCase;
  final GetAllNonSurgicalTreatmentsUseCase getAllNonSurgicalTreatmentsUseCase;
  final GetNonSurgicalTreatmentUseCase getNonSurgicalTreatmentUseCase;
  final CheckNonSurgicalTreatmentTeethStatusUseCase checkNonSurgicalTreatmentTeethStatusUseCase;
  final GetDentalExaminationUseCase getDentalExaminationUseCase;
  final SaveDentalExaminationUseCase saveDentalExaminationUseCase;
  final GetTreatmentPlanItemUsecase getTreatmentPlanItemUsecase;
  final AddPatientReceiptUseCase addPatientReceiptUseCase;
  final UpdateNonSurgicalTreatmentNotesUseCase updateNonSurgicalTreatmentNotesUseCase;
  bool isInitialized = false;

  NonSurgicalTreatmentBloc({
    required this.checkNonSurgicalTreatmentTeethStatusUseCase,
    required this.getNonSurgicalTreatmentUseCase,
    required this.getAllNonSurgicalTreatmentsUseCase,
    required this.saveNonSurgicalTreatmentUseCase,
    required this.getDentalExaminationUseCase,
    required this.saveDentalExaminationUseCase,
    required this.getTreatmentPlanItemUsecase,
    required this.updateNonSurgicalTreatmentNotesUseCase,
    required this.addPatientReceiptUseCase,
  }) : super(NonSurgicalTreatmentBlocInitialState()) {
    on<NonSurgicalTreatmentBloc_GetDataEvent>(
      (event, emit) async {
        String treatment = "";
        emit(NonSurgicalTreatmentBloc_LoadingData());
        final result = await getNonSurgicalTreatmentUseCase(event.id);
        result.fold(
          (l) => emit(NonSurgicalTreatmentBloc_DataLoadingError(message: l.message ?? "")),
          (r) {
            emit(NonSurgicalTreatmentBloc_DataLoadedSuccessfully(nonSurgicalTreatmentEntity: r));
            treatment = r.treatment ?? "";
          },
        );
        if (result.isRight()) {
          emit(NonSurgicalTreatmentBloc_DentalExaminationLoadingData());
          final result_ = await getDentalExaminationUseCase(event.id);
          result_.fold(
            (l) => emit(NonSurgicalTreatmentBloc_DentalExaminationDataLoadingError(message: l.message ?? "")),
            (r) => emit(NonSurgicalTreatmentBloc_DentalExaminationDataLoadedSuccessfully(dentalExaminationEntity: r)),
          );

          if (result_.isRight()) {
            emit(NonSurgicalTreatmentBloc_CheckingTeethStatus());
            final r_ = await checkNonSurgicalTreatmentTeethStatusUseCase(treatment == null || treatment == "" ? "nodata" : treatment!);
            r_.fold(
              (l) => emit(NonSurgicalTreatmentBloc_CheckingTeethStatusError(message: l.message ?? "")),
              (r) => emit(NonSurgicalTreatmentBloc_TeethStatusLoadedSuccessfully(status: r)),
            );
          }
        }
      },
    );
    on<NonSurgicalTreatmentBloc_CheckTeethStatusEvent>(
      (event, emit) async {
        emit(NonSurgicalTreatmentBloc_CheckingTeethStatus());
        final result = await checkNonSurgicalTreatmentTeethStatusUseCase(event.treatment == null || event.treatment == "" ? "nodata" : event.treatment);
        result.fold(
          (l) => emit(NonSurgicalTreatmentBloc_CheckingTeethStatusError(message: l.message ?? "")),
          (r) => emit(NonSurgicalTreatmentBloc_TeethStatusLoadedSuccessfully(status: r)),
        );
      },
    );
    on<NonSurgicalTreatmentBloc_GetAllDataEvent>(
      (event, emit) async {
        emit(NonSurgicalTreatmentBloc_LoadingAllData());
        final result = await getAllNonSurgicalTreatmentsUseCase(event.id);
        result.fold(
          (l) => emit(NonSurgicalTreatmentBloc_AllDataLoadingError(message: l.message ?? "")),
          (r) => emit(NonSurgicalTreatmentBloc_AllDataLoadedSuccessfully(nonSurgicalTreatments: r)),
        );
      },
    );
    on<NonSurgicalTreatmentBloc_UpdateNotesEvent>(
      (event, emit) async {
        emit(NonSurgicalTreatmentBloc_UpdatingNotesStates());
        final result = await updateNonSurgicalTreatmentNotesUseCase(event.params);
        result.fold(
          (l) => emit(NonSurgicalTreatmentBloc_UpdatingNotesErrorStates(message: l.message ?? "")),
          (r) => emit(NonSurgicalTreatmentBloc_UpdatedNotesSuccessfullyState()),
        );
      },
    );
    on<NonSurgicalTreatmentBloc_SaveDataEvent>(
      (event, emit) async {
        emit(NonSurgicalTreatmentBloc_SavingData());
        final result = await saveNonSurgicalTreatmentUseCase(SaveNonSurgicalTreatmentParams(
          patientId: event.patientId,
          nonSurgicalTreatmentEntity: event.nonSurgicalTreatmentEntity,
        ));
        result.fold(
          (l) => emit(NonSurgicalTreatmentBloc_DataSavingError(message: l.message ?? "")),
          (r) async {
            // emit(NonSurgicalTreatmentBloc_DataSavedSuccessfully());

            await saveDentalExaminationUseCase(event.dentalExaminationEntity).then((value) {
              value.fold((l) => emit(NonSurgicalTreatmentBloc_DataSavingError(message: l.message ?? "")),
                  (r) => emit(NonSurgicalTreatmentBloc_DataSavedSuccessfully()));
            });
          },
        );
      },
    );
    on<NonSurgicalTreatmentBloc_GetPaidTreatmentPlanItemEvent>(
      (event, emit) async {
        emit(NonSurgicalTreatmentBloc_LoadingTreatmentPlanItem());
        final result = await getTreatmentPlanItemUsecase(GetTreatmentPlanItemParams(
          patientId: event.patientId,
          tooth: event.tooth,
        ));

        result.fold(
          (l) => emit(NonSurgicalTreatmentBloc_LoadingTreatmentPlanItemError(message: l.message ?? "")),
          (r) => emit(NonSurgicalTreatmentBloc_LoadedTreatmentPlanItemSuccessfully(
            data: r,
            action: event.action,
            tooth: event.tooth,
          )),
        );
      },
    );
    on<NonSurgicalTreatmentBloc_AddPatientReceiptEvent>(
      (event, emit) async {
        emit(NonSurgicalTreatmentBloc_AddingPatientReceipt());
        final result = await addPatientReceiptUseCase(AddPatientReceiptParams(
          patientId: event.patientId,
          tooth: event.tooth,
          action: event.action,
          price: event.price,
        ));

        result.fold(
          (l) => emit(NonSurgicalTreatmentBloc_AddingPatientReceiptError(message: l.message ?? "")),
          (r) => emit(NonSurgicalTreatmentBloc_AddedPatientReceiptSuccessfully()),
        );
      },
    );
  }
}

class NonSurgicalTreatmentDataGridSource extends DataGridSource {
  List<NonSurgicalTreatmentEntity> models = [];

  NonSurgicalTreatmentBloc bloc;
  BuildContext context;

  NonSurgicalTreatmentDataGridSource({required this.context, required this.bloc}) {
    init();
  }

  init() {
    _nonSurgicalTreatmentData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<DateTime>(columnName: 'Date', value: e.date),
              DataGridCell<String>(columnName: 'Operator', value: e.operator?.name!),
              DataGridCell<String>(columnName: 'Supervisor', value: e.supervisor?.name!),
              DataGridCell<DateTime>(columnName: 'Next Visit', value: e.nextVisit),
              DataGridCell<Widget>(
                  columnName: 'Treatment',
                  value: CIA_GestureWidget(
                    onTap: () => (!siteController.getRole()!.contains("admin"))
                        ? null
                        : CIA_ShowPopUp(
                            context: context,
                            width: 700,
                            onSave: () {
                              bloc.add(NonSurgicalTreatmentBloc_UpdateNotesEvent(
                                  params: UpdateNonSurgicalTreatmentNotesParams(notes: e.treatment!, nonSurgicalTreatmentId: e.id!)));
                            },
                            child: CIA_TextFormField(
                              textInputType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              onChange: (value) {
                                e.treatment = value;
                              },
                              label: "Treatment",
                              controller: TextEditingController(text: e.treatment),
                              maxLines: 10,
                            ),
                          ),
                    child: Text(e.treatment ?? ""),
                  ))
            ]))
        .toList();
  }

  List<DataGridRow> _nonSurgicalTreatmentData = [];

  @override
  List<DataGridRow> get rows => _nonSurgicalTreatmentData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        child: e.value is Widget ? e.value : Text(e.value is DateTime ? DateFormat("dd-MM-yyyy hh:mm a").format(e.value) : e.value.toString()),
      );
    }).toList());
  }

  updateData(List<NonSurgicalTreatmentEntity> newData) {
    models = newData;
    init();
    notifyListeners();
  }
}
