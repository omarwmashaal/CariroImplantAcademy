import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:flutter/cupertino.dart';

import 'MultiSelectChipWidget.dart';

class CIA_TeethChart extends StatefulWidget {
  CIA_TeethChart({Key? key, this.onChange, this.selectedTeeth}) : super(key: key);

  late List<int>? selectedTeeth;
  Function(List<int> selectedTeethList)? onChange;
  @override
  State<CIA_TeethChart> createState() => _CIA_TeethChartState();
}

class _CIA_TeethChartState extends State<CIA_TeethChart> {
  List<int> selectedTeeth = <int>[];

  @override
  void initState() {
    if (widget.selectedTeeth == null) widget.selectedTeeth = [];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedTeeth == null) widget.selectedTeeth = [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: CIA_MultiSelectChipWidget(
                key: GlobalKey(),
                onChange: (item, isSelected) {
                  if (isSelected)
                    selectedTeeth.add(int.parse(item));
                  else
                    selectedTeeth.remove(int.parse(item));
                  if (widget.onChange != null) widget.onChange!(selectedTeeth);
                },
                labels: [
                  CIA_MultiSelectChipWidgeModel(label: "18", isSelected: widget.selectedTeeth!.contains(18)),
                  CIA_MultiSelectChipWidgeModel(label: "17", isSelected: widget.selectedTeeth!.contains(17)),
                  CIA_MultiSelectChipWidgeModel(label: "16", isSelected: widget.selectedTeeth!.contains(16)),
                  CIA_MultiSelectChipWidgeModel(label: "15", isSelected: widget.selectedTeeth!.contains(15)),
                  CIA_MultiSelectChipWidgeModel(label: "14", isSelected: widget.selectedTeeth!.contains(14)),
                  CIA_MultiSelectChipWidgeModel(label: "13", isSelected: widget.selectedTeeth!.contains(13)),
                  CIA_MultiSelectChipWidgeModel(label: "12", isSelected: widget.selectedTeeth!.contains(12)),
                  CIA_MultiSelectChipWidgeModel(label: "11", isSelected: widget.selectedTeeth!.contains(11)),
                ],
              ),
            ),
            Expanded(
              child: CIA_MultiSelectChipWidget(
                key: GlobalKey(),
                onChange: (item, isSelected) {
                  if (isSelected)
                    selectedTeeth.add(int.parse(item));
                  else
                    selectedTeeth.remove(int.parse(item));
                  if (widget.onChange != null) widget.onChange!(selectedTeeth);
                },
                labels: [
                  CIA_MultiSelectChipWidgeModel(label: "21", isSelected: widget.selectedTeeth!.contains(21)),
                  CIA_MultiSelectChipWidgeModel(label: "22", isSelected: widget.selectedTeeth!.contains(22)),
                  CIA_MultiSelectChipWidgeModel(label: "23", isSelected: widget.selectedTeeth!.contains(23)),
                  CIA_MultiSelectChipWidgeModel(label: "24", isSelected: widget.selectedTeeth!.contains(24)),
                  CIA_MultiSelectChipWidgeModel(label: "25", isSelected: widget.selectedTeeth!.contains(25)),
                  CIA_MultiSelectChipWidgeModel(label: "26", isSelected: widget.selectedTeeth!.contains(26)),
                  CIA_MultiSelectChipWidgeModel(label: "27", isSelected: widget.selectedTeeth!.contains(27)),
                  CIA_MultiSelectChipWidgeModel(label: "28", isSelected: widget.selectedTeeth!.contains(28))
                ],
              ),
            ),
            SizedBox(width: 10),
            () {
              bool contains = true;
              for (var element in [
                11,
                12,
                13,
                14,
                15,
                16,
                17,
                18,
                21,
                22,
                23,
                24,
                25,
                26,
                27,
                28,
              ]) {
                if (!selectedTeeth.contains(element)) {
                  contains = false;
                  break;
                }
              }
              return contains;
            }()
                ? CIA_PrimaryButton(
                    label: "Unselect Upper",
                    isLong: true,
                    onTab: () {
                      selectedTeeth.removeWhere((element) => [
                            11,
                            12,
                            13,
                            14,
                            15,
                            16,
                            17,
                            18,
                            21,
                            22,
                            23,
                            24,
                            25,
                            26,
                            27,
                            28,
                          ].contains(element));
                      widget.selectedTeeth = selectedTeeth;
                      setState(() => null);
                    })
                : CIA_SecondaryButton(
                    label: "Select Upper",
                    onTab: () {
                      selectedTeeth.addAll([
                        11,
                        12,
                        13,
                        14,
                        15,
                        16,
                        17,
                        18,
                        21,
                        22,
                        23,
                        24,
                        25,
                        26,
                        27,
                        28,
                      ]);
                      selectedTeeth = selectedTeeth.toSet().toList();
                      widget.selectedTeeth = selectedTeeth;
                      if (widget.onChange != null) widget.onChange!(selectedTeeth);
                      setState(() => null);
                    })
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: CIA_MultiSelectChipWidget(
                key: GlobalKey(),
                onChange: (item, isSelected) {
                  if (isSelected)
                    selectedTeeth.add(int.parse(item));
                  else
                    selectedTeeth.remove(int.parse(item));
                  if (widget.onChange != null) widget.onChange!(selectedTeeth);
                },
                labels: [
                  CIA_MultiSelectChipWidgeModel(label: "48", isSelected: widget.selectedTeeth!.contains(48)),
                  CIA_MultiSelectChipWidgeModel(label: "47", isSelected: widget.selectedTeeth!.contains(47)),
                  CIA_MultiSelectChipWidgeModel(label: "46", isSelected: widget.selectedTeeth!.contains(46)),
                  CIA_MultiSelectChipWidgeModel(label: "45", isSelected: widget.selectedTeeth!.contains(45)),
                  CIA_MultiSelectChipWidgeModel(label: "44", isSelected: widget.selectedTeeth!.contains(44)),
                  CIA_MultiSelectChipWidgeModel(label: "43", isSelected: widget.selectedTeeth!.contains(43)),
                  CIA_MultiSelectChipWidgeModel(label: "42", isSelected: widget.selectedTeeth!.contains(42)),
                  CIA_MultiSelectChipWidgeModel(label: "41", isSelected: widget.selectedTeeth!.contains(41)),
                ],
              ),
            ),
            Expanded(
              child: CIA_MultiSelectChipWidget(
                key: GlobalKey(),
                onChange: (item, isSelected) {
                  if (isSelected)
                    selectedTeeth.add(int.parse(item));
                  else
                    selectedTeeth.remove(int.parse(item));
                  if (widget.onChange != null) widget.onChange!(selectedTeeth);
                },
                labels: [
                  CIA_MultiSelectChipWidgeModel(label: "31", isSelected: widget.selectedTeeth!.contains(31)),
                  CIA_MultiSelectChipWidgeModel(label: "32", isSelected: widget.selectedTeeth!.contains(32)),
                  CIA_MultiSelectChipWidgeModel(label: "33", isSelected: widget.selectedTeeth!.contains(33)),
                  CIA_MultiSelectChipWidgeModel(label: "34", isSelected: widget.selectedTeeth!.contains(34)),
                  CIA_MultiSelectChipWidgeModel(label: "35", isSelected: widget.selectedTeeth!.contains(35)),
                  CIA_MultiSelectChipWidgeModel(label: "36", isSelected: widget.selectedTeeth!.contains(36)),
                  CIA_MultiSelectChipWidgeModel(label: "37", isSelected: widget.selectedTeeth!.contains(37)),
                  CIA_MultiSelectChipWidgeModel(label: "38", isSelected: widget.selectedTeeth!.contains(38)),
                ],
              ),
            ),
            SizedBox(width: 10),
            () {
              bool contains = true;
              for (var element in [
                31,
                32,
                33,
                34,
                35,
                36,
                37,
                38,
                41,
                42,
                43,
                44,
                45,
                46,
                47,
                48,
              ]) {
                if (!selectedTeeth.contains(element)) {
                  contains = false;
                  break;
                }
              }
              return contains;
            }()
                ? CIA_PrimaryButton(
                    label: "Unselect Lower",
                    isLong: true,
                    onTab: () {
                      selectedTeeth.removeWhere((element) => [
                            31,
                            32,
                            33,
                            34,
                            35,
                            36,
                            37,
                            38,
                            41,
                            42,
                            43,
                            44,
                            45,
                            46,
                            47,
                            48,
                          ].contains(element));
                      widget.selectedTeeth = selectedTeeth;
                      setState(() => null);
                    })
                : CIA_SecondaryButton(
                    label: "Select Lower",
                    onTab: () {
                      selectedTeeth.addAll([
                        31,
                        32,
                        33,
                        34,
                        35,
                        36,
                        37,
                        38,
                        41,
                        42,
                        43,
                        44,
                        45,
                        46,
                        47,
                        48,
                      ]);
                      selectedTeeth = selectedTeeth.toSet().toList();
                      widget.selectedTeeth = selectedTeeth;
                      if (widget.onChange != null) widget.onChange!(selectedTeeth);
                      setState(() => null);
                    })
          ],
        ),
      ],
    );
  }
}

class CIA_TeethPedoChart extends StatefulWidget {
  CIA_TeethPedoChart({Key? key, this.onChange, this.selectedTeeth}) : super(key: key);

  late List<EnumClinicPedoTooth>? selectedTeeth;
  Function(List<EnumClinicPedoTooth> selectedTeethList)? onChange;
  @override
  State<CIA_TeethPedoChart> createState() => _CIA_TeethPedoChartState();
}

class _CIA_TeethPedoChartState extends State<CIA_TeethPedoChart> {
  List<EnumClinicPedoTooth> selectedTeeth = <EnumClinicPedoTooth>[];

  @override
  void initState() {
    if (widget.selectedTeeth == null) widget.selectedTeeth = [];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedTeeth == null) widget.selectedTeeth = [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: CIA_MultiSelectChipWidget(
                key: GlobalKey(),
                onChange: (item, isSelected) {
                  if (isSelected)
                    selectedTeeth.add(EnumClinicPedoTooth.values.firstWhere((element) => element.name.toLowerCase() == item.toLowerCase()));
                  else
                    selectedTeeth.remove(EnumClinicPedoTooth.values.firstWhere((element) => element.name.toLowerCase() == item.toLowerCase()));
                  if (widget.onChange != null) widget.onChange!(selectedTeeth);
                },
                labels: [
                  CIA_MultiSelectChipWidgeModel(
                      label: "E",
                      value: EnumClinicPedoTooth.UpperRightE.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.UpperRightE)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "D",
                      value: EnumClinicPedoTooth.UpperRightD.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.UpperRightD)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "C",
                      value: EnumClinicPedoTooth.UpperRightC.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.UpperRightC)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "B",
                      value: EnumClinicPedoTooth.UpperRightB.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.UpperRightB)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "A",
                      value: EnumClinicPedoTooth.UpperRightA.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.UpperRightA)),
                ],
              ),
            ),
            Expanded(
              child: CIA_MultiSelectChipWidget(
                key: GlobalKey(),
                onChange: (item, isSelected) {
                  if (isSelected)
                    selectedTeeth.add(EnumClinicPedoTooth.values.firstWhere((element) => element.name.toLowerCase() == item.toLowerCase()));
                  else
                    selectedTeeth.remove(EnumClinicPedoTooth.values.firstWhere((element) => element.name.toLowerCase() == item.toLowerCase()));
                  if (widget.onChange != null) widget.onChange!(selectedTeeth);
                },
                labels: [
                  CIA_MultiSelectChipWidgeModel(
                      label: "A",
                      value: EnumClinicPedoTooth.UpperLeftA.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.UpperLeftA)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "B",
                      value: EnumClinicPedoTooth.UpperLeftB.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.UpperLeftB)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "C",
                      value: EnumClinicPedoTooth.UpperLeftC.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.UpperLeftC)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "D",
                      value: EnumClinicPedoTooth.UpperLeftD.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.UpperLeftD)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "E",
                      value: EnumClinicPedoTooth.UpperLeftE.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.UpperLeftE)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: CIA_MultiSelectChipWidget(
                key: GlobalKey(),
                onChange: (item, isSelected) {
                  if (isSelected)
                    selectedTeeth.add(EnumClinicPedoTooth.values.firstWhere((element) => element.name.toLowerCase() == item.toLowerCase()));
                  else
                    selectedTeeth.remove(EnumClinicPedoTooth.values.firstWhere((element) => element.name.toLowerCase() == item.toLowerCase()));
                  if (widget.onChange != null) widget.onChange!(selectedTeeth);
                },
                labels: [
                  CIA_MultiSelectChipWidgeModel(
                      label: "E",
                      value: EnumClinicPedoTooth.LowerRightE.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.LowerRightE)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "D",
                      value: EnumClinicPedoTooth.LowerRightD.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.LowerRightD)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "C",
                      value: EnumClinicPedoTooth.LowerRightC.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.LowerRightC)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "B",
                      value: EnumClinicPedoTooth.LowerRightB.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.LowerRightB)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "A",
                      value: EnumClinicPedoTooth.LowerRightA.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.LowerRightA)),
                ],
              ),
            ),
            Expanded(
              child: CIA_MultiSelectChipWidget(
                key: GlobalKey(),
                onChange: (item, isSelected) {
                  if (isSelected)
                    selectedTeeth.add(EnumClinicPedoTooth.values.firstWhere((element) => element.name.toLowerCase() == item.toLowerCase()));
                  else
                    selectedTeeth.remove(EnumClinicPedoTooth.values.firstWhere((element) => element.name.toLowerCase() == item.toLowerCase()));
                  if (widget.onChange != null) widget.onChange!(selectedTeeth);
                },
                labels: [
                  CIA_MultiSelectChipWidgeModel(
                      label: "A",
                      value: EnumClinicPedoTooth.LowerLeftA.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.LowerLeftA)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "B",
                      value: EnumClinicPedoTooth.LowerLeftB.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.LowerLeftB)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "C",
                      value: EnumClinicPedoTooth.LowerLeftC.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.LowerLeftC)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "D",
                      value: EnumClinicPedoTooth.LowerLeftD.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.LowerLeftD)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "E",
                      value: EnumClinicPedoTooth.LowerLeftE.name,
                      isSelected: widget.selectedTeeth!.contains(EnumClinicPedoTooth.LowerLeftE)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
