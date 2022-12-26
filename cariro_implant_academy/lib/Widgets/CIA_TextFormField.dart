import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/Colors.dart';

class CIA_TextFormField extends StatefulWidget {
  CIA_TextFormField({
    Key? key,
    required this.label,
    this.isObscure,
    this.onChange,
    this.icon,
    this.maxLines = 1,
    required this.controller,
  }) : super(key: key);

  int maxLines;
  bool? isObscure = false;
  String label;
  Function? onChange;
  IconData? icon;
  TextEditingController controller;

  @override
  State<CIA_TextFormField> createState() => _CIA_TextFormFieldState();
}

class _CIA_TextFormFieldState extends State<CIA_TextFormField> {
  FocusNode focus = FocusNode();

  @override
  void initState() {
    focus.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Color_AccentGreen,
            ),
      ),
      child: TextFormField(
        cursorColor: Color_AccentGreen,
        maxLines: widget.maxLines,
        focusNode: focus,
        controller: widget.controller,
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          if (widget.onChange != null) widget.onChange!(value);
          print(focus.hasFocus);
        },
        obscureText: widget.isObscure == null ? false : true,
        decoration: InputDecoration(
          prefixIcon: widget.icon != null ? Icon(Icons.search) : null,
          prefixIconColor: focus.hasFocus ? Colors.red : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color_TextFieldBorder, width: 0.0),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color_AccentGreen),
            borderRadius: BorderRadius.circular(8),
          ),
          floatingLabelStyle: TextStyle(
              color: focus.hasFocus ? Color_AccentGreen : Color(0xff000000),
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
