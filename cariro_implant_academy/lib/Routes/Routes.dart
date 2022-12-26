import 'package:cariro_implant_academy/Pages/CIA_Pages/PatientsSearchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/Controllers.dart';
import '../Pages/CIA_Pages/Assistants_SearchPage.dart';
import '../Pages/CIA_Pages/Candidates_SearchPage.dart';
import '../Pages/CIA_Pages/CashFlowMainPage.dart';
import '../Pages/CIA_Pages/Instructors_SearchPage.dart';

const String LoginPageRoute = "LoginPageRoute";
const String RegisterPageRoute = "RegisterPageRoute";

PageView MainPageRoutes() {
  return PageView(
    physics: NeverScrollableScrollPhysics(),
    controller: pagesController,
    children: [
      Container(
        child: PatientsSearchPage(),
      ),
      Container(
        child: const Center(
          child: AssistantsSearchPage(),
        ),
      ),
      Container(
        child: const Center(child: InstructorsSearchPage()),
      ),
      Container(child: CandidatesSearchPage()),
      Container(
        child: const Center(
          child: Text(
            'Operations',
            style: TextStyle(fontSize: 35),
          ),
        ),
      ),
      Container(
        child: const Center(
          child: Text(
            'Stock',
            style: TextStyle(fontSize: 35),
          ),
        ),
      ),
      Container(
        child: CashFlowMainPage(),
      ),
    ],
  );
}
