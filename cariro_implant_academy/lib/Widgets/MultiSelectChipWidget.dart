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
        this.round = true,
        this.isButton = false,
        this.selectedColor});

  String label;
  String? value;
  bool isSelected = false;
  Color? selectedColor = Color_Accent;
  Color? borderColor;
  bool round;
  bool isButton;
}

class CIA_MultiSelectChipWidget extends StatefulWidget {
  CIA_MultiSelectChipWidget(
      {Key? key,
        this.disabled = false,
        required this.labels,
        this.redFlags = false,
        this.onChange,
        this.onChangeList,
        this.verticalList = false,
        this.onChangeSpecificTooth,
        this.singleSelect = false

      })
      : super(key: key);

  List<CIA_MultiSelectChipWidgeModel> labels;
  bool redFlags;
  Function(String item,bool isSelected)? onChange;
  Function(List<String>)? onChangeList;
  Function? onChangeSpecificTooth;
  bool singleSelect;
  bool verticalList;
  bool disabled;

  @override
  State<CIA_MultiSelectChipWidget> createState() => _CIA_MultiSelectChipWidgetState();
}

class _CIA_MultiSelectChipWidgetState extends State<CIA_MultiSelectChipWidget> {
  List<Object?> tempSelectedItems =[];
  @override
  Widget build(BuildContext context) {
    return MultiSelectContainer(
      key: GlobalKey(),
      showInListView: widget.verticalList,
      alignments: MultiSelectAlignments(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start),
      singleSelectedItem: widget.singleSelect,
      textStyles: MultiSelectTextStyles(
        selectedTextStyle: widget.disabled
            ? null
            : TextStyle(
          color: Colors.white,
          fontFamily: Inter_Bold,
        ),
      ),
      listViewSettings: ListViewSettings(
          scrollDirection: widget.verticalList ? Axis.vertical : Axis.horizontal),
      itemsDecoration: MultiSelectDecorations(
        decoration: BoxDecoration(
          border: Border.all(color: Color_TextFieldBorder),
          borderRadius: BorderRadius.circular(20),
        ),
        selectedDecoration: widget.disabled
            ? BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color_TextFieldBorder),
        )
            : BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: widget.redFlags ? Colors.red : Color_Accent),
            color: widget.redFlags ? Colors.red : Color_Accent),
      ),
      items: _buildItems(),
      onChange: (List<Object?> selectedItems, Object? selectedItem) {
        bool isSelected = selectedItems.contains(selectedItem);
        tempSelectedItems = selectedItems;
        if (widget.onChange != null) widget.onChange!(selectedItem as String, isSelected);
        if (widget.onChangeList != null) {
          widget.onChangeList!(selectedItems.map((e) => e as String).toList());
        }
        if (widget.onChangeSpecificTooth != null)
          widget.onChangeSpecificTooth!(selectedItem as String, isSelected, widget.key);
      },
    );
  }

  List<MultiSelectCard> _buildItems() {
    List<MultiSelectCard> returnValue = <MultiSelectCard>[];
    for (CIA_MultiSelectChipWidgeModel label in widget.labels) {
      returnValue.add(MultiSelectCard(
          value: label.value == null ? label.label : label.value,
          label: label.label,
          decorations:  MultiSelectItemDecorations(
            decoration: BoxDecoration(
              border:
              Border.all(color: label.borderColor ?? Color_TextFieldBorder),
              borderRadius: label.round? BorderRadius.circular(20):null,
            ),
            selectedDecoration: label.isButton?BoxDecoration(
              border:
              Border.all(color: label.borderColor ?? Color_TextFieldBorder),
              borderRadius: label.round? BorderRadius.circular(20):null,
            ): widget.disabled
                ? BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: label.borderColor ?? Color_TextFieldBorder),
            )
                : BoxDecoration(
                borderRadius: label.round?BorderRadius.circular(20):null,
                border: Border.all(
                    color: widget.redFlags
                        ? Colors.red
                        : label.selectedColor == null
                        ? Color_Accent
                        : label.selectedColor!),
                color: widget.redFlags
                    ? Colors.red
                    : label.selectedColor == null
                    ? Color_Accent
                    : label.selectedColor!),
          ),
          selected: label.isSelected,
          textStyles: label.isButton?  MultiSelectItemTextStyles(
              selectedTextStyle:TextStyle(color: Colors.black)
          ):MultiSelectItemTextStyles(

          )

      ));
    }

    return returnValue;
  }
}
