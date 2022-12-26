import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

CIA_PopupDialog(BuildContext context, Widget widget) async {
  Alert(
    context: context,
    title: "LOGIN",
    content: widget,
    buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          "LOGIN",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      DialogButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          "LOGIN",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ],
  ).show();
}
