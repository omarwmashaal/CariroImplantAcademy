import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalRadioButtons extends StatefulWidget {
  HorizontalRadioButtons(
      {Key? key, required this.names, this.onChange, this.selectionColor})
      : super(key: key);
  List<String> names;
  Function? onChange;
  Color? selectionColor;

  @override
  State<HorizontalRadioButtons> createState() => _HorizontalRadioButtonsState();
}

class _HorizontalRadioButtonsState extends State<HorizontalRadioButtons> {
  String _groupValue = "";

  @override
  Widget build(BuildContext context) {
    List<Widget> btns = <Widget>[];
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
                groupValue: _groupValue,
                onChanged: (index) {
                  setState(() {
                    _groupValue = index as String;

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
    }
    return Row(children: btns);
  }
}
