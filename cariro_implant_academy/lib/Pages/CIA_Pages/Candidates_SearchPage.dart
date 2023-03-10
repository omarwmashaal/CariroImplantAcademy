import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Candidate_ViewCandidatePage.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CandidateInfo.dart';
import '../../Widgets/Title.dart';

class CandidatesSearchPage extends StatefulWidget {
  const CandidatesSearchPage({Key? key}) : super(key: key);

  @override
  State<CandidatesSearchPage> createState() => _CandidatesSearchPageState();
}

class _CandidatesSearchPageState extends State<CandidatesSearchPage> {
  CandidateDataSource dataSource = CandidateDataSource();
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: internalPagesController,
      children: [
        Column(
          children: [
            TitleWidget(
              title: "Candidates Data",
            ),
            Expanded(
              child: SearchLayout(
                radioButtons: [
                  "Name",
                  "Phone",
                  "ID",
                  "Instructor",
                  "Candidate",
                  "Candidate",
                  "Operation",
                ],
                loadMoreFuntcion: dataSource.addMoreRows,
                dataSource: dataSource,
                columnNames: CandidateInfoModel.columns,
                onCellTab: (value) {
                  print(dataSource.models[value - 1].ID);
                  internalPagesController
                      .setPassedObject(dataSource.models[value - 1]);
                  internalPagesController.jumpToPage(1);
                },
              ),
            ),
          ],
        ),
        ViewCandidatePage()
      ],
    );
  }

  @override
  void initState() {
    siteController.setAppBarWidget();
  }
}
