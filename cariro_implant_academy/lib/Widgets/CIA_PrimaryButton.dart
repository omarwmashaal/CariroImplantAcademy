import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CIA_PrimaryButton extends StatelessWidget {
  CIA_PrimaryButton(
      {Key? key,
      this.isLong = false,
      this.width = 120,
      this.color,
      this.icon,
      required this.label,
      required this.onTab})
      : super(key: key);
  String label;
  Function onTab;
  bool? isLong;
  double? width;
  Color? color;
  Icon? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: isLong! ? 30 : 40,
      child: ElevatedButton(
        onPressed: () {
          onTab();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                color != null ? color as Color : Color_Accent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            )),
        child: Row(
          children: [
            icon != null ? icon! : Container(),
            Expanded(
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
