import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getTeethClinicPrice.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc_Events.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClinicTreatmentPricesWidget extends StatefulWidget {
  const ClinicTreatmentPricesWidget({Key? key, required this.clinicTreatmentEntity}) : super(key: key);
  final ClinicTreatmentEntity clinicTreatmentEntity;

  @override
  State<ClinicTreatmentPricesWidget> createState() => _ClinicTreatmentPricesWidgetState();
}

class _ClinicTreatmentPricesWidgetState extends State<ClinicTreatmentPricesWidget> {
  late ClinicTreatmentBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ClinicTreatmentBloc>(context);
    super.initState();
  }

  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> r = [];
    if (widget.clinicTreatmentEntity.restorations!.isNotEmpty) {
      bloc.add(ClinicTreatmentBloc_GetPriceEvent(
          params: GetTeethClinicPircesParams(
            category: EnumClinicPrices.values.where((element) => element.name.startsWith("Restoration")).toList(),
            teeth: widget.clinicTreatmentEntity.restorations!.map((e) => e.tooth!).toList(),
          ),
          key: "Restorations"));
      r.add(FormTextKeyWidget(text: "Restorations"));
      r.add(BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
        buildWhen: (previous, current) =>
            (current is ClinicTreatmentBloc_LoadingPricesState && current.key == "Restorations") ||
            (current is ClinicTreatmentBloc_LoadedPricesSuccessfullyState && current.key == "Restorations") ||
            (current is ClinicTreatmentBloc_LoadingPricesErrorState && current.key == "Restorations"),
        builder: (context, state) {
          if (state is ClinicTreatmentBloc_LoadingPricesState)
            return LoadingWidget();
          else if (state is ClinicTreatmentBloc_LoadingPricesErrorState)
            return BigErrorPageWidget(message: state.message);
          else if (state is ClinicTreatmentBloc_LoadedPricesSuccessfullyState) {
            for (var rest in widget.clinicTreatmentEntity.restorations!) {
              rest.statusPrice = rest.statusPrice ??
                  ((rest.status == null || rest.status == EnumClinicRestorationStatus.NotSelected)
                      ? 0
                      : state.prices
                              .firstWhere((element) => element.tooth == rest.tooth && element.category!.name == "RestorationStatus${rest.status?.name}")
                              .price ??
                          0);
              rest.classPrice = rest.classPrice ??
                  ((rest.restorationClass == null || rest.restorationClass == EnumClinicRestorationClass.NotSelected)
                      ? 0
                      : state.prices
                              .firstWhere(
                                  (element) => element.tooth == rest.tooth && element.category!.name == "RestorationClass${rest.restorationClass?.name}")
                              .price ??
                          0);
              rest.typePrice = rest.typePrice ??
                  ((rest.type == null || rest.type == EnumClinicRestorationType.NotSelected)
                      ? 0
                      : state.prices
                              .firstWhere((element) => element.tooth == rest.tooth && element.category!.name == "RestorationType${rest.type?.name}")
                              .price ??
                          0);
              rest.price = (rest.statusPrice ?? 0) + (rest.typePrice ?? 0) + (rest.classPrice ?? 0);
            }
            return Expanded(
              child: Container(
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
                                              bloc.emit(ClinicTreatmentBloc_LoadedPricesSuccessfullyState(key: "Restorations", prices: state.prices));
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
                                              bloc.emit(ClinicTreatmentBloc_LoadedPricesSuccessfullyState(key: "Restorations", prices: state.prices));
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
                                              bloc.emit(ClinicTreatmentBloc_LoadedPricesSuccessfullyState(key: "Restorations", prices: state.prices));
                                              bloc.add(ClinicTreatmentBloc_CalculateTotalPriceEvent(params: widget.clinicTreatmentEntity));
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        FormTextKeyWidget(text: "Total: "),
                                        FormTextValueWidget(text: e.price.toString()),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            );
          }
          return Container();
        },
      ));
    }
    if (widget.clinicTreatmentEntity.clinicImplants!.isNotEmpty) {
      bloc.add(ClinicTreatmentBloc_GetPriceEvent(
          params: GetTeethClinicPircesParams(
            category: EnumClinicPrices.values.where((element) => element.name.startsWith("Implant")).toList(),
            teeth: widget.clinicTreatmentEntity.clinicImplants!.map((e) => e.tooth!).toList(),
          ),
          key: "Implants"));
      r.add(FormTextKeyWidget(text: "Implants"));
      r.add(BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
        buildWhen: (previous, current) =>
            (current is ClinicTreatmentBloc_LoadingPricesState && current.key == "Implants") ||
            (current is ClinicTreatmentBloc_LoadedPricesSuccessfullyState && current.key == "Implants") ||
            (current is ClinicTreatmentBloc_LoadingPricesErrorState && current.key == "Implants"),
        builder: (context, state) {
          if (state is ClinicTreatmentBloc_LoadingPricesState)
            return LoadingWidget();
          else if (state is ClinicTreatmentBloc_LoadingPricesErrorState)
            return BigErrorPageWidget(message: state.message);
          else if (state is ClinicTreatmentBloc_LoadedPricesSuccessfullyState) {
            for (var clinicImplant in widget.clinicTreatmentEntity.clinicImplants!) {
              clinicImplant.price = clinicImplant.price ??
                  ((clinicImplant.type == null || clinicImplant.type == EnumClinicImplantTypes.NotSelected)
                      ? 0
                      : state.prices
                              .firstWhere(
                                  (element) => element.tooth == clinicImplant.tooth && element.category!.name == "ImplantType${clinicImplant.type?.name}")
                              .price ??
                          0);
            }
            return Container(
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
                                      bloc.add(ClinicTreatmentBloc_CalculateTotalPriceEvent(params: widget.clinicTreatmentEntity));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      FormTextKeyWidget(text: "Total: "),
                                      FormTextValueWidget(text: e.price.toString()),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          }
          return Container();
        },
      ));
    }
    if (widget.clinicTreatmentEntity.orthoTreatments!.isNotEmpty) {
      bloc.add(ClinicTreatmentBloc_GetPriceEvent(
          params: GetTeethClinicPircesParams(
            category: EnumClinicPrices.values.where((element) => element.name.startsWith("Ortho")).toList(),
            teeth: widget.clinicTreatmentEntity.orthoTreatments!.map((e) => e.tooth!).toList(),
          ),
          key: "Ortho"));
      r.add(FormTextKeyWidget(text: "Ortho"));
      r.add(BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
        buildWhen: (previous, current) =>
            (current is ClinicTreatmentBloc_LoadingPricesState && current.key == "Orhto") ||
            (current is ClinicTreatmentBloc_LoadedPricesSuccessfullyState && current.key == "Ortho") ||
            (current is ClinicTreatmentBloc_LoadingPricesErrorState && current.key == "Ortho"),
        builder: (context, state) {
          if (state is ClinicTreatmentBloc_LoadingPricesState)
            return LoadingWidget();
          else if (state is ClinicTreatmentBloc_LoadingPricesErrorState)
            return BigErrorPageWidget(message: state.message);
          else if (state is ClinicTreatmentBloc_LoadedPricesSuccessfullyState) {
            for (var orthoTreatments in widget.clinicTreatmentEntity.orthoTreatments!) {
              orthoTreatments.price = orthoTreatments.price ??
                  state.prices.firstWhere((element) => element.tooth == orthoTreatments.tooth && element.category!.name == "Ortho").price
                  ??   0;
            }
            return Container(
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
                                      bloc.add(ClinicTreatmentBloc_CalculateTotalPriceEvent(params: widget.clinicTreatmentEntity));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      FormTextKeyWidget(text: "Total: "),
                                      FormTextValueWidget(text: e.price.toString()),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          }
          return Container();
        },
      ));
    }
    if (widget.clinicTreatmentEntity.tmds!.isNotEmpty) {
      bloc.add(ClinicTreatmentBloc_GetPriceEvent(
          params: GetTeethClinicPircesParams(
            category: EnumClinicPrices.values.where((element) => element.name.startsWith("TMD")).toList(),
            teeth: widget.clinicTreatmentEntity.tmds!.map((e) => e.tooth!).toList(),
          ),
          key: "TMD"));
      r.add(FormTextKeyWidget(text: "TMD"));
      r.add(BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
        buildWhen: (previous, current) =>
        (current is ClinicTreatmentBloc_LoadingPricesState && current.key == "TMD") ||
            (current is ClinicTreatmentBloc_LoadedPricesSuccessfullyState && current.key == "TMD") ||
            (current is ClinicTreatmentBloc_LoadingPricesErrorState && current.key == "TMD"),
        builder: (context, state) {
          if (state is ClinicTreatmentBloc_LoadingPricesState)
            return LoadingWidget();
          else if (state is ClinicTreatmentBloc_LoadingPricesErrorState)
            return BigErrorPageWidget(message: state.message);
          else if (state is ClinicTreatmentBloc_LoadedPricesSuccessfullyState) {
            for (var tmds in widget.clinicTreatmentEntity.tmds!) {
              tmds.price = tmds.price ??
                  ((tmds.type == null || tmds.type == EnumClinicTMDtypes.NotSelected)
                      ? 0
                      : state.prices
                      .firstWhere(
                          (element) => element.tooth == tmds.tooth && element.category!.name == "TMDType${tmds.type?.name}")
                      .price ??
                      0);
            }
            return Container(
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
                                  bloc.add(ClinicTreatmentBloc_CalculateTotalPriceEvent(params: widget.clinicTreatmentEntity));
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  FormTextKeyWidget(text: "Total: "),
                                  FormTextValueWidget(text: e.price.toString()),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                    .toList(),
              ),
            );
          }
          return Container();
        },
      ));
    }
    if (widget.clinicTreatmentEntity.rootCanalTreatments!.isNotEmpty)
      if (widget.clinicTreatmentEntity.pedos!.isNotEmpty) {
        bloc.add(ClinicTreatmentBloc_GetPriceEvent(
            params: GetTeethClinicPircesParams(
              category: EnumClinicPrices.values.where((element) => element.name.startsWith("Pedo")).toList(),
              teeth: widget.clinicTreatmentEntity.pedos!.map((e) => e.tooth!).toList(),
            ),
            key: "pedos"));
        r.add(FormTextKeyWidget(text: "Pedo"));
        r.add(BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
          buildWhen: (previous, current) =>
          (current is ClinicTreatmentBloc_LoadingPricesState && current.key == "pedos") ||
              (current is ClinicTreatmentBloc_LoadedPricesSuccessfullyState && current.key == "pedos") ||
              (current is ClinicTreatmentBloc_LoadingPricesErrorState && current.key == "pedos"),
          builder: (context, state) {
            if (state is ClinicTreatmentBloc_LoadingPricesState)
              return LoadingWidget();
            else if (state is ClinicTreatmentBloc_LoadingPricesErrorState)
              return BigErrorPageWidget(message: state.message);
            else if (state is ClinicTreatmentBloc_LoadedPricesSuccessfullyState) {
              for (var pedos in widget.clinicTreatmentEntity.pedos!) {
                pedos.firstStepPrice = pedos.firstStepPrice ??
                    ((pedos.firstStep == null )
                        ? 0
                        : state.prices
                        .firstWhere((element) => element.tooth == pedos.tooth && element.category!.name == "Pedo${pedos.firstStep?.name}")
                        .price ??
                        0);
                  pedos.secondStepPrice = pedos.secondStepPrice ??
                    ((pedos.secondStep == null )
                        ? 0
                        : state.prices
                        .firstWhere((element) => element.tooth == pedos.tooth && element.category!.name == "Pedo${pedos.secondStep?.name}")
                        .price ??
                        0);

                pedos.price = (pedos.firstStepPrice ?? 0) + (pedos.secondStepPrice ?? 0) ;
              }
              return Expanded(
                child: Container(
                  height: 100 * (widget.clinicTreatmentEntity.pedos?.length ?? 1) as double,
                  child: Column(
                    children: widget.clinicTreatmentEntity.pedos!
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
                                          label: "First Step ${e.firstStep?.name}",
                                          controller: TextEditingController(text: e.firstStepPrice?.toString()),
                                          isNumber: true,
                                          onChange: (value) {
                                            e.firstStepPrice = int.parse(value);
                                            e.price = (e.firstStepPrice ?? 0) + (e.secondStepPrice ?? 0) ;
                                            bloc.emit(ClinicTreatmentBloc_LoadedPricesSuccessfullyState(key: "Pedo", prices: state.prices));
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
                                            e.price = (e.firstStepPrice ?? 0) + (e.secondStepPrice ?? 0) ;
                                            bloc.emit(ClinicTreatmentBloc_LoadedPricesSuccessfullyState(key: "Pedo", prices: state.prices));
                                            bloc.add(ClinicTreatmentBloc_CalculateTotalPriceEvent(params: widget.clinicTreatmentEntity));
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      FormTextKeyWidget(text: "Total: "),
                                      FormTextValueWidget(text: e.price.toString()),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ),
              );
            }
            return Container();
          },
        ));
      }
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: r,
          ),
        ),
        SizedBox(
          child: Row(
            children: [
              FormTextKeyWidget(text: "Total: EGP "),
              BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
                  buildWhen: (previous, current) => current is ClinicTreatmentBloc_TotalPriceChangedState,
                  builder: (context, state) {
                    if (state is ClinicTreatmentBloc_TotalPriceChangedState) totalPrice = state.price;

                    return FormTextValueWidget(text: totalPrice.toString());
                  }),
            ],
          ),
        )
      ],
    );
  }
}
