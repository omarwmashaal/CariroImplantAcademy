import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../Constants/Colors.dart';

class CIA_MedicalPagesWidget extends StatelessWidget {
  CIA_MedicalPagesWidget({Key? key, required this.children}) : super(key: key);
  List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _buildItems(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return snapshot.data;
        } else {
          return Center(
            child: LoadingIndicator(
              indicatorType: Indicator.ballClipRotateMultiple,
              colors: [Color_Accent],
            ),
          );
        }
      },
    );
  }

  _buildItems() async {
    //await Future.delayed(Duration(milliseconds: 500));
    List<Widget> widgets = <Widget>[];
    widgets.add(SizedBox(height: 10));
    for (Widget child in children) {
      widgets.add(child);
      widgets.add(SizedBox(height: 20));
    }
    widgets.add(SizedBox(height: 30));
    return ListView(
      shrinkWrap: false,
      children: [
        FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: widgets,
          ),
        ),
      ],
    );
  }
}
