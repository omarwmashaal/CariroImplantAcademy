import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/Colors.dart';

class CIA_TextField extends StatefulWidget {
  CIA_TextField(
      {Key? key,
      required this.label,
      this.isObscure,
      this.onChange,
      this.icon,
      this.initialValue})
      : super(key: key);

  bool? isObscure = false;
  String label;
  Function? onChange;
  IconData? icon;
  String? initialValue;

  @override
  State<CIA_TextField> createState() => _CIA_TextFieldState();
}

class _CIA_TextFieldState extends State<CIA_TextField> {
  bool hasFocus = true;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Color_AccentGreen,
            ),
      ),
      child: Focus(
        onFocusChange: (focus) => setState(() {
          hasFocus = focus;
          print(focus);
        }),
        child: TextField(
          onChanged: (value) {
            if (widget.onChange != null) widget.onChange!(value);
          },
          obscureText: widget.isObscure == null ? false : true,
          decoration: InputDecoration(
            prefixIcon: widget.icon != null ? Icon(Icons.search) : null,
            prefixIconColor: hasFocus ? Colors.red : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color_TextFieldBorder, width: 0.0),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color_AccentGreen),
              borderRadius: BorderRadius.circular(8),
            ),
            floatingLabelStyle: TextStyle(
                color: hasFocus ? Color_AccentGreen : Color(0xff000000),
                fontWeight: FontWeight.bold),
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
