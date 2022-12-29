import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Fonts.dart';
import 'package:flutter/cupertino.dart';

class FormTextWidget extends StatelessWidget {
  FormTextWidget({Key? key, required this.keyText, required this.valueText})
      : super(key: key);
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
  FormTextKeyWidget({Key? key, required this.text, this.secondaryInfo = false})
      : super(key: key);
  String text;
  bool secondaryInfo;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: secondaryInfo
          ? TextStyle(
              fontSize: 14, fontFamily: Inter_Bold, color: Color_TextSecondary)
          : TextStyle(fontSize: 14, fontFamily: Inter_Bold),
    );
  }
}

class FormTextValueWidget extends StatelessWidget {
  FormTextValueWidget(
      {Key? key, required this.text, this.secondaryInfo = false, this.suffix})
      : super(key: key);
  String? text;
  bool secondaryInfo;
  String? suffix;

  @override
  Widget build(BuildContext context) {
    return Text(
      (text as String) + " " + (suffix != null ? (suffix as String) : ""),
      style: secondaryInfo
          ? TextStyle(
              fontSize: 14,
              fontFamily: Inter_Regular,
              color: Color_TextSecondary)
          : TextStyle(
              fontSize: 14,
              fontFamily: Inter_Regular,
            ),
    );
  }
}
