import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CIA_CheckBoxWidget extends StatefulWidget {
  CIA_CheckBoxWidget({Key? key, required this.text}) : super(key: key);
  String text;
  @override
  State<CIA_CheckBoxWidget> createState() => _CIA_CheckBoxWidgetState();
}

class _CIA_CheckBoxWidgetState extends State<CIA_CheckBoxWidget> {
  bool state = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: state,
          onChanged: (value) => setState(() {
            state = value!;
          }),
          activeColor: Color_Accent,
        ),
        GestureDetector(
            onTap: () => setState(() {
                  state = !state;
                }),
            child: FormTextValueWidget(text: widget.text))
      ],
    );
  }
}
