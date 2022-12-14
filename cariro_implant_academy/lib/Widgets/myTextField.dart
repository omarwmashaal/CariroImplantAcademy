import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  MyTextField({this.icon,required this.label, Key? key}) : super(key: key);

  IconData? icon;
  String label;
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          label: Text(widget.label),
          prefixIcon: Icon(widget.icon),
          fillColor: Color(0xfff3f3f3),
          filled: true,
          border: InputBorder.none),
    );
  }
}
