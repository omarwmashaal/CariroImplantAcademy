import 'package:cariro_implant_academy/Pages/CIA_Pages/PatientsSearchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/Controllers.dart';
import '../Models/ApplicationUserModel.dart';
import '../Models/Enum.dart';
import '../Pages/CIA_Pages/Candidates_SearchPage.dart';
import '../Pages/CIA_Pages/CashFlowPage.dart';
import '../Pages/UsersSearchPage.dart';
import '../features/patient/presentation/presentation/patientsSearchPage.dart';
import '../features/user/domain/entities/enum.dart';
import '../features/user/presentation/pages/userSearchPage.dart';

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
        child:  Center(
          child: UserSearchPage(type:UserRoles.Assistant),
        ),
      ),
      Container(
        child:  Center(child: UserSearchPage(type:UserRoles.Instructor)),
      ),
      Container(child: UserSearchPage(type:UserRoles.Candidate)),
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
        child: CashFlowsSearchPage(),
      ),
    ],
  );
}
