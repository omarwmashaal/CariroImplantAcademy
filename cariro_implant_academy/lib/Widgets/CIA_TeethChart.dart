import 'package:flutter/cupertino.dart';

import 'MultiSelectChipWidget.dart';

class CIA_TeethChart extends StatefulWidget {
  CIA_TeethChart({Key? key, this.onChange}) : super(key: key);

  Function(List<int> selectedTeethList)? onChange;
  @override
  State<CIA_TeethChart> createState() => _CIA_TeethChartState();
}

class _CIA_TeethChartState extends State<CIA_TeethChart> {
  List<int> selectedTeeth = <int>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CIA_MultiSelectChipWidget(
                key: GlobalKey(),
                onChange: (item, isSelected) {
                  if(isSelected)
                    selectedTeeth.add(int.parse(item));
                  else
                    selectedTeeth.remove(int.parse(item));
                  if(widget.onChange!=null) widget.onChange!(selectedTeeth);
                },
                labels: [
                  CIA_MultiSelectChipWidgeModel(
                    label: "11",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "12",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "13",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "14",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "15",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "16",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "17",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "18",
                  )
                ],
              ),
            ),
            Expanded(
              child: CIA_MultiSelectChipWidget(
                key: GlobalKey(),
                onChange: (item, isSelected) {
                  if(isSelected)
                    selectedTeeth.add(int.parse(item));
                  else
                    selectedTeeth.remove(int.parse(item));
                  if(widget.onChange!=null) widget.onChange!(selectedTeeth);
                },
                labels: [
                  CIA_MultiSelectChipWidgeModel(
                    label: "21",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "22",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "23",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "24",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "25",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "26",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "27",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "28",
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height:5),
        Row(
          children: [
            Expanded(
              child: CIA_MultiSelectChipWidget(
                key: GlobalKey(),
                onChange: (item, isSelected) {
                  if(isSelected)
                    selectedTeeth.add(int.parse(item));
                  else
                    selectedTeeth.remove(int.parse(item));
                  if(widget.onChange!=null) widget.onChange!(selectedTeeth);
                },
                labels: [
                  CIA_MultiSelectChipWidgeModel(
                    label: "31",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "32",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "33",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "34",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "35",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "36",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "37",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "38",
                  )
                ],
              ),
            ),
            SizedBox(),
            Expanded(
              child: CIA_MultiSelectChipWidget(
                key: GlobalKey(),
                onChange: (item, isSelected) {
                  if(isSelected)
                    selectedTeeth.add(int.parse(item));
                  else
                    selectedTeeth.remove(int.parse(item));
                  if(widget.onChange!=null) widget.onChange!(selectedTeeth);
                },
                labels: [
                  CIA_MultiSelectChipWidgeModel(
                    label: "41",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "42",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "43",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "44",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "45",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "46",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "47",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "48",
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
