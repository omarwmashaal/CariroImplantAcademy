import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/Clinic_DoctorModel.dart';
import '../../Widgets/Title.dart';
import 'Clinic_ViewDoctorPage.dart';

class Clinic_DoctorsSearchPage extends StatefulWidget {
  const Clinic_DoctorsSearchPage({Key? key}) : super(key: key);

  @override
  State<Clinic_DoctorsSearchPage> createState() =>
      _Clinic_DoctorsSearchPageState();
}

class _Clinic_DoctorsSearchPageState extends State<Clinic_DoctorsSearchPage> {
  DoctorDataSource dataSource = DoctorDataSource();
  Clinic_DoctorModel selectedDoctor = Clinic_DoctorModel(1, "Name", "Phone",
      "Gender", "DateOfBirth", "GraduatedFrom", "ClassYear", "Speciality");

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: internalPagesController,
      children: [
        Column(
          children: [
            Expanded(child: SizedBox()),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TitleWidget(
                title: "Doctors Data",
              ),
            )),
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SearchLayout(
                  radioButtons: [
                    "ID",
                    "Name",
                    "Phone",
                    "Operation",
                  ],
                  loadMoreFuntcion: dataSource.addMoreRows,
                  dataSource: dataSource,
                  columnNames: Clinic_DoctorModel.columns,
                  onCellTab: (value) {
                    print(dataSource.models[value - 1].ID);
                    setState(() {
                      selectedDoctor = dataSource.models[value - 1];
                    });
                    internalPagesController.jumpToPage(1);
                  },
                ),
              ),
            )
          ],
        ),
        Clinic_ViewDoctorPage(
          doctor: selectedDoctor,
        )
      ],
    );
  }
}
