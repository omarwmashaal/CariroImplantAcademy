import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../Widgets/CIA_PrimaryButton.dart';
import '../../../../../Widgets/CIA_TeethChart.dart';
import '../../../../../Widgets/CIA_TextFormField.dart';
import '../../../../../Widgets/FormTextWidget.dart';
import '../../../../../Widgets/MultiSelectChipWidget.dart';
import '../../../../../Widgets/SnackBar.dart';
import '../../../../constants/enums/enums.dart';
import '../../../../helpers/spaceToString.dart';
import '../../../../presentation/widgets/LoadingWidget.dart';
import '../../domain/entities/clinicPriceEntity.dart';
import '../../domain/useCases/getTeethClinicPrice.dart';
import '../bloc/settingsBloc.dart';
import '../bloc/settingsBloc_Events.dart';
import '../bloc/settingsBloc_States.dart';

class ClinicPricesSettingsWidget extends StatefulWidget {
  const ClinicPricesSettingsWidget({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  State<ClinicPricesSettingsWidget> createState() => _ClinicPricesSettingsWidgetState();
}

class _ClinicPricesSettingsWidgetState extends State<ClinicPricesSettingsWidget> {
  List<EnumClinicPrices> categories = [];
  List<int> teeth = [];
  late SettingsBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<SettingsBloc>(context);
    bloc.add(SettingsBloc_LoadImplantCompaniesEvent());
    if(widget.type.toLowerCase().contains("ortho"))
      categories = [EnumClinicPrices.Ortho];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsBloc_States>(
      listener: (context, state) {
        if (state is SettingsBloc_EditedClinicPricesSuccessfullyState) {
          ShowSnackBar(context, isSuccess: true);
          bloc.add(
            SettingsBloc_LoadClinicPricesEvent(
              params: GetTeethClinicPircesParams(
                category: categories.isEmpty ? null : categories,
                teeth: teeth.isEmpty ? null : teeth,
              ),
            ),
          );
        }
      },
      child: Column(
        children: [
          CIA_TeethChart(onChange: (selectedTeethList) {
            teeth.removeWhere((element) => element<50);
            if (widget.type.toLowerCase().contains("pedo")) {
              teeth!.addAll(selectedTeethList);
              teeth = teeth.toSet().toList();
            } else
              teeth = selectedTeethList.map((e) => e).toList();
          }),
          SizedBox(height: 10),
          Visibility(
            visible: widget.type.toLowerCase().contains("pedo"),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CIA_TeethPedoChart(
                onChange: (selectedTeethList) {
                  teeth.removeWhere((element) => element>50);
                  teeth!.addAll(selectedTeethList.map((e) => e.value));
                  teeth = teeth.toSet().toList();
                },
              ),
            ),
          ),
          Visibility(
            visible: !widget.type.toLowerCase().contains("ortho"),
            child: CIA_MultiSelectChipWidget(
              onChangeList: (list) {
                categories = [];
                if (list.contains("All")) {
                  categories = EnumClinicPrices.values.where((element) => element.name.toLowerCase().startsWith(widget.type.toLowerCase())).toList();
                } else {
                  list = list.map((e) => "${widget.type}${e.removeAllWhitespace}").toList();
                  categories = list.map((e) => EnumClinicPrices.values.firstWhere((element) => element.name.toLowerCase() == e.toLowerCase())).toList();
                }
              },
              labels: EnumClinicPrices.values
                  .where((element) => element.name.toLowerCase().startsWith(widget.type.toLowerCase()))
                  .toList()
                  .map((e) => CIA_MultiSelectChipWidgeModel(label: AddSpacesToSentence("${e.name}").replaceAll(widget.type, "")))
                  .toList()),),
          CIA_PrimaryButton(
              label: "Get Prices",
              onTab: () {
                if (categories.isEmpty && !widget.type.toLowerCase().contains("ortho"))
                  ShowSnackBar(context, isSuccess: false, message: "Please choose category");
                else
                  bloc.add(
                    SettingsBloc_LoadClinicPricesEvent(
                      params: GetTeethClinicPircesParams(
                        category: categories.isEmpty ? null : categories,
                        teeth: teeth.isEmpty ? null : teeth,
                      ),
                    ),
                  );
              }),
          BlocBuilder<SettingsBloc, SettingsBloc_States>(
            builder: (context, state) {
              if (state is SettingsBloc_LoadingClinicPricesState)
                return LoadingWidget();
              else if (state is SettingsBloc_LoadedClinicPricesSuccessfullyState) {
                List<ClinicPriceEntity> prices = state.data;
                List<int?> uniquePrices = prices.map((e) => e.price).toSet().toList();
                var uniqueCats = prices.map((e) => e.category).toSet().toList();
                List<ClinicPriceEntity> groupedPrices = [];
                for (var p in uniquePrices) {
                  for (var cat in uniqueCats) {
                    var common = prices
                        .where(
                          (element) => element.price == p && element.category == cat,
                        )
                        .toList();
                    if (common.isNotEmpty) {
                      groupedPrices.add(ClinicPriceEntity(
                        category: cat,
                        price: p,
                        teethList: common.map((e) => e.tooth!).toSet().toList(),
                      ));
                    }
                  }
                }
                groupedPrices = groupedPrices.toSet().toList();
                return Column(
                  children: [
                    ...groupedPrices
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CIA_TextFormField(
                                      isNumber: true,
                                      label: widget.type=="Ortho"?"Ortho Price": AddSpacesToSentence(e?.category?.name ?? ""),
                                      controller: TextEditingController(text: e.price?.toString() ?? "0"),
                                      onChange: (value) {
                                        if (value == "" || value == null) value = "0";
                                        var o = prices.where((element) => element.category == e.category && e.teethList!.contains(element.tooth)).toList();
                                        for (var p in o) {
                                          p.price = int.parse(value);
                                        }
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: FormTextValueWidget(
                                      text: (){
                                       var list = (e.teethList!..sort((a, b) => a.compareTo(b),));
                                       var stringList = <String>[];
                                       list.forEach((element) {
                                         if(element>50)
                                           {
                                             stringList.add(EnumClinicPedoTooth.values.firstWhere((e) => e.value==element).name);
                                           }
                                         else stringList.add(element.toString());
                                       });
                                       return stringList.toString();
                                      }(),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                    CIA_PrimaryButton(
                        label: "Save Changes",
                        onTab: () {
                          bloc.add(SettingsBloc_EditClinicPricesEvent(prices: prices));
                        })
                  ],
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
