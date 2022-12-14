import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:flutter/cupertino.dart';

class PatientsSearchPage extends StatefulWidget {
  const PatientsSearchPage({Key? key}) : super(key: key);

  @override
  State<PatientsSearchPage> createState() => _PatientsSearchPageState();
}

class _PatientsSearchPageState extends State<PatientsSearchPage> {
  @override
  Widget build(BuildContext context) {
    return SearchLayout();
  }
}
