import 'package:cariro_implant_academy/Widgets/SiteLayout.dart';
import 'package:flutter/cupertino.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return SiteLayout();
  }
}
