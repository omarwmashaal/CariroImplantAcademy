import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../Constants/Colors.dart';
import '../core/presentation/widgets/CIA_GestureWidget.dart';

class CIA_TextFormFieldForDateTime extends StatefulWidget {
  CIA_TextFormFieldForDateTime(
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
      this.selectAll = false,
      this.suffix,
      this.borderColorOnChange,
      this.changeColorIfFilled = false,
      this.onTap,
      this.onSubmit,
      this.inputFormatter,
      this.textInputAction = TextInputAction.next,
      required this.controller,
      this.errorFunction,
      this.textInputType,
      this.focusNode,
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
  TextInputAction textInputAction;
  FocusNode? focusNode;
  bool selectAll;

  @override
  State<CIA_TextFormFieldForDateTime> createState() => _CIA_TextFormFieldForDateTimeState();
}

class _CIA_TextFormFieldForDateTimeState extends State<CIA_TextFormFieldForDateTime> {
  bool error = false;

  @override
  void initState() {
    widget.focusNode = widget.focusNode ?? FocusNode();
    widget.focusNode?.addListener(() {
      if (!(widget.focusNode?.hasFocus ?? false)) {
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

    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Color_Accent,
            ),
      ),
      child: CIA_GestureWidget(
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
              if (value.length > 1 && value.startsWith("0") && value[1] != ".") value = value.replaceFirst(RegExp(r'0'), "");
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
          },
          inputFormatters: widget.inputFormatter != null
              ? widget.inputFormatter!
              : (widget.isHours || widget.isMinutes || widget.isNumber || widget.isPhoneNumber
                  ? [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*')),
                    ]
                  : null),
          cursorColor: Color_Accent,
          maxLines: widget.maxLines,
          focusNode: widget.focusNode,
          controller: () {
            if (widget.selectAll)
              return widget.controller..selection = TextSelection(baseOffset: 0, extentOffset: widget.controller.value.text.length);
            else
              return widget.controller;
          }(),
          textInputAction: widget.textInputAction,
          obscureText: widget.isObscure == null ? false : true,
          decoration: InputDecoration(
            suffixText: widget.suffix,
            prefixIcon: widget.icon != null ? Icon(Icons.search) : null,
            prefixIconColor: widget.focusNode?.hasFocus ?? false ? Colors.red : null,
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
            floatingLabelStyle: TextStyle(color: widget.focusNode?.hasFocus ?? false ? Color_Accent : Color(0xff000000), fontWeight: FontWeight.bold),
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
      this.initialDate,
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
  DateTime? initialDate;

  @override
  State<CIA_DateTimeTextFormField> createState() => _CIA_DateTimeTextFormFieldState();
}

class _CIA_DateTimeTextFormFieldState extends State<CIA_DateTimeTextFormField> {
  FocusNode focus = FocusNode();

  bool error = false;

  @override
  void initState() {
    focus.addListener(() {
      if (!focus.hasFocus) {
        if (widget.onChange != null) {
          widget.onChange!(DateTime.tryParse(widget.controller.text ?? "")!)?.toLocal();
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
      child: CIA_GestureWidget(
        onTap: () {
          CIA_PopupDialog_DateOnlyPicker(
            context,
            "Pick Date",
            (value) {
              if (widget.onChange != null) {
                widget.onChange!(value!);
                widget.controller.text = DateFormat("dd-MM-yyyy").format(value!);
              }
              setState(() {});
            },
            initialDate: widget.initialDate,
          );
        },
        child: TextFormField(
          enabled: false,
          onTap: () {
            CIA_PopupDialog_DateOnlyPicker(
              context,
              "Pick Date",
              (value) {
                if (widget.onChange != null) {
                  widget.onChange!(value!);
                  widget.controller.text = DateFormat("dd-MM-yyyy").format(value!);
                }
                setState(() {});
              },
              initialDate: widget.initialDate,
            );
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
      this.selectAll = false,
      this.suffix,
      this.borderColorOnChange,
      this.changeColorIfFilled = false,
      this.onTap,
      this.onSubmit,
      this.inputFormatter,
      this.textInputAction = TextInputAction.next,
      required this.controller,
      this.errorFunction,
      this.textInputType,
      this.focusNode,
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
  TextInputAction textInputAction;
  FocusNode? focusNode;
  bool selectAll;

  @override
  State<CIA_TextFormField> createState() => _CIA_TextFormFieldState();
}

class _CIA_TextFormFieldState extends State<CIA_TextFormField> {
  bool error = false;

  @override
  void initState() {
    widget.focusNode = widget.focusNode ?? FocusNode();
    widget.focusNode?.addListener(() {
      if (!(widget.focusNode?.hasFocus ?? false)) {
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

    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Color_Accent,
            ),
      ),
      child: CIA_GestureWidget(
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
            // if (widget.isNumber && !widget.isPhoneNumber) {
            //   if (value.length > 1 && value.startsWith("0") && value[1] != ".") {
            //     value = value.replaceFirst(RegExp(r'0'), "");

            //     widget.controller.text = value;
            //     widget.controller.selection = TextSelection(baseOffset: value.length + 1, extentOffset: value.length + 1);
            //     setState(() {});
            //   }
            // }
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
            if (widget.validator != null) {
              widget.controller.text = widget.validator!(value ?? "");
              widget.controller.selection = TextSelection.fromPosition(TextPosition(offset: widget.controller.text.length));
            } else {
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
          },
          inputFormatters: widget.inputFormatter != null
              ? widget.inputFormatter!
              : (widget.isHours || widget.isMinutes || widget.isNumber || widget.isPhoneNumber
                  ? [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*')),
                    ]
                  : null),
          cursorColor: Color_Accent,
          maxLines: widget.maxLines,
          focusNode: widget.focusNode,
          controller: () {
            // if (widget.selectAll)
            // return widget.controller..selection = TextSelection(baseOffset: 0, extentOffset: widget.controller.value.text.length);
            // else
            return widget.controller;
          }(),
          textInputAction: widget.textInputAction,
          obscureText: widget.isObscure == null ? false : true,
          decoration: InputDecoration(
            suffixText: widget.suffix,
            prefixIcon: widget.icon != null ? Icon(Icons.search) : null,
            prefixIconColor: widget.focusNode?.hasFocus ?? false ? Colors.red : null,
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
            floatingLabelStyle: TextStyle(color: widget.focusNode?.hasFocus ?? false ? Color_Accent : Color(0xff000000), fontWeight: FontWeight.bold),
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
