import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/clinicPriceEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getTeethClinicPrice.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/useCases/updateTreatmentsUseCase.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc_Events.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClinicTreatmentPricesWidget extends StatefulWidget {
  const ClinicTreatmentPricesWidget({Key? key, required this.clinicTreatmentEntity, this.showDoctorsPercentage = false}) : super(key: key);
  final ClinicTreatmentEntity clinicTreatmentEntity;
  final bool showDoctorsPercentage;

  @override
  State<ClinicTreatmentPricesWidget> createState() => _ClinicTreatmentPricesWidgetState();
}

class _ClinicTreatmentPricesWidgetState extends State<ClinicTreatmentPricesWidget> {
  late ClinicTreatmentBloc bloc;
  List<ClinicPriceEntity> percentages = [];

  @override
  void initState() {
    bloc = BlocProvider.of<ClinicTreatmentBloc>(context);
    bloc.add(ClinicTreatmentBloc_UpdateTreatmentsEvent(
        data: UpdateClinicTreatmentsParams(
      id: widget.clinicTreatmentEntity.patientId!,
      data: widget.clinicTreatmentEntity!,
    )));
    super.initState();
  }

  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
      listener: (context, state) {
        if(state is ClinicTreatmentBloc_UpdatedTreatmentsSuccessfullyState) {
            bloc.add(ClinicTreatmentBloc_LoadTreatmentsEvent(id: widget.clinicTreatmentEntity.patientId!));
            bloc.add(ClinicTreatmentBloc_CalculateTotalPriceEvent(params: widget.clinicTreatmentEntity));
          }
        },
        buildWhen: (previous, current) =>
            current is ClinicTreatmentBloc_UpdatingTreatmentsState ||
            current is ClinicTreatmentBloc_UpdatingTreatmentsErrorState ||
            current is ClinicTreatmentBloc_UpdatedTreatmentsSuccessfullyState ||
            current is ClinicTreatmentBloc_LoadingTreatmentsErrorState ||
            current is ClinicTreatmentBloc_LoadingTreatmentsState ||
            current is ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState,
        builder: (context, state) {
          if (state is ClinicTreatmentBloc_LoadingTreatmentsState || state is ClinicTreatmentBloc_UpdatingTreatmentsState)
            return LoadingWidget();
          else if (state is ClinicTreatmentBloc_UpdatingTreatmentsErrorState || state is ClinicTreatmentBloc_LoadingTreatmentsErrorState)
            return BigErrorPageWidget(message: state.toString());
          else if(state is ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState)
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      widget.clinicTreatmentEntity.restorations!.isEmpty
                          ? Container()
                          : Column(
                              children: [
                                FormTextKeyWidget(text: "Restorations"),
                                Container(
                                  height: 100 * (widget.clinicTreatmentEntity.restorations?.length ?? 1) as double,
                                  child: Column(
                                    children: widget.clinicTreatmentEntity.restorations!
                                        .map(
                                          (e) => Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                FormTextValueWidget(text: "Tooth: ${e.tooth}"),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: CIA_TextFormField(
                                                              label: "Status ${e.status?.name}",
                                                              controller: TextEditingController(text: e.statusPrice?.toString()),
                                                              isNumber: true,
                                                              onChange: (value) {
                                                                e.statusPrice = int.parse(value);
                                                                e.price = (e.statusPrice ?? 0) + (e.typePrice ?? 0) + (e.classPrice ?? 0);
                                                                bloc.emit(ClinicTreatmentBloc_LoadedPricesSuccessfullyState(
                                                                  key: "Restorations",
                                                                ));
                                                                bloc.add(ClinicTreatmentBloc_CalculateTotalPriceEvent(params: widget.clinicTreatmentEntity));
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Expanded(
                                                            child: CIA_TextFormField(
                                                              label: "Type ${e.type?.name}",
                                                              controller: TextEditingController(text: e.typePrice?.toString()),
                                                              isNumber: true,
                                                              onChange: (value) {
                                                                e.typePrice = int.parse(value);
                                                                e.price = (e.statusPrice ?? 0) + (e.typePrice ?? 0) + (e.classPrice ?? 0);
                                                                bloc.emit(ClinicTreatmentBloc_LoadedPricesSuccessfullyState(
                                                                  key: "Restorations",
                                                                ));
                                                                bloc.add(ClinicTreatmentBloc_CalculateTotalPriceEvent(params: widget.clinicTreatmentEntity));
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Expanded(
                                                            child: CIA_TextFormField(
                                                              label: "Class ${e.restorationClass?.name}",
                                                              controller: TextEditingController(text: e.classPrice?.toString()),
                                                              isNumber: true,
                                                              onChange: (value) {
                                                                e.classPrice = int.parse(value);
                                                                e.price = (e.statusPrice ?? 0) + (e.typePrice ?? 0) + (e.classPrice ?? 0);
                                                                bloc.emit(ClinicTreatmentBloc_LoadedPricesSuccessfullyState(
                                                                  key: "Restorations",
                                                                ));
                                                                bloc.add(ClinicTreatmentBloc_CalculateTotalPriceEvent(params: widget.clinicTreatmentEntity));
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                        ],
                                                      ),
                                                    ),
                                                    BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
                                                      buildWhen: (previous, current) =>
                                                          (current is ClinicTreatmentBloc_LoadedPricesSuccessfullyState && current.key == "Restorations"),
                                                      builder: (context, state) {
                                                        int price = e.price ?? 0;

                                                          return Expanded(
                                                            child: Row(
                                                              children: [
                                                                FormTextKeyWidget(text: "Total: "),
                                                                FormTextValueWidget(text: price.toString()),
                                                              ],
                                                            ),
                                                          );

                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )
                              ],
                            ),
                      widget.clinicTreatmentEntity.clinicImplants!.isEmpty
                          ? Container()
                          : Column(
                              children: [
                                FormTextKeyWidget(text: "Implants"),
                                Container(
                                  height: 100 * (widget.clinicTreatmentEntity.clinicImplants?.length ?? 1) as double,
                                  child: Column(
                                    children: widget.clinicTreatmentEntity.clinicImplants!
                                        .map(
                                          (e) => Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                FormTextValueWidget(text: "Tooth: ${e.tooth} || ${e.type?.name} Implant"),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: CIA_TextFormField(
                                                        label: "${e.implant_?.name}",
                                                        controller: TextEditingController(text: e.price?.toString()),
                                                        isNumber: true,
                                                        onChange: (value) {
                                                          e.price = int.parse(value);
                                                          bloc.emit(ClinicTreatmentBloc_LoadedPricesSuccessfullyState(
                                                            key: "Implants",
                                                          ));
                                                          bloc.add(ClinicTreatmentBloc_CalculateTotalPriceEvent(params: widget.clinicTreatmentEntity));
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
                                                      buildWhen: (previous, current) =>
                                                          (current is ClinicTreatmentBloc_LoadedPricesSuccessfullyState && current.key == "Implants"),
                                                      builder: (context, state) {
                                                        int price = e.price ?? 0;

                                                          return Expanded(
                                                            child: Row(
                                                              children: [
                                                                FormTextKeyWidget(text: "Total: "),
                                                                FormTextValueWidget(text: price.toString()),
                                                              ],
                                                            ),
                                                          );

                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )
                              ],
                            ),
                      widget.clinicTreatmentEntity.orthoTreatments!.isEmpty
                          ? Container()
                          : Column(
                              children: [
                                FormTextKeyWidget(text: "Ortho"),
                                Container(
                                  height: 100 * (widget.clinicTreatmentEntity.orthoTreatments?.length ?? 1) as double,
                                  child: Column(
                                    children: widget.clinicTreatmentEntity.orthoTreatments!
                                        .map(
                                          (e) => Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                FormTextValueWidget(text: "Tooth: ${e.tooth}"),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: CIA_TextFormField(
                                                        label: "Price",
                                                        controller: TextEditingController(text: e.price?.toString()),
                                                        isNumber: true,
                                                        onChange: (value) {
                                                          e.price = int.parse(value);
                                                          bloc.emit(ClinicTreatmentBloc_LoadedPricesSuccessfullyState(
                                                            key: "Orhto",
                                                          ));
                                                          bloc.add(ClinicTreatmentBloc_CalculateTotalPriceEvent(params: widget.clinicTreatmentEntity));
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
                                                      buildWhen: (previous, current) =>
                                                          (current is ClinicTreatmentBloc_LoadedPricesSuccessfullyState && current.key == "Orhto"),
                                                      builder: (context, state) {
                                                        int price = e.price ?? 0;

                                                          return Expanded(
                                                            child: Row(
                                                              children: [
                                                                FormTextKeyWidget(text: "Total: "),
                                                                FormTextValueWidget(text: price.toString()),
                                                              ],
                                                            ),
                                                          );

                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )
                              ],
                            ),
                      widget.clinicTreatmentEntity.pedos!.isEmpty
                          ? Container()
                          : Column(
                              children: [
                                FormTextKeyWidget(text: "Pedo"),
                                Container(
                                  height: 100 * (widget.clinicTreatmentEntity.pedos?.length ?? 1) as double,
                                  child: Column(
                                    children: widget.clinicTreatmentEntity.pedos!
                                        .map(
                                          (e) => Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                FormTextValueWidget(
                                                    text:
                                                        "Tooth: ${(e.tooth ?? 0) < 50 ? e.tooth : EnumClinicPedoTooth.values.firstWhere((element) => element.value == e.tooth).name}"),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: CIA_TextFormField(
                                                              label: "First Step ${e.firstStep?.name}",
                                                              controller: TextEditingController(text: e.firstStepPrice?.toString()),
                                                              isNumber: true,
                                                              onChange: (value) {
                                                                e.firstStepPrice = int.parse(value);
                                                                e.price = (e.firstStepPrice ?? 0) + (e.secondStepPrice ?? 0);
                                                                bloc.emit(ClinicTreatmentBloc_LoadedPricesSuccessfullyState(
                                                                  key: "Pedo",
                                                                ));
                                                                bloc.add(ClinicTreatmentBloc_CalculateTotalPriceEvent(params: widget.clinicTreatmentEntity));
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Expanded(
                                                            child: CIA_TextFormField(
                                                              label: "Second Step ${e.secondStep?.name}",
                                                              controller: TextEditingController(text: e.secondStepPrice?.toString()),
                                                              isNumber: true,
                                                              onChange: (value) {
                                                                e.secondStepPrice = int.parse(value);
                                                                e.price = (e.firstStepPrice ?? 0) + (e.secondStepPrice ?? 0);
                                                                bloc.emit(ClinicTreatmentBloc_LoadedPricesSuccessfullyState(
                                                                  key: "Pedo",
                                                                ));
                                                                bloc.add(ClinicTreatmentBloc_CalculateTotalPriceEvent(params: widget.clinicTreatmentEntity));
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                        ],
                                                      ),
                                                    ),
                                                    BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
                                                      buildWhen: (previous, current) =>
                                                          (current is ClinicTreatmentBloc_LoadedPricesSuccessfullyState && current.key == "Pedo"),
                                                      builder: (context, state) {
                                                        int price = e.price ?? 0;

                                                          return Expanded(
                                                            child: Row(
                                                              children: [
                                                                FormTextKeyWidget(text: "Total: "),
                                                                FormTextValueWidget(text: price.toString()),
                                                              ],
                                                            ),
                                                          );

                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )
                              ],
                            ),
                      widget.clinicTreatmentEntity.tmds!.isEmpty
                          ? Container()
                          : Column(
                              children: [
                                FormTextKeyWidget(text: "TMD"),
                                Container(
                                  height: 100 * (widget.clinicTreatmentEntity.tmds?.length ?? 1) as double,
                                  child: Column(
                                    children: widget.clinicTreatmentEntity.tmds!
                                        .map(
                                          (e) => Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                FormTextValueWidget(text: "Tooth: ${e.tooth} "),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: CIA_TextFormField(
                                                        label: "${e.type?.name}",
                                                        controller: TextEditingController(text: e.price?.toString()),
                                                        isNumber: true,
                                                        onChange: (value) {
                                                          e.price = int.parse(value);
                                                          bloc.emit(ClinicTreatmentBloc_LoadedPricesSuccessfullyState(
                                                            key: "TMD",
                                                          ));
                                                          bloc.add(ClinicTreatmentBloc_CalculateTotalPriceEvent(params: widget.clinicTreatmentEntity));
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
                                                      buildWhen: (previous, current) =>
                                                          (current is ClinicTreatmentBloc_LoadedPricesSuccessfullyState && current.key == "TMD"),
                                                      builder: (context, state) {
                                                        int price = e.price ?? 0;

                                                          return Expanded(
                                                            child: Row(
                                                              children: [
                                                                FormTextKeyWidget(text: "Total: "),
                                                                FormTextValueWidget(text: price.toString()),
                                                              ],
                                                            ),
                                                          );

                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                      widget.clinicTreatmentEntity.rootCanalTreatments!.isEmpty
                          ? Container()
                          : Column(
                              children: [
                                FormTextKeyWidget(text: "Root Canal Treatment"),
                                Container(
                                  height: 100 * (widget.clinicTreatmentEntity.rootCanalTreatments?.length ?? 1) as double,
                                  child: Column(
                                    children: widget.clinicTreatmentEntity.rootCanalTreatments!
                                        .map(
                                          (e) => Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                FormTextValueWidget(text: "Tooth: ${e.tooth} "),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: CIA_TextFormField(
                                                        label: "Type: ${e.type?.name} || Length: ${e.length} ",
                                                        controller: TextEditingController(text: e.price?.toString()),
                                                        isNumber: true,
                                                        onChange: (value) {
                                                          e.price = int.parse(value);
                                                          bloc.emit(ClinicTreatmentBloc_LoadedPricesSuccessfullyState(
                                                            key: "Root",
                                                          ));
                                                          bloc.add(ClinicTreatmentBloc_CalculateTotalPriceEvent(params: widget.clinicTreatmentEntity));
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
                                                      buildWhen: (previous, current) =>
                                                          (current is ClinicTreatmentBloc_LoadedPricesSuccessfullyState && current.key == "Root"),
                                                      builder: (context, state) {
                                                        int price = e.price ?? 0;

                                                          return Expanded(
                                                            child: Row(
                                                              children: [
                                                                FormTextKeyWidget(text: "Total: "),
                                                                FormTextValueWidget(text: price.toString()),
                                                              ],
                                                            ),
                                                          );

                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                      widget.clinicTreatmentEntity.scalings!.isEmpty
                          ? Container()
                          : Column(
                              children: [
                                FormTextKeyWidget(text: "Scaling"),
                                Container(
                                  height: 100 * (widget.clinicTreatmentEntity.scalings?.length ?? 1) as double,
                                  child: Column(
                                    children: widget.clinicTreatmentEntity.scalings!
                                        .map(
                                          (e) => Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                FormTextValueWidget(text: "Tooth: ${e.tooth} "),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: CIA_TextFormField(
                                                        label: "${e.type?.name}",
                                                        controller: TextEditingController(text: e.price?.toString()),
                                                        isNumber: true,
                                                        onChange: (value) {
                                                          e.price = int.parse(value);
                                                          bloc.emit(ClinicTreatmentBloc_LoadedPricesSuccessfullyState(
                                                            key: "Scaling",
                                                          ));
                                                          bloc.add(ClinicTreatmentBloc_CalculateTotalPriceEvent(params: widget.clinicTreatmentEntity));
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
                                                      buildWhen: (previous, current) =>
                                                          (current is ClinicTreatmentBloc_LoadedPricesSuccessfullyState && current.key == "Scaling"),
                                                      builder: (context, state) {
                                                        int price = e.price ?? 0;

                                                          return Expanded(
                                                            child: Row(
                                                              children: [
                                                                FormTextKeyWidget(text: "Total: "),
                                                                FormTextValueWidget(text: price.toString()),
                                                              ],
                                                            ),
                                                          );

                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )
                              ],
                            ),
                    ],
                  ),
                ),
              ),
              Divider(),
              SizedBox(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FormTextKeyWidget(text: "Total: EGP "),
                    BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
                        buildWhen: (previous, current) => current is ClinicTreatmentBloc_TotalPriceChangedState,
                        builder: (context, state) {
                          if (state is ClinicTreatmentBloc_TotalPriceChangedState) totalPrice = state.price;

                          return Text(
                            totalPrice.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          );
                        }),
                  ],
                ),
              )
            ],
          );
          return Container();
        });
  }
}
