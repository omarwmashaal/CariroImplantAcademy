import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/ReceiptModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/data/models/receiptModel.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/toothReceiptEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/blocs/receiptBloc.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/blocs/receiptBloc_States.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/widgets/paymentLogTableWidget.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/widgets/paymentWidget.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/widgets/receiptTableWidget.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc_Events.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc_States.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/roomEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getRoomsUsecase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getVisitsUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/patientEntersClinicUseCase.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/calendarBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/calendarBloc_States.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientVisitsBloc_Events.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientVisitsBloc_States.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../Helpers/Router.dart';
import '../../../../Widgets/CIA_PopUp.dart';
import '../../../../Widgets/CIA_PrimaryButton.dart';
import '../../../../Widgets/CIA_SecondaryButton.dart';
import '../../../../Widgets/FormTextWidget.dart';
import '../../../../Widgets/Title.dart';
import '../../../../core/injection_contianer.dart';
import '../bloc/calendarBloc_Events.dart';
import '../bloc/patientVisitsBloc.dart';
import '../pages/createOrViewPatientPage.dart';
import 'calendarWidget.dart';
import 'package:collection/collection.dart';

class VisitsTableWidget extends StatelessWidget {
  VisitsTableWidget({
    Key? key,
    this.patientId,
  }) : super(key: key);
  int? patientId;
  late PatientVisitsBloc bloc;
  late ReceiptBloc receiptBloc;
  late Function(int) showReceipts;

  String? search;

  @override
  Widget build(BuildContext context) {
    showReceipts = (int receiptId) {
      PaymentLogTableWidget(
        context: context,
        receiptId: receiptId,
        patientId: patientId,
      )();
    };
    receiptBloc = BlocProvider.of<ReceiptBloc>(context);
    bloc = BlocProvider.of<PatientVisitsBloc>(context);
    bloc.add(PatientVisitsBloc_GetVisitsEvent(params: GetVisitsParams(patientId: patientId)));
    VisitDataSource dataSource = VisitDataSource(context: context, bloc: bloc);
    return Container(
      height: 200,
      child: Column(
        children: [
          TitleWidget(
            title: "Visits",
            showBackButton: true,
          ),
          Visibility(
              visible: patientId != null,
              child: BlocBuilder<PatientVisitsBloc, PatientVisitsBloc_States>(
                buildWhen: (previous, current) => current is PatientVisitsBloc_LoadedPatientDataSuccessfullyState,
                builder: (context, state) {
                  PatientInfoEntity? patientData;
                  if (state is PatientVisitsBloc_LoadedPatientDataSuccessfullyState) {
                    patientData = state.data;
                  }
                  if (state is PatientVisitsBloc_LoadedPatientDataSuccessfullyState) {
                    DateTime? nextVisit;

                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  FormTextKeyWidget(text: "ID: "),
                                  SizedBox(width: 10),
                                  FormTextValueWidget(text: patientId.toString()),
                                  SizedBox(width: 30),
                                  FormTextKeyWidget(text: "Name: "),
                                  SizedBox(width: 10),
                                  FormTextValueWidget(text: patientData?.name ?? ""),
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Center(
                                  child: FormTextKeyWidget(
                                    text: "Patient Visit Procedures",
                                  ),
                                )),
                            Expanded(child: SizedBox()),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  FormTextKeyWidget(text: "Next Visit: "),
                                  SizedBox(width: 10),
                                  FormTextValueWidget(text: nextVisit == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(nextVisit!)),
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CIA_SecondaryButton(
                                      width: 150,
                                      label: "Patient Arrive",
                                      onTab: () => bloc.add(PatientVisitsBloc_PatientVisitsEvent(id: patientId!)),
                                    ),
                                    CIA_SecondaryButton(
                                      width: 180,
                                      label: "Patient Enters Clinic",
                                      onTab: () {
                                        int? doctorId = patientData?.doctorId;
                                        int? roomId;
                                        CIA_ShowPopUp(
                                          height: 200,
                                          context: context,
                                          onSave: () {
                                            if (doctorId == null) {
                                              ShowSnackBar(context, isSuccess: false, message: "Please Choose Doctor");
                                              return false;
                                            }
                                            if (patientId != null) {
                                              bloc.add(PatientVisitsBloc_PatientEntersClinicEvent(
                                                params: PatientEntersClinicParams(
                                                  patientId: patientId!,
                                                  doctorId: doctorId!,
                                                  roomId: roomId!,
                                                ),
                                              ));
                                            }
                                          },
                                          child: Column(
                                            children: [
                                              Flexible(
                                                child: CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                                                  onClear: () {
                                                    doctorId = null;
                                                  },
                                                  label: "Doctor",
                                                  asyncUseCase: sl<LoadUsersUseCase>(),
                                                  searchParams: LoadUsersEnum.instructorsAndAssistants,
                                                  selectedItem: patientData?.doctorId == null
                                                      ? null
                                                      : BasicNameIdObjectEntity(id: patientData!.doctorId!, name: patientData.doctor),
                                                  onSelect: (value) {
                                                    doctorId = value.id;
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Builder(builder: (context) {
                                                var b = BlocProvider.of<CalendarBloc>(context);
                                                b.add(CalendarBloc_GetRooms());
                                                return BlocBuilder<CalendarBloc, CalendarBloc_States>(
                                                    buildWhen: (previous, current) => current is CalendarBloc_LoadedRoomsSuccessfully,
                                                    builder: (context, state) {
                                                      List<BasicNameIdObjectEntity> rooms = [];
                                                      if (state is CalendarBloc_LoadedRoomsSuccessfully)
                                                        rooms = state.rooms.map((e) => BasicNameIdObjectEntity(name: e.name, id: e.id)).toList();
                                                      return Flexible(
                                                        child: CIA_DropDownSearchBasicIdName(
                                                          onClear: () {
                                                            roomId = null;
                                                          },
                                                          label: "Room",
                                                          items: rooms,
                                                          onSelect: (value) {
                                                            roomId = value.id;
                                                          },
                                                        ),
                                                      );
                                                    });
                                              }),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    CIA_SecondaryButton(
                                        width: 150,
                                        label: "Patient Leaves",
                                        onTab: () async {
                                          bloc.add(PatientVisitsBloc_PatientLeavesClinicEvent(id: patientId!));
                                        }),
                                    CIA_SecondaryButton(
                                        width: 150,
                                        label: "Add Manual Receipt",
                                        icon: Icon(Icons.attach_money_outlined),
                                        onTab: () async {
                                          SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
                                          settingsBloc.add(SettingsBloc_LoadTreatmentPricesEvent());
                                          List<TreatmentItemEntity> treatments = [];
                                          List<ToothReceiptEntity> receiptData = [];
                                          CIA_ShowPopUp(
                                              title: "Add New Receipt to ${patientData?.name ?? ""}",
                                              width: double.maxFinite,
                                              height: 500,
                                              context: context,
                                              onSave: () {
                                                receiptBloc.addReceipt(
                                                  ReceiptEntity(
                                                    date: DateTime.now(),
                                                    isPaid: false,
                                                    operatorId: siteController.getUserId(),
                                                    paid: 0,
                                                    patientId: patientId,
                                                    toothReceiptData: receiptData,
                                                    total: (receiptData.map((e) => (e.price ?? 0) as int).toList()).fold(0, (a, b) => (a ?? 0) + b),
                                                    unpaid: (receiptData.map((e) => (e.price ?? 0) as int).toList()).fold(0, (a, b) => (a ?? 0) + b),
                                                  ),
                                                );
                                                return false;
                                              },
                                              child: StatefulBuilder(builder: (context, setState) {
                                                return BlocListener<ReceiptBloc, ReceiptBloc_States>(
                                                  listener: (context, state) {
                                                    if (state is ReceiptBloc_AddingReceiptsState)
                                                      CustomLoader.show(context);
                                                    else {
                                                      CustomLoader.hide();
                                                      if (state is ReceiptBloc_AddingReceiptsErrorState)
                                                        ShowSnackBar(context, isSuccess: false, message: state.message);

                                                      if (state is ReceiptBloc_AddedReceiptsSuccessfullyState) {
                                                        ShowSnackBar(context, isSuccess: true);
                                                        dialogHelper.dismissSingle(context);
                                                        showReceipts(state.data.id!);
                                                      }
                                                    }
                                                  },
                                                  child: Column(
                                                    children: [
                                                      BlocBuilder<SettingsBloc, SettingsBloc_States>(
                                                        buildWhen: (previous, current) =>
                                                            current is SettingsBloc_LoadingTreatmentPricesState ||
                                                            current is SettingsBloc_LoadingTreatmentPricesErrorState ||
                                                            current is SettingsBloc_LoadedTreatmentPricesSuccessfullyState,
                                                        builder: (context, state) {
                                                          if (state is SettingsBloc_LoadingTreatmentPricesState)
                                                            return LoadingWidget();
                                                          else if (state is SettingsBloc_LoadingTreatmentPricesErrorState)
                                                            return FormTextKeyWidget(
                                                              text: "Error Loading Items",
                                                              color: Colors.red,
                                                            );
                                                          else if (state is SettingsBloc_LoadedTreatmentPricesSuccessfullyState) {
                                                            treatments = state.data;
                                                            treatments = [
                                                              ...treatments,
                                                              TreatmentItemEntity(
                                                                name: "Others",
                                                                price: 0,
                                                              )
                                                            ];
                                                          }
                                                          return Wrap(
                                                            children: treatments
                                                                .map((e) => Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: CIA_SecondaryButton(
                                                                        width: 200,
                                                                        icon: Icon(Icons.add),
                                                                        label: e.name ?? "",
                                                                        onTab: () {
                                                                          receiptData.add(ToothReceiptEntity(
                                                                            name: e.name,
                                                                            price: e.price,
                                                                          ));
                                                                          setState(() => null);
                                                                        },
                                                                      ),
                                                                    ))
                                                                .toList(),
                                                          );
                                                        },
                                                      ),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                        child: ListView(
                                                          children: receiptData
                                                              .mapIndexed((i, e) => Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        FormTextValueWidget(text: "${i + 1}. "),
                                                                        SizedBox(width: 10),
                                                                        e.name == "Others"
                                                                            ? Expanded(
                                                                                child: CIA_TextFormField(
                                                                                  label: "Name",
                                                                                  controller: TextEditingController(text: (e.name) ?? ""),
                                                                                  onChange: (value) => e.name = value,
                                                                                ),
                                                                              )
                                                                            : Expanded(child: FormTextKeyWidget(text: e.name ?? "")),
                                                                        SizedBox(width: 10),
                                                                        Expanded(
                                                                          child: CIA_TextFormField(
                                                                            label: "Tooth",
                                                                            controller: TextEditingController(text: (e.tooth ?? 0).toString()),
                                                                            isNumber: true,
                                                                            onChange: (value) => e.tooth = int.tryParse(value) ?? 0,
                                                                          ),
                                                                        ),
                                                                        SizedBox(width: 10),
                                                                        Expanded(
                                                                          child: CIA_TextFormField(
                                                                            label: "Prce",
                                                                            suffix: "EGP",
                                                                            controller: TextEditingController(text: (e.price ?? 0).toString()),
                                                                            isNumber: true,
                                                                            onChange: (value) => e.price = int.tryParse(value) ?? 0,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ))
                                                              .toList(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }));
                                        }),
                                  ],
                                )),
                            Expanded(
                                child: Row(
                              children: [
                                Expanded(child: SizedBox()),
                                CIA_PrimaryButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  width: 200,
                                  label: "Schedule new visit",
                                  onTab: () {
                                    CIA_ShowPopUp(
                                        context: context,
                                        width: double.maxFinite,
                                        height: 600,
                                        title: "Schedule Next Visit",
                                        child: CalendarWidget(
                                          // dataSource: dataSource,
                                          getForDoctor: false,
                                          getAllSchedules: true,
                                          patientID: patientId,
                                          doctorId: patientData?.doctorId,
                                          onNewVisit: (newVisit) {
                                            //    nonSurgicalTreatment.nextVisit = newVisit.reservationTime;
                                            //   bloc.add(NonSurgicalTreatmentBloc_SaveDataEvent(
                                            //      nonSurgicalTreatmentEntity: nonSurgicalTreatment,
                                            //    dentalExaminationEntity: dentalExaminationEntity,
                                            //     patientId: widget.patientId,
                                            //     ));
                                          },
                                        ),
                                        onSave: () {
                                          //   bloc.add(NonSurgicalTreatmentBloc_GetDataEvent(id: widget.patientId));
                                        });
                                    //  CIA_PopupDialog_DateTimePicker(context, "Schedule Next Visit", (value) {});
                                  },
                                  isLong: true,
                                )
                              ],
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }
                  return SizedBox();
                },
              )),
          Visibility(
            visible: patientId == null,
            child: CIA_TextFormField(
              label: "Search",
              controller: TextEditingController(text: search ?? ""),
              onChange: (v) {
                search = v;
                bloc.add(PatientVisitsBloc_GetVisitsEvent(
                  params: GetVisitsParams(
                    search: search,
                  ),
                ));
              },
            ),
          ),
          //TitleWidget(title: "Visits"),
          BlocConsumer<PatientVisitsBloc, PatientVisitsBloc_States>(
            listener: (context, state) {
              if (state is PatientVisitsBloc_LoadedVisitsSuccessfullyState)
                dataSource.updateData(newData: state.visits);
              else if (state is PatientVisitsBloc_VisitProcedureErrorState)
                ShowSnackBar(context, isSuccess: false, message: state.message);
              else if (state is PatientVisitsBloc_VisitProcedureSuccessState) {
                ShowSnackBar(context, isSuccess: true);

                bloc.add(PatientVisitsBloc_GetVisitsEvent(
                  params: GetVisitsParams(
                    search: search,
                    patientId: patientId,
                  ),
                ));
              } else if (state is PatientVisitsBloc_LeftSuccessState) {
                PaymentWidget(
                    patientId: patientId!,
                    context: context,
                    onFailure: (message) {
                      ShowSnackBar(context, isSuccess: false, message: message);
                    })();
              }
              if (state is PatientVisitsBloc_LoadingVisitsState)
                CustomLoader.show(context);
              else
                CustomLoader.hide();
            },
            buildWhen: (previous, current) =>
                current is PatientVisitsBloc_LoadingErrorState ||
                current is PatientVisitsBloc_LoadedPatientDataSuccessfullyState ||
                current is PatientVisitsBloc_LoadedVisitsSuccessfullyState,
            builder: (context, state) {
              if (state is PatientVisitsBloc_LoadingErrorState)
                return BigErrorPageWidget(message: state.message);
              else if (state is PatientVisitsBloc_LoadingVisitsState) return LoadingWidget();

              return Expanded(
                child: TableWidget(
                  //columnNames: dataSource.columns,
                  // loadFunction:()=> dataSource.loadData(),
                  dataSource: dataSource,
                  onCellClick: (index) {
                    context.goNamed(CreateOrViewPatientPage.getVisitPatientRouteName(),
                        pathParameters: {'id': dataSource.models.firstWhere((element) => element.secondaryId == index).patientId.toString()});
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
