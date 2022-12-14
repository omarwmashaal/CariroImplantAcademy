import 'package:flutter/cupertino.dart';


const int largeScreenSize = 1366;
const int mediumScreenSize = 768;
const int smallScreenSize = 540;

class ResponsiveWidget extends StatelessWidget {
  ResponsiveWidget(
      {Key? key, required this.LargeScreen, required this.SmallScreen})
      : super(key: key);
  Widget SmallScreen;
  Widget LargeScreen;

  static bool isSmallScreen(BuildContext context)=> MediaQuery.of(context).size.width <= smallScreenSize;
  static bool isLargeScreen(BuildContext context)=> MediaQuery.of(context).size.width > smallScreenSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      double _width = constrains.maxWidth;
      if (_width <= smallScreenSize) return SmallScreen;
      else return LargeScreen;
    });
  }
}
