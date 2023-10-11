import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/widgets/paymentWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getVisitsUseCase.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientVisitsBloc_Events.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientVisitsBloc_States.dart';
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
import '../bloc/patientVisitsBloc.dart';
import 'calendarWidget.dart';

class VisitsTableWidget extends StatelessWidget {
  VisitsTableWidget({
    Key? key,
    this.patientId,
  }) : super(key: key);
  int? patientId;
  late PatientVisitsBloc bloc;

  String? search;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<PatientVisitsBloc>(context);
    bloc.add(PatientVisitsBloc_GetVisitsEvent(params: GetVisitsParams(
      patientId: patientId
    )));
    VisitDataSource dataSource = VisitDataSource();
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
                                      onTab: () => bloc.add(PatientVisitsBloc_PatientEntersClinicEvent(id: patientId!)),
                                    ),
                                    CIA_SecondaryButton(
                                        width: 150,
                                        label: "Patient Leaves",
                                        onTab: () async {
                                          bloc.add(PatientVisitsBloc_PatientLeavesClinicEvent(id: patientId!));
                                          PaymentWidget(
                                              patientId: patientId!,
                                              context: context,
                                              onFailure: (message) {
                                                ShowSnackBar(context, isSuccess: false, message: message);
                                              })();
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
                                        width: 900,
                                        height: 600,
                                        title: "Schedule Next Visit",
                                        child: CalendarWidget(
                                          // dataSource: dataSource,
                                          getForDoctor: false,
                                          getAllSchedules: true,
                                          patientID: patientId,
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
          Visibility(visible: patientId==null,child:CIA_TextFormField(label: "Search", controller: TextEditingController(text: search??""),onChange: (v){
            search = v;
            bloc.add(PatientVisitsBloc_GetVisitsEvent(params: GetVisitsParams(
              search: search,
            ),));
          },),),
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
                    context.goNamed(CIA_Router.routeConst_PatientInfo,
                        pathParameters: {'id': dataSource.models.firstWhere((element) => element.id == index).patientId!.toString()});
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
