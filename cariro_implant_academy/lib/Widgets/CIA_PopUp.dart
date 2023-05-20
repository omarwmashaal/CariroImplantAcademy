import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/NonSurgicalTreatment.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Patient_MedicalInfo.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
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
                selectionColor: Color_Accent,
                todayHighlightColor: Color_Accent,
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

CIA_PopupDialog_DateOnlyPicker(
    BuildContext context, String title, Function onChange) async {
  String date = "";
  Alert(
    context: context,
    title: title,
    content: StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Container(
          width: 350,
          height: 350,
          child: SfDateRangePicker(
            view: DateRangePickerView.month,
            enablePastDates: true,
            showNavigationArrow: true,
            selectionColor: Color_Accent,
            todayHighlightColor: Color_Accent,
            selectionMode: DateRangePickerSelectionMode.single,
            showTodayButton: true,
            navigationMode: DateRangePickerNavigationMode.snap,
            onSelectionChanged: (value) {
              setState(() {
                date = value.value.toString().replaceAll(" 00:00:00.000", "");
                onChange(date);
              });
            },
          ),
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

CIA_PopupDialog_Table(int paitnetID, BuildContext context, String title,
    Function onChange) async {
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
              width: 1000,
              height: 400,
              child: FutureBuilder(
                  future: dataSource.loadData(patientID),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CIA_Table(
                          isTreatment: true,
                          onCellClick: (value) {
                            Alert(
                              context: context,
                              title: "Treatment Notes",
                              content: SizedBox(
                                width: 400,
                                child: Text(dataSource
                                    .models[value - 1].treatment
                                    .toString()),
                              ),
                              buttons: [
                                DialogButton(
                                  width: 150,
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ],
                            ).show();
                          },
                          columnNames: NonSurgicalTreatmentModel.columns,
                          dataSource: dataSource);
                    } else {
                      return Center(
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballClipRotateMultiple,
                          colors: [Color_Accent],
                        ),
                      );
                    }
                  }),
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

CIA_ShowPopUp(
    {required BuildContext context,
    String? title,
    Function? onSave,
    Widget? child,
    String? buttonText,
      double? height,
      bool? hideButton=false,
    double? width}) async{
  await Alert(
    context: context,
    title: title,
    content: StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return SizedBox(
        width: width ?? 400 ,
        height: height??400,
        child: child,
      );
    }),
    buttons:hideButton!?[]: [
      DialogButton(
        color: Color_Accent,
        width: 150,
        onPressed: () {

          Navigator.pop(context);
          if (onSave != null) onSave!();
        },
        child: Text(
          buttonText == null ? "Ok" : buttonText,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ],
  ).show();
}

CIA_ShowPopUpSaveRequest(
    {required BuildContext context,
    String? title,
    required Function onSave,
    Function? onDontSave,
    Function? onCancel,
    String? buttonText,
    double? size}) async {
  await Alert(
    context: context,
    title: title,
    content: StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return SizedBox(
        width: size == null ? 400 : size,
        child: Text(title ?? "Do you want to save changes?"),
      );
    }),
    buttons: [
      DialogButton(
        color: Color_Background,
        width: 150,
        onPressed: () {
          if (onCancel != null) onCancel();
          Navigator.pop(context);
        },
        child: Text(
          buttonText == null ? "Cancel" : buttonText,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      DialogButton(
        color: Color_Background,
        width: 150,
        onPressed: () async {
          if (onDontSave != null) onDontSave();
          Navigator.pop(context);
        },
        child: Text(
          buttonText == null ? "Don't Save" : buttonText,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      DialogButton(
        color: Color_Accent,
        width: 150,
        onPressed: () {
          if (onSave != null) onSave();
          Navigator.pop(context);
        },
        child: Text(
          buttonText == null ? "Save" : buttonText,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ],
  ).show();
}

CIA_ShowPopUpYesNo(
    {required BuildContext context,
    String? title,
    required Function onSave,
    Function? onDontSave,
    Function? onCancel,
    String? buttonText,
    double? size}) async {
  await Alert(
    context: context,
    title: title,
    buttons: [
      DialogButton(
        color: Color_Background,
        width: 150,
        onPressed: () {
          if (onCancel != null) onCancel();
          Navigator.pop(context);
        },
        child: Text(
          buttonText == null ? "No" : buttonText,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),

      DialogButton(
        color: Color_Accent,
        width: 150,
        onPressed: () {
          if (onSave != null) onSave();
          Navigator.pop(context);
        },
        child: Text(
          buttonText == null ? "Yes" : buttonText,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ],
  ).show();
}

CIA_PopUpSearch(
    {required BuildContext context,
    String? title,
    Function(DropDownDTO selected)? onChoose,
    required Future<API_Response> searchFunction(String),
    String? buttonText,
    double? size}) {
  String search = "";
  List<DropDownDTO> results = [];
  TextEditingController controller = TextEditingController();
  Alert(
    context: context,
    title: title,
    content: StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      controller.text = search;
      controller.selection =
          TextSelection(baseOffset: search.length, extentOffset: search.length);
      return SizedBox(
        width: size == null ? 400 : size,
        height: 400,
        child: Column(
          children: [
            Expanded(
              child: CIA_TextFormField(
                label: "Search",
                controller: controller,
                onChange: (value) async {
                  if (value == "" || value == null) {
                    search = "";
                    results = [];
                    setState(() {});
                    return;
                  }
                  var res = await searchFunction(value);
                  if (res.statusCode == 200)
                    results = res.result as List<DropDownDTO>;
                  setState(() {
                    search = value;
                  });
                },
              ),
            ),
            Expanded(
              flex: 10,
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(results[index].name!),
                    onTap: () {
                      if (onChoose != null) onChoose!(results[index]);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            )
          ],
        ),
      );
    }),
    buttons: [
      DialogButton(
        color: Color_Accent,
        width: 150,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          buttonText == null ? "Ok" : buttonText,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ],
  ).show();
}
