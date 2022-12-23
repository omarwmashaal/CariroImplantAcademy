import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

import '../Constants/Colors.dart';

class CIA_MultiSelectChipWidget extends StatelessWidget {
  CIA_MultiSelectChipWidget(
      {Key? key, required this.labels, this.redFlags = false, this.onChange})
      : super(key: key);

  List<String> labels;
  bool redFlags;
  Function? onChange;
  @override
  Widget build(BuildContext context) {
    return MultiSelectContainer(
      listViewSettings: ListViewSettings(scrollDirection: Axis.horizontal),
      itemsDecoration: MultiSelectDecorations(
        decoration: BoxDecoration(
          border: Border.all(color: Color_TextFieldBorder),
          borderRadius: BorderRadius.circular(20),
        ),
        selectedDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border:
                Border.all(color: redFlags ? Colors.red : Color_AccentGreen),
            color: redFlags ? Colors.red : Color_AccentGreen),
      ),
      items: _buildItems(),
      onChange: (List<Object?> selectedItems, Object? selectedItem) {
        if (onChange != null) onChange!(selectedItems, selectedItem);
      },
    );
  }

  List<MultiSelectCard> _buildItems() {
    List<MultiSelectCard> returnValue = <MultiSelectCard>[];
    for (String label in labels) {
      returnValue.add(MultiSelectCard(
        value: label,
        label: label,
      ));
    }
    return returnValue;
  }
}
