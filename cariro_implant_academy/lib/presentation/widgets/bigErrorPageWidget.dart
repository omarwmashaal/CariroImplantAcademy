import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BigErrorPageWidget extends StatelessWidget {
  BigErrorPageWidget({Key? key,required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 100,
            color: Colors.grey
        ),
      ),
    );
  }
}
