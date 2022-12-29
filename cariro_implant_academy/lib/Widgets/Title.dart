import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/Fonts.dart';

class TitleWidget extends StatelessWidget {
  TitleWidget({Key? key, required this.title, this.showBackButton = false})
      : super(key: key);

  String title;
  bool showBackButton = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: showBackButton!,
          child: IconButton(
              onPressed: () {
                onWillPop();
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

  bool onWillPop() {
    internalPagesController.goBack();
    return false;
  }
}
