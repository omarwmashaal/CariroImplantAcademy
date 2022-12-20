import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CIA_PrimaryButton extends StatefulWidget {
  CIA_PrimaryButton(
      {Key? key, this.isLong = false, required this.label, required this.onTab})
      : super(key: key);
  String label;
  Function onTab;
  bool? isLong;

  @override
  State<CIA_PrimaryButton> createState() => _CIA_PrimaryButtonState();
}

class _CIA_PrimaryButtonState extends State<CIA_PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: widget.isLong! ? 30 : 40,
      child: Expanded(
        child: ElevatedButton(
          onPressed: () {
            widget.onTab();
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color_AccentGreen),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      ),)),
          child: Text(
            widget.label,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
