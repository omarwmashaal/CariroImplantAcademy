import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

import '../Constants/Colors.dart';

class CIA_MultiSelectChipWidget extends StatelessWidget {
  CIA_MultiSelectChipWidget(
      {Key? key,
      required this.labels,
      this.redFlags = false,
      this.onChange,
      this.onChangeSpecificTooth,
      this.singleSelect = false})
      : super(key: key);

  Object labels;
  bool redFlags;
  Function? onChange;
  Function? onChangeSpecificTooth;
  bool singleSelect;

  @override
  Widget build(BuildContext context) {
    return MultiSelectContainer(
      singleSelectedItem: singleSelect,
      listViewSettings: ListViewSettings(scrollDirection: Axis.horizontal),
      itemsDecoration: MultiSelectDecorations(
        decoration: BoxDecoration(
          border: Border.all(color: Color_TextFieldBorder),
          borderRadius: BorderRadius.circular(20),
        ),
        selectedDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: redFlags ? Colors.red : Color_Accent),
            color: redFlags ? Colors.red : Color_Accent),
      ),
      items: _buildItems(),
      onChange: (List<Object?> selectedItems, Object? selectedItem) {
        bool isSelected = selectedItems.contains(selectedItem);
        if (onChange != null) onChange!(selectedItem as String, isSelected);
        if (onChangeSpecificTooth != null)
          onChangeSpecificTooth!(selectedItem as String, isSelected, key);
      },
    );
  }

  List<MultiSelectCard> _buildItems() {
    List<MultiSelectCard> returnValue = <MultiSelectCard>[];
    if (labels is List<String>) {
      for (String label in labels as List<String>) {
        returnValue.add(MultiSelectCard(
          value: label,
          label: label,
        ));
      }
    } else if (labels is Map<String, String>) {
      for (String key in (labels as Map<String, String>).keys) {
        returnValue.add(MultiSelectCard(
          value: (labels as Map<String, String>)[key],
          label: key,
        ));
      }
    } else if (labels is Map<String, bool>) {
      for (String key in (labels as Map<String, bool>).keys) {
        returnValue.add(MultiSelectCard(
            value: key,
            label: key,
            selected: (labels as Map<String, bool>)[key] as bool));
      }
    }

    return returnValue;
  }
}
