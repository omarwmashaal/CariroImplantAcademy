import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CIA_PrimaryButton extends StatelessWidget {
  CIA_PrimaryButton({Key? key, this.isLong = false, this.width = 120, this.height, this.color, this.icon, required this.label, required this.onTab})
      : super(key: key);
  String label;
  Function onTab;
  double? height;
  bool? isLong;
  double? width;
  Color? color;
  Icon? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? (isLong! ? 30 : 40),
      child: ElevatedButton(
        onPressed: () {
          onTab();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color != null ? color as Color : Color_Accent),
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
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: Inter_SemiBold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
