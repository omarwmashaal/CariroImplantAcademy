import 'package:flutter/cupertino.dart';

import '../../../../Widgets/MultiSelectChipWidget.dart';

class ClinicTreatmentsChartWidget extends StatefulWidget {
  ClinicTreatmentsChartWidget({Key? key, this.onChange, this.selectedTeeth}) : super(key: key);

  late List<int>? selectedTeeth;
  Function(List<int> selectedTeethList)? onChange;
  @override
  State<ClinicTreatmentsChartWidget> createState() => _ClinicTreatmentsChartWidgetState();
}

class _ClinicTreatmentsChartWidgetState extends State<ClinicTreatmentsChartWidget> {
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
                  CIA_MultiSelectChipWidgeModel(label: "41", isSelected: widget.selectedTeeth!.contains(41)),
                  CIA_MultiSelectChipWidgeModel(label: "42", isSelected: widget.selectedTeeth!.contains(42)),
                  CIA_MultiSelectChipWidgeModel(label: "43", isSelected: widget.selectedTeeth!.contains(43)),
                  CIA_MultiSelectChipWidgeModel(label: "44", isSelected: widget.selectedTeeth!.contains(44)),
                  CIA_MultiSelectChipWidgeModel(label: "45", isSelected: widget.selectedTeeth!.contains(45)),
                  CIA_MultiSelectChipWidgeModel(label: "46", isSelected: widget.selectedTeeth!.contains(46)),
                  CIA_MultiSelectChipWidgeModel(label: "47", isSelected: widget.selectedTeeth!.contains(47)),
                  CIA_MultiSelectChipWidgeModel(label: "48", isSelected: widget.selectedTeeth!.contains(48))
                ],
              ),
            ),
            SizedBox(),
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
                  CIA_MultiSelectChipWidgeModel(label: "38", isSelected: widget.selectedTeeth!.contains(38)),
                  CIA_MultiSelectChipWidgeModel(label: "37", isSelected: widget.selectedTeeth!.contains(37)),
                  CIA_MultiSelectChipWidgeModel(label: "36", isSelected: widget.selectedTeeth!.contains(36)),
                  CIA_MultiSelectChipWidgeModel(label: "35", isSelected: widget.selectedTeeth!.contains(35)),
                  CIA_MultiSelectChipWidgeModel(label: "34", isSelected: widget.selectedTeeth!.contains(34)),
                  CIA_MultiSelectChipWidgeModel(label: "33", isSelected: widget.selectedTeeth!.contains(33)),
                  CIA_MultiSelectChipWidgeModel(label: "32", isSelected: widget.selectedTeeth!.contains(32)),
                  CIA_MultiSelectChipWidgeModel(label: "31", isSelected: widget.selectedTeeth!.contains(31)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
