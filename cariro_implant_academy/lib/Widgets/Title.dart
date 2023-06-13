import 'dart:js';

import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Constants/Fonts.dart';

class TitleWidget extends StatelessWidget {
  TitleWidget({Key? key, required this.title, this.mainPages = false, this.showBackButton = false})
      : super(key: key);

  String title;
  bool showBackButton = false;
  bool mainPages= false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: false,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);

              },
              icon: Icon(Icons.arrow_back)),
        ),
        Text(
          title,
          style: TextStyle(fontFamily: Inter_ExtraBold, fontSize: 30),
        ),
      ],
    );
  }


}
