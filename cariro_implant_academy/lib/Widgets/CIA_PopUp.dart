import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/NonSurgicalTreatment.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../Constants/Colors.dart';
import '../core/presentation/widgets/CIA_GestureWidget.dart';

CIA_PopupDialog_DateTimePicker(BuildContext context, String title, Function(DateTime) onChange, {DateTime? initDate}) async {
  String date = "";
  String hour = "";
  String minute = "";
  String timey = "PM";
  dialogHelper.increaseCount();
  if (initDate != null) {
    hour = DateFormat("h").format(initDate);
    minute = DateFormat("mm").format(initDate);
    timey = DateFormat("a").format(initDate);
  }
  Alert(
    closeFunction: () {
      dialogHelper.dismissSingle(context);
    },
    context: context,
    title: title,
    style: AlertStyle(backgroundColor: Colors.white),
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
                  child: CIA_GestureWidget(
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
                    date = value.value.toString().replaceAll(" 00:00:00.000", "");
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
        onPressed: () => dialogHelper.dismissSingle(context),
        color: Color_Background,
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      DialogButton(
        width: 150,
        onPressed: () {
          DateTime? value = DateTime.tryParse(date);
          if (value == null) {
            ShowSnackBar(context, isSuccess: false, message: "Error in date!");
          } else {
            try {
              var tempTime = DateFormat("h:mm a").parse("$hour:$minute $timey");
              value = DateTime(value.year, value.month, value.day, tempTime.hour, tempTime.minute);
              onChange(value);
              dialogHelper.dismissSingle(context);
            } catch (e) {
              ShowSnackBar(context, isSuccess: false, message: "Error in time!");
            }
          }
        },
        child: Text(
          "Save",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ],
  ).show();
}

CIA_PopupDialog_DateOnlyPicker(BuildContext context, String title, Function(DateTime date) onChange, {DateTime? initialDate}) async {
  DateTime? dateTime;
  String? error;
  FocusNode focus = FocusNode();
  focus.requestFocus();
  dialogHelper.increaseCount();
  Alert(
    closeFunction: () {
      dialogHelper.dismissSingle(context);
    },
    style: AlertStyle(backgroundColor: Colors.white),
    context: context,
    title: title,
    content: StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Container(
          width: 350,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CIA_TextFormField(
                  label: "Enter Date in format dd/MM/yyyy or dd-MM-yyyy",
                  selectAll: false,
                  focusNode: focus,
                  onSubmit: (value) {
                    if (error != null) {
                      ShowSnackBar(context, isSuccess: false, message: error!);
                    } else {
                      if (dateTime != null) onChange(dateTime!);
                      dialogHelper.dismissSingle(context);
                    }
                  },
                  controller: TextEditingController(text: initialDate == null ? "" : DateFormat("dd/MM/yyyy").format(initialDate)),
                  onChange: (value) {
                    if (error != null) return;
                    try {
                      if (dateTime != null) {
                        if (initialDate != null) {
                          dateTime =
                              DateTime(dateTime!.year, dateTime!.month, dateTime!.day, initialDate!.hour, initialDate!.minute, initialDate!.second);
                        } else {
                          dateTime = DateTime(dateTime!.year, dateTime!.month, dateTime!.day, 0, 0, 0);
                        }
                        // date = value.value.toString().replaceAll(" 00:00:00.000", "");
                      }
                    } catch (e) {}
                  },
                  errorFunction: (value) {
                    try {
                      dateTime = DateFormat("dd/MM/yyyy").parse(value);
                    } catch (e) {
                      try {
                        dateTime = DateFormat("dd-MM-yyyy").parse(value);
                      } catch (e) {
                        error = "Wrong date format";
                        return true;
                      }
                    }
                    error = null;
                    return false;
                  },
                ),
              ],
            ),
          ),
          // SfDateRangePicker(
          //   initialSelectedDate: initialDate,
          //   view: DateRangePickerView.month,
          //   enablePastDates: true,
          //   showNavigationArrow: true,
          //   selectionColor: Color_Accent,
          //   todayHighlightColor: Color_Accent,
          //   selectionMode: DateRangePickerSelectionMode.single,
          //   showTodayButton: true,
          //   navigationMode: DateRangePickerNavigationMode.snap,
          //   onSelectionChanged: (value) {
          //     var dateTime = value.value as DateTime;
          //     DateTime date_;
          //     setState(() {
          //       date = DateFormat("dd-MM-yyyy").format(value.value);

          //       if (initialDate != null) {
          //         date_ = DateTime(dateTime.year, dateTime.month, dateTime.day, initialDate!.hour, initialDate!.minute, initialDate!.second);
          //       } else {
          //         date_ = DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0);
          //       }
          //       // date = value.value.toString().replaceAll(" 00:00:00.000", "");
          //       onChange(date_);
          //     });
          //   },
          // ),
        );
      },
    ),
    buttons: [
      DialogButton(
        width: 150,
        onPressed: () {
          dialogHelper.dismissSingle(context);
        },
        color: Color_Background,
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      DialogButton(
        width: 150,
        onPressed: () {
          if (error != null)
            ShowSnackBar(context, isSuccess: false, message: error!);
          else {
            if (dateTime != null) onChange(dateTime!);

            dialogHelper.dismissSingle(context);
            dialogHelper.dismissSingle(context);
          }
        },
        child: Text(
          "Save",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ],
  ).show();
}

/*
CIA_PopUpTreatmentHistory_Table(int patientId, BuildContext context, String title, Function onChange) async {
  NonSurgicalTreatmentDataSource dataSource = NonSurgicalTreatmentDataSource();

  dialogHelper.increaseCount();
  Alert(
    closeFunction: (){
      dialogHelper.dismissSingle(context);
    },
    
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
                  future: dataSource.loadData(patientId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CIA_Table(
                          isTreatment: true,
                          onCellClick: (value) {
                            Alert(
    closeFunction: (){
      dialogHelper.dismissSingle(context);
    },
                              context: context,
                              title: "Treatment Notes",
                              content: SizedBox(
                                width: 600,
                                child: Text(
                                  dataSource.models[value - 1].treatment.toString(),
                                  style: TextStyle(fontWeight: FontWeight.normal),
                                ),
                              ),
                              buttons: [
                                DialogButton(
                                  width: 150,
                                  onPressed: () => dialogHelper.dismissSingle(context),
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ],
                            ).show();
                          },
                          columnNames: NonSurgicalTreatmentModelsssss.columns,
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
        onPressed: () => dialogHelper.dismissSingle(context),
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ],
  ).show();
}
*/
CIA_ShowPopUp(
    {required BuildContext context,
    String? title,
    Function? onSave,
    Widget? child,
    String? buttonText,
    double? height,
    bool? hideButton = false,
    double? width}) async {
  dialogHelper.increaseCount();
  await Alert(
    closeFunction: () {
      dialogHelper.dismissSingle(context);
    },
    context: context,
    title: title,
    style: AlertStyle(backgroundColor: Colors.white),
    content: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
      return SizedBox(
        width: width ?? 400,
        height: height ?? 400,
        child: child,
      );
    }),
    buttons: hideButton!
        ? []
        : [
            DialogButton(
              color: Color_Accent,
              width: 150,
              onPressed: () async {
                bool close = true;
                if (onSave != null) {
                  var s = await onSave!();
                  if (s != null && s is bool) close = s;
                }

                if (close) dialogHelper.dismissSingle(context);
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
  dialogHelper.increaseCount();
  await Alert(
    closeFunction: () {
      dialogHelper.dismissSingle(context);
    },
    context: context,
    style: AlertStyle(backgroundColor: Colors.white),
    title: title,
    content: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
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
          dialogHelper.dismissSingle(context);
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
          dialogHelper.dismissSingle(context);
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
          dialogHelper.dismissSingle(context);
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
    double? width,
    String? buttonText,
    double? size}) async {
  dialogHelper.increaseCount();
  await Alert(
    closeFunction: () {
      dialogHelper.dismissSingle(context);
    },
    style: AlertStyle(backgroundColor: Colors.white),
    context: context,
    title: title,
    //content: SizedBox(width: width??120,),
    buttons: [
      DialogButton(
        color: Color_Background,
        width: 150,
        onPressed: () {
          if (onCancel != null) onCancel();
          dialogHelper.dismissSingle(context);
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
          dialogHelper.dismissSingle(context);
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
  dialogHelper.increaseCount();
  String search = "";
  List<DropDownDTO> results = [];
  TextEditingController controller = TextEditingController();
  Alert(
    closeFunction: () {
      dialogHelper.dismissSingle(context);
    },
    style: AlertStyle(backgroundColor: Colors.white),
    context: context,
    title: title,
    content: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
      controller.text = search;
      controller.selection = TextSelection(baseOffset: search.length, extentOffset: search.length);
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
                  if (res.statusCode == 200) results = res.result as List<DropDownDTO>;
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
                      dialogHelper.dismissSingle(context);
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
          dialogHelper.dismissSingle(context);
        },
        child: Text(
          buttonText == null ? "Ok" : buttonText,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ],
  ).show();
}
