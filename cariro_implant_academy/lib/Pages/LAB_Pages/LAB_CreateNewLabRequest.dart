import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/Title.dart';
import '../SharedPages/LapRequestSharedPage.dart';

class LAB_CreateNewLabRequest extends StatelessWidget {
  const LAB_CreateNewLabRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Expanded(child: SizedBox()),
          TitleWidget(
            title: "Create New Request",
            showBackButton: true,
          ),
          SizedBox(width: 10),
          Expanded(flex:10,child: LapRequestSharedPage()),
        ],
      ),
    );
  }
}
