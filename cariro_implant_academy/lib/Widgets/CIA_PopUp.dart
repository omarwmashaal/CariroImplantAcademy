import 'package:cariro_implant_academy/Models/NonSurgicalTreatmentModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../Constants/Colors.dart';

CIA_PopupDialog_DateTimePicker(
    BuildContext context, String title, Function onChange) async {
  String date = "";
  String hour = "";
  String minute = "";
  String timey = "PM";
  Alert(
    context: context,
    title: title,
    content: StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: CIA_TextFormField(
                      onChange: (value) {
                        hour = value;
                      },
                      isHours: true,
                      label: 'Hour',
                      controller: TextEditingController(text: hour)),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: CIA_TextFormField(
                      onChange: (value) {
                        minute = value;
                      },
                      isMinutes: true,
                      label: 'Minute',
                      controller: TextEditingController(text: minute)),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        timey = timey == "PM" ? "AM" : "PM";
                      });
                    },
                    child: Text(timey),
                  ),
                )
              ],
            ),
            Container(
              width: 350,
              height: 350,
              child: SfDateRangePicker(
                view: DateRangePickerView.month,
                enablePastDates: false,
                showNavigationArrow: true,
                selectionColor: Color_AccentGreen,
                todayHighlightColor: Color_AccentGreen,
                selectionMode: DateRangePickerSelectionMode.single,
                showTodayButton: true,
                navigationMode: DateRangePickerNavigationMode.snap,
                onSelectionChanged: (value) {
                  setState(() {
                    date =
                        value.value.toString().replaceAll(" 00:00:00.000", "");
                    onChange(date);
                  });
                },
              ),
            ),
          ],
        );
      },
    ),
    buttons: [
      DialogButton(
        width: 150,
        onPressed: () => Navigator.pop(context),
        color: Color_Background,
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      DialogButton(
        width: 150,
        onPressed: () => Navigator.pop(context),
        child: Text(
          "Save",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ],
  ).show();
}

CIA_PopupDialog_Table(
    BuildContext context, String title, Function onChange) async {
  NonSurgicalTreatmentDataSource dataSource = NonSurgicalTreatmentDataSource();

  Alert(
    context: context,
    title: title,
    content: StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 900,
              height: 400,
              child: CIA_Table(
                  loadFunction: () {},
                  onCellClick: (value) {
                    Alert(
                      context: context,
                      title: "Treatment Notes",
                      content: SizedBox(
                        width: 400,
                        child: Text(
                            dataSource.models[value - 1].Treatment.toString()),
                      ),
                      buttons: [
                        DialogButton(
                          width: 150,
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Ok",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ],
                    ).show();
                  },
                  columnNames: NonSurgicalTreatmentModel.columns,
                  dataSource: dataSource),
            ),
          ],
        );
      },
    ),
    buttons: [
      DialogButton(
        width: 150,
        onPressed: () => Navigator.pop(context),
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ],
  ).show();
}