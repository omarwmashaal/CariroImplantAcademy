import 'package:cariro_implant_academy/Constants/Fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

import '../Constants/Colors.dart';

class CIA_MultiSelectChipWidgeModel {
  CIA_MultiSelectChipWidgeModel(
      {required this.label,
      this.value,
      this.isSelected = false,
      this.borderColor,
      this.selectedColor});

  String label;
  String? value;
  bool isSelected = false;
  Color? selectedColor = Color_Accent;
  Color? borderColor;
}

class CIA_MultiSelectChipWidget extends StatelessWidget {
  CIA_MultiSelectChipWidget(
      {Key? key,
      this.disabled = false,
      required this.labels,
      this.redFlags = false,
      this.onChange,
      this.onChangeList,
      this.verticalList = false,
      this.onChangeSpecificTooth,
      this.singleSelect = false})
      : super(key: key);

  List<CIA_MultiSelectChipWidgeModel> labels;
  bool redFlags;
  Function? onChange;
  Function(List<String>)? onChangeList;
  Function? onChangeSpecificTooth;
  bool singleSelect;
  bool verticalList;
  bool disabled;

  @override
  Widget build(BuildContext context) {
    return MultiSelectContainer(
      showInListView: verticalList,
      alignments: MultiSelectAlignments(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start),
      singleSelectedItem: singleSelect,
      textStyles: MultiSelectTextStyles(
        selectedTextStyle: disabled
            ? null
            : TextStyle(
                color: Colors.white,
                fontFamily: Inter_Bold,
              ),
      ),
      listViewSettings: ListViewSettings(
          scrollDirection: verticalList ? Axis.vertical : Axis.horizontal),
      itemsDecoration: MultiSelectDecorations(
        decoration: BoxDecoration(
          border: Border.all(color: Color_TextFieldBorder),
          borderRadius: BorderRadius.circular(20),
        ),
        selectedDecoration: disabled
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color_TextFieldBorder),
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: redFlags ? Colors.red : Color_Accent),
                color: redFlags ? Colors.red : Color_Accent),
      ),
      items: _buildItems(),
      onChange: (List<Object?> selectedItems, Object? selectedItem) {
        bool isSelected = selectedItems.contains(selectedItem);
        if (onChange != null) onChange!(selectedItem as String, isSelected);
        if (onChangeList != null) {
          onChangeList!(selectedItems.map((e) => e as String).toList());
        }
        if (onChangeSpecificTooth != null)
          onChangeSpecificTooth!(selectedItem as String, isSelected, key);
      },
    );
  }

  List<MultiSelectCard> _buildItems() {
    List<MultiSelectCard> returnValue = <MultiSelectCard>[];
    for (CIA_MultiSelectChipWidgeModel label in labels) {
      returnValue.add(MultiSelectCard(
          value: label.value == null ? label.label : label.value,
          label: label.label,
          decorations: MultiSelectItemDecorations(
            decoration: BoxDecoration(
              border:
                  Border.all(color: label.borderColor ?? Color_TextFieldBorder),
              borderRadius: BorderRadius.circular(20),
            ),
            selectedDecoration: disabled
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: label.borderColor ?? Color_TextFieldBorder),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: redFlags
                            ? Colors.red
                            : label.selectedColor == null
                                ? Color_Accent
                                : label.selectedColor!),
                    color: redFlags
                        ? Colors.red
                        : label.selectedColor == null
                            ? Color_Accent
                            : label.selectedColor!),
          ),
          selected: label.isSelected));
    }

    return returnValue;
  }
}
