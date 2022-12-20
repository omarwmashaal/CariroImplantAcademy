import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CIA_SecondaryButton extends StatefulWidget {
  CIA_SecondaryButton({Key? key, required this.label, required this.onTab}) : super(key: key);
  String label;
  Function onTab;

  @override
  State<CIA_SecondaryButton> createState() => _CIA_SecondaryButton();
}

class _CIA_SecondaryButton extends State<CIA_SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 30,
      child: Expanded(
        child: ElevatedButton(
          onPressed: () {
            widget.onTab();
          },


          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color_Background),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Color_TextFieldBorder)
                )
            )

          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: Color_TextPrimary,
              fontSize: 15 ,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}
