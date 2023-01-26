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
    this.icon,
    this.isNumber = false,
    this.isMinutes = false,
    this.isHours = false,
    this.maxLines = 1,
    this.borderColor,
    this.suffix,
    this.borderColorOnChange,
    this.changeColorIfFilled = false,
    required this.controller,
  }) : super(key: key);

  int maxLines;
  bool isHours;
  bool isMinutes;
  bool? isObscure = false;
  String label;
  Function? onChange;
  IconData? icon;
  Color? borderColor;
  TextEditingController controller;
  bool isNumber;
  String? suffix;
  bool changeColorIfFilled;
  Color? borderColorOnChange;

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
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Color_Accent,
            ),
      ),
      child: TextFormField(
        autovalidateMode: widget.isMinutes || widget.isHours
            ? AutovalidateMode.onUserInteraction
            : null,
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
                color: widget.changeColorIfFilled &&
                        widget.controller.text != "" &&
                        widget.borderColorOnChange != null
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
          floatingLabelStyle: TextStyle(
              color: focus.hasFocus ? Color_Accent : Color(0xff000000),
              fontWeight: FontWeight.bold),
          filled: true,
          labelText: widget.label,
          fillColor: Color_Background,
          isDense: true,
        ),
      ),
    );
  }
}
