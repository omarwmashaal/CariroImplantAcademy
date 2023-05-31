import 'package:flutter/cupertino.dart';

import '../Constants/Controllers.dart';
import 'CIA_SecondaryButton.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: CIA_SecondaryButton(
          label: "View more info",
          onTab: () {
            internalPagesController.jumpToPage(2);
          }),
    );
  }
}
