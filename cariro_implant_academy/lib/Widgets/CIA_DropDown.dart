import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/Colors.dart';

class CIA_DropDown extends StatefulWidget {
  CIA_DropDown(
      {Key? key,
      this.onSelect,
      required this.label,
      this.selectedValue,
      required this.values})
      : super(key: key);

  String label;
  List<String> values;
  Function? onSelect;
  String? selectedValue;
  @override
  State<CIA_DropDown> createState() => _CIA_DropDownState();
}

class _CIA_DropDownState extends State<CIA_DropDown> {
  FocusNode focus = FocusNode();

  @override
  void initState() {
    focus.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextDropdownFormField(
      controller: DropdownEditingController(
          value: widget.selectedValue == null ? "" : widget.selectedValue),
      onChanged: (dynamic value) {
        if (widget.onSelect != null) {
          widget.onSelect!(value);
        }
      },
      options: widget.values,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.arrow_drop_down),
        suffixIconColor: focus.hasFocus ? Color_Accent : Color_TextFieldBorder,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color_TextFieldBorder, width: 0.0),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color_Accent),
          borderRadius: BorderRadius.circular(8),
        ),
        floatingLabelStyle: TextStyle(
            color: focus.hasFocus ? Color_Accent : Color(0xff000000),
            fontWeight: FontWeight.bold),
        filled: true,
        labelText: widget.label,
        fillColor: Color_Background,
        isDense: true,
      ),
      dropdownHeight: 120,
    );
  }
}
