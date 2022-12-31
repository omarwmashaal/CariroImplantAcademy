import 'package:cariro_implant_academy/Widgets/CIA_MultiStateButton.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/PatientInfo.dart';
import '../../Widgets/CIA_DropDown.dart';
import '../../Widgets/MultiSelectChipWidget.dart';
import '../../Widgets/TabsLayout.dart';
import '../PatientSharedPages.dart';

class Clinic_PatientMedicalPage extends StatelessWidget {
  Clinic_PatientMedicalPage({Key? key, required this.patient})
      : super(key: key);

  PatientInfoModel patient;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TabsLayout(
            showBackButton: true,
            weight: 700,
            tabs: ["Patient Data", "Visits Data", "Medical Treatment"],
            pages: [
              PatientInfo_SharedPage(
                patient: patient,
              ),
              PatientVisits_SharedPage(
                patient: patient,
              ),
              _MedicalTreatment(
                patient: patient,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MedicalTreatment extends StatefulWidget {
  _MedicalTreatment({Key? key, required this.patient}) : super(key: key);

  PatientInfoModel patient;

  @override
  State<_MedicalTreatment> createState() => _MedicalTreatmentState();
}

class _MedicalTreatmentState extends State<_MedicalTreatment> {
  _TableRow row = _TableRow();
  List<_TableRow> rows = [];
  String Add = "", Of = "", As = "";

  @override
  Widget build(BuildContext context) {
    row = _TableRow();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CIA_DropDown(
                  label: "Addition",
                  onSelect: (value) {
                    Add = value;
                  },
                  values: [
                    "add",
                    "add",
                    "add",
                    "add",
                    "add",
                    "add",
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: CIA_DropDown(
                  onSelect: (value) => Of = value,
                  label: "Of",
                  values: [
                    "Of",
                    "Of",
                    "Of",
                    "Of",
                    "Of",
                    "Of",
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: CIA_DropDown(
                  onSelect: (value) => As = value,
                  label: "As",
                  values: [
                    "Planned",
                    "In progress",
                    "Completed",
                    "Completed by other",
                    "Condition",
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Row(
                  children: [
                    FormTextKeyWidget(text: "for"),
                    SizedBox(width: 10),
                    FormTextValueWidget(text: widget.patient.Name),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CIA_MultiSelectChipWidget(
                  disabled: true,
                  singleSelect: true,
                  onChange: (selectedValue, isSelected) {
                    _constructRow(selectedValue);

                    setState(() {});
                  },
                  labels: [
                    CIA_MultiSelectChipWidgeModel(label: "11"),
                    CIA_MultiSelectChipWidgeModel(label: "12"),
                    CIA_MultiSelectChipWidgeModel(label: "13"),
                    CIA_MultiSelectChipWidgeModel(label: "14"),
                    CIA_MultiSelectChipWidgeModel(label: "15"),
                    CIA_MultiSelectChipWidgeModel(label: "16"),
                    CIA_MultiSelectChipWidgeModel(label: "17"),
                    CIA_MultiSelectChipWidgeModel(label: "18"),
                    CIA_MultiSelectChipWidgeModel(label: "19")
                  ],
                ),
              ),
              SizedBox(),
              Expanded(
                child: CIA_MultiSelectChipWidget(
                  disabled: true,
                  singleSelect: true,
                  onChange: (selectedValue, isSelected) {
                    _constructRow(selectedValue);

                    setState(() {});
                  },
                  labels: [
                    CIA_MultiSelectChipWidgeModel(label: "21"),
                    CIA_MultiSelectChipWidgeModel(label: "22"),
                    CIA_MultiSelectChipWidgeModel(label: "23"),
                    CIA_MultiSelectChipWidgeModel(label: "24"),
                    CIA_MultiSelectChipWidgeModel(label: "25"),
                    CIA_MultiSelectChipWidgeModel(label: "26"),
                    CIA_MultiSelectChipWidgeModel(label: "27"),
                    CIA_MultiSelectChipWidgeModel(label: "28"),
                    CIA_MultiSelectChipWidgeModel(label: "29")
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CIA_MultiSelectChipWidget(
                  disabled: true,
                  singleSelect: true,
                  onChange: (selectedValue, isSelected) {
                    _constructRow(selectedValue);

                    setState(() {});
                  },
                  labels: [
                    CIA_MultiSelectChipWidgeModel(label: "31"),
                    CIA_MultiSelectChipWidgeModel(label: "32"),
                    CIA_MultiSelectChipWidgeModel(label: "33"),
                    CIA_MultiSelectChipWidgeModel(label: "34"),
                    CIA_MultiSelectChipWidgeModel(label: "35"),
                    CIA_MultiSelectChipWidgeModel(label: "36"),
                    CIA_MultiSelectChipWidgeModel(label: "37"),
                    CIA_MultiSelectChipWidgeModel(label: "38"),
                    CIA_MultiSelectChipWidgeModel(label: "39")
                  ],
                ),
              ),
              SizedBox(),
              Expanded(
                child: CIA_MultiSelectChipWidget(
                  disabled: true,
                  singleSelect: true,
                  onChange: (selectedValue, isSelected) {
                    _constructRow(selectedValue);
                    setState(() {});
                  },
                  labels: [
                    CIA_MultiSelectChipWidgeModel(label: "41"),
                    CIA_MultiSelectChipWidgeModel(label: "42"),
                    CIA_MultiSelectChipWidgeModel(label: "43"),
                    CIA_MultiSelectChipWidgeModel(label: "44"),
                    CIA_MultiSelectChipWidgeModel(label: "45"),
                    CIA_MultiSelectChipWidgeModel(label: "46"),
                    CIA_MultiSelectChipWidgeModel(label: "47"),
                    CIA_MultiSelectChipWidgeModel(label: "48"),
                    CIA_MultiSelectChipWidgeModel(label: "49")
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Center(child: FormTextKeyWidget(text: "Action"))),
                  Expanded(
                      flex: 2,
                      child:
                          Center(child: FormTextKeyWidget(text: "Created On"))),
                  Expanded(
                      flex: 2,
                      child: Center(
                          child: FormTextKeyWidget(text: "Completed On"))),
                  Expanded(
                      child: Center(child: FormTextKeyWidget(text: "Name"))),
                  Expanded(
                      child: Center(child: FormTextKeyWidget(text: "Tooth"))),
                  Expanded(
                      child: Center(child: FormTextKeyWidget(text: "Status"))),
                  Expanded(
                      child:
                          Center(child: FormTextKeyWidget(text: "Provider"))),
                  Expanded(
                      child: Center(child: FormTextKeyWidget(text: "Fees"))),
                ],
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: _TableWidget(),
              ),
            ),
          )
        ],
      ),
    );
  }

  _TableWidget() {
    List<Widget> returnValue = <Widget>[];

    for (_TableRow r in rows) {
      print("add " + r.key.toString());
      returnValue.add(SizedBox(
        height: 10,
      ));
      returnValue.add(
        Row(
          children: [
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CIA_MultiStateButton(
                        currentState: r.Status,
                        onChange: (value) {
                          _ChangeState(r.key!, value);
                        }),
                    GestureDetector(
                      onTap: () {
                        if (r.key != null) _RemoveRow(r.key!);
                      },
                      child: Icon(
                        Icons.delete,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Center(child: FormTextValueWidget(text: r.CreatedOn))),
            Expanded(
                flex: 2,
                child: Center(child: FormTextValueWidget(text: r.CompletedOn))),
            Expanded(child: Center(child: FormTextValueWidget(text: r.Name))),
            Expanded(child: Center(child: FormTextValueWidget(text: r.Tooth))),
            Expanded(child: Center(child: FormTextValueWidget(text: r.Status))),
            Expanded(
                child: Center(child: FormTextValueWidget(text: r.Provider))),
            Expanded(child: Center(child: FormTextValueWidget(text: r.Fees))),
          ],
        ),
      );
      returnValue.add(SizedBox(
        height: 10,
      ));
      returnValue.add(Divider());
    }
    return returnValue;
  }

  _RemoveRow(Key key) {
    for (_TableRow r in rows) {
      if (r.key == key) {
        rows.remove(r);
        setState(() {});
        return;
      }
    }
  }

  _ChangeState(Key key, String value) {
    for (_TableRow r in rows) {
      if (r.key == key) {
        r.Status = value;
        setState(() {});
        return;
      }
    }
  }

  _constructRow(String selectedValue) {
    row.key = GlobalKey();
    row.CreatedOn = DateTime.now().toString();
    row.Name = Of;
    row.Tooth = selectedValue;
    row.Status = As;
    row.Provider = "Omar";
    row.Fees = "950 EGP";
    rows.add(row);
  }
}

_ActionWidget() {}

class _TableRow {
  Key? key;
  Widget Action = Icon(Icons.delete);
  String CreatedOn = "";
  String CompletedOn = "";
  String Name = "";
  String Tooth = "";
  String Status = "";
  String Provider = "";
  String Fees = "";
}
