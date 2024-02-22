import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Widgets/FormTextWidget.dart';

class AdvancedSearchFilterChildWidget extends StatelessWidget {
  AdvancedSearchFilterChildWidget({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);
  String title;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormTextKeyWidget(text: title),
        SizedBox(height: 10),
        child,
        Divider(),
        SizedBox(height: 10),
      ],
    );
  }
}
