import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../Constants/Colors.dart';

class CIA_TextFormField extends StatefulWidget {
  CIA_TextFormField(
      {Key? key,
      required this.label,
      this.isObscure,
      this.onChange = null,
      this.onInstantChange = null,
      this.icon,
      this.isNumber = false,
      this.isMinutes = false,
      this.isHours = false,
      this.maxLines = 1,
      this.isPhoneNumber = false,
      this.borderColor,
      this.enabled = true,
      this.suffix,
      this.borderColorOnChange,
      this.changeColorIfFilled = false,
      this.onTap,
      this.onSubmit,
      this.inputFormatter,
      required this.controller,
      this.errorFunction,
      this.textInputType,
      this.validator})
      : super(key: key);

  int maxLines;
  TextInputType? textInputType;
  bool isHours;
  bool isMinutes;
  bool? isObscure = false;
  String label;
  Function(String value)? onChange;
  Function? onInstantChange;
  Function? onTap;
  Function(String value)? onSubmit;
  IconData? icon;
  Color? borderColor;
  TextEditingController controller;
  bool isNumber;
  bool isPhoneNumber;
  String? suffix;
  bool changeColorIfFilled;
  Color? borderColorOnChange;
  bool enabled;
  List<TextInputFormatter>? inputFormatter;
  String Function(String value)? validator;
  bool Function(String value)? errorFunction;

  @override
  State<CIA_TextFormField> createState() => _CIA_TextFormFieldState();
}

class _CIA_TextFormFieldState extends State<CIA_TextFormField> {
  FocusNode focus = FocusNode();
  bool error = false;

  @override
  void initState() {
    focus.addListener(() {
      if (!focus.hasFocus) {
        if (widget.onChange != null) {
          widget.onChange!(widget.controller.text);
        }
      }
      if (widget.errorFunction != null) {
        error = widget.errorFunction!(widget.controller.text ?? "");
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.errorFunction != null) {
      error = widget.errorFunction!(widget.controller.text ?? "");
    }
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
          keyboardType: widget.textInputType,
          onFieldSubmitted: (value) {
            if (widget.onSubmit != null) widget.onSubmit!(value);
          },
          enabled: widget.enabled,
          onTap: () {
            if (widget.onTap != null) widget.onTap!();
          },
          onChanged: (value) {
            if (widget.isNumber && value == "" || value == null) {
              value = "0";
              setState(() {
                widget.controller.text = "0";
              });
            }
            if (widget.isNumber && !widget.isPhoneNumber) {
              if (value.length > 1 && value.startsWith("0")) value = value.replaceFirst(RegExp(r'0'), "");
              setState(() {
                widget.controller.text = value;
              });
            }
            if (widget.onInstantChange != null) widget.onInstantChange!(value);
            if (widget.onChange != null) widget.onChange!(value);
            if (widget.errorFunction != null) {
              var t = widget.errorFunction!(value);
              if (t != error)
                setState(() {
                  error = t;
                });
            }
          },
          autovalidateMode: widget.isMinutes || widget.isHours || widget.validator != null ? AutovalidateMode.onUserInteraction : null,
          validator: (value) {
            if (widget.isNumber && value == "" || value == null) value = "0";
            if (widget.validator != null)
              widget.controller.text = widget.validator!(value ?? "");
            else {
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
            }
            widget.controller.selection = TextSelection(baseOffset: widget.controller.text.length, extentOffset: widget.controller.text.length);
          },
          inputFormatters: widget.inputFormatter != null
              ? widget.inputFormatter!
              : (widget.isHours || widget.isMinutes || widget.isNumber || widget.isPhoneNumber
                  ? [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    ]
                  : null),
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
                  color: error
                      ? Colors.red
                      : widget.changeColorIfFilled && widget.controller.text != "" && widget.borderColorOnChange != null
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

class CIA_DateTimeTextFormField extends StatefulWidget {
  CIA_DateTimeTextFormField(
      {Key? key,
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
      this.inputFormatter,
      required this.controller,
      this.validator})
      : super(key: key);

  int maxLines;
  bool isHours;
  bool isMinutes;
  bool? isObscure = false;
  String label;
  Function(DateTime value)? onChange;
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
  List<TextInputFormatter>? inputFormatter;
  String Function(String value)? validator;

  @override
  State<CIA_DateTimeTextFormField> createState() => _CIA_DateTimeTextFormFieldState();
}

class _CIA_DateTimeTextFormFieldState extends State<CIA_DateTimeTextFormField> {
  FocusNode focus = FocusNode();

  bool error = false;

  @override
  void initState() {
    dialogHelper.increaseCount();
    focus.addListener(() {
      if (!focus.hasFocus) {
        if (widget.onChange != null) {
          widget.onChange!(DateTime.tryParse(widget.controller.text??"")!)?.toLocal();
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
          CIA_PopupDialog_DateOnlyPicker(context, "Pick Date", (value) {
            if (widget.onChange != null) {
              widget.onChange!(value!);
              widget.controller.text = DateFormat("dd-MM-yyyy").format(value!);
            }
            setState(() {});
          });
        },
        child: TextFormField(
          enabled: false,
          onTap: () {
            CIA_PopupDialog_DateOnlyPicker(context, "Pick Date", (value) {
              if (widget.onChange != null) {
                widget.onChange!(value!);
                widget.controller.text = DateFormat("dd-MM-yyyy").format(value!);
              }
              setState(() {});
            });
          },
          onChanged: (value) {
           // if (widget.onInstantChange != null) widget.onInstantChange!(value);
           // if (widget.onChange != null) widget.onChange!(value);
          },
          autovalidateMode: widget.isMinutes || widget.isHours || widget.validator != null ? AutovalidateMode.onUserInteraction : null,
          validator: (value) {
            if (widget.validator != null)
              widget.controller.text = widget.validator!(value ?? "");
            else {
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
            }
            widget.controller.selection = TextSelection(baseOffset: widget.controller.text.length, extentOffset: widget.controller.text.length);
          },
          inputFormatters: widget.inputFormatter != null
              ? widget.inputFormatter!
              : (widget.isHours || widget.isMinutes || widget.isNumber
                  ? [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    ]
                  : null),
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
