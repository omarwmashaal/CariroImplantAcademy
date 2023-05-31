import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/Title.dart';
import '../SharedPages/LapRequestSharedPage.dart';

class LAB_CreateNewLabRequest extends StatelessWidget {
  const LAB_CreateNewLabRequest({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        TitleWidget(
          title: "Create New Request",
          showBackButton: true,
        ),
        SizedBox(width: 10),
        Expanded(flex:10,child: LapRequestSharedPage()),
      ],
    );
  }
}
