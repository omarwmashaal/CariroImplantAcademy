import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Constants/Colors.dart';

class CIA_TextFormField extends StatefulWidget {
  CIA_TextFormField({
    Key? key,
    required this.label,
    this.isObscure,
    this.onChange = null,
    this.onInstantChange = null,
    this.icon,
    this.isNumber = false,
    this.isMinutes = false,
    this.isHours = false,
    this.maxLines = 1,
    this.borderColor,
    this.enabled = true,
    this.suffix,
    this.borderColorOnChange,
    this.changeColorIfFilled = false,
    this.onTap,
    required this.controller,
  }) : super(key: key);

  int maxLines;
  bool isHours;
  bool isMinutes;
  bool? isObscure = false;
  String label;
  Function(String value)? onChange;
  Function? onInstantChange;
  Function? onTap;
  IconData? icon;
  Color? borderColor;
  TextEditingController controller;
  bool isNumber;
  String? suffix;
  bool changeColorIfFilled;
  Color? borderColorOnChange;
  bool enabled;

  @override
  State<CIA_TextFormField> createState() => _CIA_TextFormFieldState();
}

class _CIA_TextFormFieldState extends State<CIA_TextFormField> {
  FocusNode focus = FocusNode();

  @override
  void initState() {
    focus.addListener(() {
      if (!focus.hasFocus) {
        if (widget.onChange != null) {
          widget.onChange!(widget.controller.text);
        }
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.text != null)
      widget.controller.selection = TextSelection(baseOffset: widget.controller.text.length, extentOffset: widget.controller.text.length);

    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Color_Accent,
            ),
      ),
      child: GestureDetector(
        onTap: () {
          if (widget.onTap != null) widget.onTap!();
        },
        child: TextFormField(
          enabled: widget.enabled,
          onTap: () {
            if (widget.onTap != null) widget.onTap!();
          },
          onChanged: (value) {
            if (widget.onInstantChange != null) widget.onInstantChange!(value);
            if (widget.onChange != null) widget.onChange!(value);
          },
          autovalidateMode: widget.isMinutes || widget.isHours ? AutovalidateMode.onUserInteraction : null,
          validator: (value) {
            if (widget.isHours) {
              if (value != null && value.isNotEmpty) {
                if (int.parse(value!) > 12) {
                  widget.controller.text = 12.toString();
                }
              }
            } else if (widget.isMinutes) {
              if (value != null && value.isNotEmpty) {
                if (int.parse(value!) > 59) {
                  widget.controller.text = 59.toString();
                }
              }
            }
          },
          inputFormatters: widget.isHours || widget.isMinutes || widget.isNumber
              ? [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ]
              : null,
          cursorColor: Color_Accent,
          maxLines: widget.maxLines,
          focusNode: focus,
          controller: widget.controller,
          textInputAction: TextInputAction.next,
          obscureText: widget.isObscure == null ? false : true,
          decoration: InputDecoration(
            suffixText: widget.suffix,
            prefixIcon: widget.icon != null ? Icon(Icons.search) : null,
            prefixIconColor: focus.hasFocus ? Colors.red : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.changeColorIfFilled && widget.controller.text != "" && widget.borderColorOnChange != null
                      ? widget.borderColorOnChange!
                      : widget.borderColor == null
                          ? Color_TextFieldBorder
                          : widget.borderColor!,
                  width: 0.0),
              borderRadius: BorderRadius.circular(8),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.changeColorIfFilled && widget.controller.text != "" && widget.borderColorOnChange != null
                      ? widget.borderColorOnChange!
                      : widget.borderColor == null
                          ? Color_TextFieldBorder
                          : widget.borderColor!,
                  width: 0.0),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color_Accent),
              borderRadius: BorderRadius.circular(8),
            ),
            floatingLabelStyle: TextStyle(color: focus.hasFocus ? Color_Accent : Color(0xff000000), fontWeight: FontWeight.bold),
            filled: true,
            labelText: widget.label,
            fillColor: Color_Background,
            isDense: true,
          ),
        ),
      ),
    );
  }
}
