import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BigErrorPageWidget extends StatelessWidget {
  BigErrorPageWidget({Key? key,required this.message,this.fontSize=100}) : super(key: key);
  final String message;
  double fontSize;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: fontSize,
            color: Colors.grey
        ),
      ),
    );
  }
}
