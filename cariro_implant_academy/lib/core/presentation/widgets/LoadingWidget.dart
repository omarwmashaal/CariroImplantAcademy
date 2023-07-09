import 'package:flutter/cupertino.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../Constants/Colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 200,
        child: LoadingIndicator(
          indicatorType: Indicator.ballClipRotateMultiple,
          colors: [Color_Accent],
        ),
      ),
    );
  }
}
