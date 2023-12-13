import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/CIA_GestureWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CIA_CheckBoxWidget extends StatefulWidget {
  CIA_CheckBoxWidget({Key? key, required this.text, this.onChange,this.value =false}) : super(key: key);
  String text;
  Function(bool value)? onChange;
  bool value;
  @override
  State<CIA_CheckBoxWidget> createState() => _CIA_CheckBoxWidgetState();
}

class _CIA_CheckBoxWidgetState extends State<CIA_CheckBoxWidget> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value:widget.value,
          onChanged: (value) => setState(() {
            widget.value = value!;
            if(widget.onChange!=null)widget.onChange!(value);
          }),
          activeColor: Color_Accent,
        ),
        CIA_GestureWidget(
            onTap: () => setState(() {
              widget.value = !widget.value;
                  if(widget.onChange!=null)widget.onChange!(widget.value);
                }),
            child: FormTextValueWidget(text: widget.text))
      ],
    );
  }
}
