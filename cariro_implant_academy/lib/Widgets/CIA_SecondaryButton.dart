import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CIA_SecondaryButton extends StatefulWidget {
  CIA_SecondaryButton({Key? key, required this.label, required this.onTab, this.width = 120, this.height, this.icon}) : super(key: key);
  String label;
  Function onTab;
  double width;
  double? height;
  Icon? icon;

  @override
  State<CIA_SecondaryButton> createState() => _CIA_SecondaryButton();
}

class _CIA_SecondaryButton extends State<CIA_SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.icon != null)
      widget.icon = Icon(
        widget.icon!.icon,
        color: Colors.black,
      );

    return SizedBox(
      width: widget.width,
      height: widget.height ?? 30,
      child: ElevatedButton(
        onPressed: () {
          widget.onTab();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color_Background),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: BorderSide(color: Color_TextFieldBorder)))),
        child: Row(
          children: [
            widget.icon != null ? widget.icon! : Container(),
            Expanded(
              child: Center(
                child: Text(
                  widget.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color_TextPrimary,
                    fontFamily: Inter_Regular,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
