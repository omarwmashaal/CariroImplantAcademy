import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FormTextWidget extends StatelessWidget {
  FormTextWidget({Key? key, required this.keyText, required this.valueText}) : super(key: key);
  String keyText;
  String valueText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: FormTextKeyWidget(text: keyText)),
        Expanded(
            child: SizedBox(
          width: 10,
        )),
        Expanded(child: FormTextValueWidget(text: valueText)),
      ],
    );
  }
}

class FormTextKeyWidget extends StatelessWidget {
  FormTextKeyWidget({Key? key, this.smallFont = false, required this.text, this.color, this.secondaryInfo = false}) : super(key: key);
  String text;
  bool secondaryInfo;
  Color? color;
  bool smallFont;

  @override
  Widget build(BuildContext context) {
    double fontSize = smallFont ? 10 : 14;
    return Text(
      text,
      style: secondaryInfo
          ? TextStyle(fontSize: fontSize, fontFamily: Inter_Bold, color: Color_TextSecondary)
          : TextStyle(fontSize: fontSize, fontFamily: Inter_Bold, color: color ?? Colors.black),
    );
  }
}

class FormTextValueWidget extends StatelessWidget {
  FormTextValueWidget({
    Key? key,
    this.color,
    this.text = "",
    this.align = TextAlign.start,
    this.secondaryInfo = false,
    this.suffix,
    this.smallFont = false,
    this.isLink = false,
  }) : super(key: key);
  String? text;
  bool secondaryInfo;
  String? suffix;
  bool smallFont;
  TextAlign align;
  Color? color;
  bool isLink;

  @override
  Widget build(BuildContext context) {
    try {
      isLink = (text ?? "").contains("http://");
    } catch (e) {}
    color = isLink ? Colors.blueAccent : color;
    double fontSize = smallFont ? 10 : 14;
    Widget widget = Text(
      "${text ?? ""} " + (suffix != null ? (suffix as String) : ""),
      textAlign: align,
      style: secondaryInfo
          ? TextStyle(
              fontSize: fontSize,
              fontFamily: Inter_Regular,
              color: color ?? Color_TextSecondary,
              decoration: isLink ? TextDecoration.underline : null)
          : TextStyle(
              fontSize: fontSize, fontFamily: Inter_Regular, color: color ?? Colors.black, decoration: isLink ? TextDecoration.underline : null),
    );
    return isLink && text != null
        ? InkWell(
            onTap: () => isLink && text != null ? launchUrl(Uri.parse(text!)) : null,
            child: widget,
          )
        : widget;
  }
}
