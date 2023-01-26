import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalRadioButtons extends StatefulWidget {
  HorizontalRadioButtons(
      {Key? key,
      required this.names,
      this.onChange,
      this.selectionColor,
      this.groupValue = ""})
      : super(key: key);
  List<String> names;
  Function? onChange;
  Color? selectionColor;
  String groupValue;

  @override
  State<HorizontalRadioButtons> createState() => _HorizontalRadioButtonsState();
}

class _HorizontalRadioButtonsState extends State<HorizontalRadioButtons> {
  @override
  Widget build(BuildContext context) {
    List<Widget> btns = <Widget>[];
    int i = 0;
    for (String name in widget.names) {
      btns.add(Expanded(
        child: Row(
          children: [
            Radio(
                activeColor: widget.selectionColor == null
                    ? Color_Accent
                    : widget.selectionColor,
                visualDensity: VisualDensity.compact,
                value: name,
                groupValue: widget.groupValue,
                onChanged: (index) {
                  setState(() {
                    widget.groupValue = index as String;

                    if (widget.onChange != null) widget.onChange!(index);
                  });
                }),
            Expanded(
              child: Text(name, maxLines: 2),
            )
          ],
        ),
        flex: 1,
      ));
      i++;
    }
    return Row(children: btns);
  }
}
