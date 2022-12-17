import 'package:cariro_implant_academy/Pages/CIA_Pages/PatientsSearchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/Colors.dart';
import '../Constants/Controllers.dart';
import '../Pages/CIA_Pages/CashFlowMainPage.dart';

const String LoginPageRoute = "LoginPageRoute";
const String RegisterPageRoute = "RegisterPageRoute";


PageView MainPageRoutes()
{

  return PageView(
    physics: NeverScrollableScrollPhysics(),
    controller: pagesController,
    children: [
      Container(
        child: PatientsSearchPage(),
      ),
      Container(
        color: Color_Background,
        child: const Center(
          child: Text(
            'Assistants',
            style: TextStyle(fontSize: 35),
          ),
        ),
      ),
      Container(
        color: Color_Background,
        child: const Center(
          child: Text(
            'Instructors',
            style: TextStyle(fontSize: 35),
          ),
        ),
      ),
      Container(
        color: Color_Background,
        child: const Center(
          child: Text(
            'Candidates',
            style: TextStyle(fontSize: 35),
          ),
        ),
      ),
      Container(
        color: Color_Background,
        child: const Center(
          child: Text(
            'Operations',
            style: TextStyle(fontSize: 35),
          ),
        ),
      ),
      Container(
        color: Color_Background,
        child: const Center(
          child: Text(
            'Stock',
            style: TextStyle(fontSize: 35),
          ),
        ),
      ),
      Container(
        color: Color_Background,
        child: CashFlowMainPage(),
      ),

    ],
  );
}