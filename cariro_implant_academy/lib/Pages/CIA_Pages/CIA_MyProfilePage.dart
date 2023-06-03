import 'package:calendar_view/calendar_view.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Constants/Controllers.dart';
import '../../Models/MedicalModels/TreatmentPlanModel.dart';
import '../../Widgets/CIA_PrimaryButton.dart';
import '../../Widgets/CIA_SecondaryButton.dart';
import '../../Widgets/CIA_TextFormField.dart';
import '../../Widgets/FormTextWidget.dart';
import '../../Widgets/MultiSelectChipWidget.dart';
import '../../Widgets/Title.dart';

class CIA_MyProfilePage extends StatefulWidget {
  CIA_MyProfilePage({Key? key}) : super(key: key);

  PatientInfoModel user = PatientInfoModel();
  static String routeName = "MyProfile";
  static String routePath = "MyProfile";

  @override
  State<CIA_MyProfilePage> createState() => _CIA_MyProfilePageState();
}

class _CIA_MyProfilePageState extends State<CIA_MyProfilePage> {
  bool edit = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TitleWidget(title: "My Profile"),

          ],
        ),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: FocusTraversalGroup(
                  policy: OrderedTraversalPolicy(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Expanded(child: FormTextKeyWidget(text: "ID")),
                          Expanded(
                              child: FormTextValueWidget(
                                  text: widget.user?.id.toString() == null
                                      ? ""
                                      : widget.user?.id.toString()))
                        ],
                      ),
                      edit
                          ? CIA_TextFormField(
                        label: "Name",
                        controller: TextEditingController(
                            text: widget.user?.name == null
                                ? ""
                                : widget.user?.name),
                      )
                          : Row(
                        children: [
                          Expanded(
                              child: FormTextKeyWidget(text: "Name")),
                          Expanded(
                              child: FormTextValueWidget(
                                  text: widget.user?.name == null
                                      ? ""
                                      : widget.user?.name))
                        ],
                      ),
                      edit
                          ? CIA_TextFormField(
                        label: "Name",
                        controller: TextEditingController(
                            text: widget.user?.name == null
                                ? ""
                                : widget.user?.name),
                      )
                          : Row(
                        children: [
                          Expanded(
                              child:
                              FormTextKeyWidget(text: "Gender")),
                          Expanded(
                              child: FormTextValueWidget(
                                  text: widget.user?.gender == null
                                      ? ""
                                      : widget.user?.gender))
                        ],
                      ),
                      edit
                          ? CIA_TextFormField(
                        label: "Phone Number",
                        controller: TextEditingController(
                            text: widget.user?.phone == null
                                ? ""
                                : widget.user?.phone),
                      )
                          : Row(
                        children: [
                          Expanded(
                              child: FormTextKeyWidget(
                                  text: "Phone Number")),
                          Expanded(
                              child: FormTextValueWidget(
                                  text: widget.user?.phone == null
                                      ? ""
                                      : widget.user?.phone))
                        ],
                      ),
                      edit
                          ? CIA_TextFormField(
                        label: "Another Phone Number",
                        controller: TextEditingController(
                            text: widget.user?.phone2 == null
                                ? ""
                                : widget.user?.phone2),
                      )
                          : Row(
                        children: [
                          Expanded(
                              child: FormTextKeyWidget(
                                  text: "Another Phone Number")),
                          Expanded(
                              child: FormTextValueWidget(
                                  text: widget.user?.phone2 == null
                                      ? ""
                                      : widget.user?.phone2))
                        ],
                      ),
                      edit
                          ? CIA_TextFormField(
                        label: "Date Of Birth",
                        controller: TextEditingController(
                            text: widget.user?.dateOfBirth == null
                                ? ""
                                : widget.user?.dateOfBirth),
                      )
                          : Row(
                        children: [
                          Expanded(
                              child: FormTextKeyWidget(
                                  text: "Date Of Birth")),
                          Expanded(
                              child: FormTextValueWidget(
                                  text:
                                  widget.user?.dateOfBirth == null
                                      ? ""
                                      : widget.user?.dateOfBirth))
                        ],
                      ),
                      edit
                          ? CIA_TextFormField(
                        label: "MaritalStatus",
                        controller: TextEditingController(
                            text: widget.user?.maritalStatus == null
                                ? ""
                                : widget.user?.maritalStatus),
                      )
                          : Row(
                        children: [
                          Expanded(
                              child: FormTextKeyWidget(
                                  text: "Marital Status")),
                          Expanded(
                              child: FormTextValueWidget(
                                  text: widget.user?.maritalStatus ==
                                      null
                                      ? ""
                                      : widget.user?.maritalStatus))
                        ],
                      ),
                      edit
                          ? CIA_TextFormField(
                        label: "Address",
                        controller: TextEditingController(
                            text: widget.user?.address == null
                                ? ""
                                : widget.user?.address),
                      )
                          : Row(
                        children: [
                          Expanded(
                              child:
                              FormTextKeyWidget(text: "Address")),
                          Expanded(
                              child: FormTextValueWidget(
                                  text: widget.user?.address == null
                                      ? ""
                                      : widget.user?.address))
                        ],
                      ),
                      edit
                          ? CIA_TextFormField(
                        label: "City",
                        controller: TextEditingController(
                            text: widget.user?.city == null
                                ? ""
                                : widget.user?.city),
                      )
                          : Row(
                        children: [
                          Expanded(
                              child: FormTextKeyWidget(text: "City")),
                          Expanded(
                              child: FormTextValueWidget(
                                  text: widget.user?.city == null
                                      ? ""
                                      : widget.user?.city))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: FormTextKeyWidget(
                                text: "Registration: " +
                                    (widget.user?.name == null
                                        ? ""
                                        : widget.user?.name as String),
                                secondaryInfo: true,
                              )),
                          Expanded(
                              child: FormTextValueWidget(
                                text: "12/10/2022",
                                secondaryInfo: true,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Expanded(
                          child: Image(
                              image:
                              AssetImage("assets/ProfileImage.png"))),
                    ],
                  ))
            ],
          ),
        ),
        Expanded(
          child: edit
              ? Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: SizedBox()),
                Flexible(
                  child: CIA_SecondaryButton(
                      label: "Cancel",
                      onTab: () => setState(() => edit = false)),
                ),
                Flexible(
                  child: CIA_PrimaryButton(
                      label: "Save",
                      isLong: true,
                      onTab: () => setState(() => edit = false)),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
          )
              : Center(
            child: CIA_SecondaryButton(
              onTab: () {
                setState(() {
                  edit = true;
                });
              },
              label: "Edit Info",
            ),
          ),
        )
      ],
    );

    //todo: fix this
    _Calendar();
  }

  @override
  void initState() {
    // siteController.setAppBarWidget(tabs: ["My Profile", "Calendar"]);
    siteController.setAppBarWidget();
  }
}

class _Calendar extends StatefulWidget {
  const _Calendar({Key? key}) : super(key: key);

  @override
  State<_Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<_Calendar> {
  DateTime selectedDate = DateTime.now();
  Event? selectedEvent = null;
  bool weekView = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 550,
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  CIA_PrimaryButton(
                      label: "Week View",
                      onTab: () {
                        setState(() {
                          weekView = true;
                        });
                      }),
                  SizedBox(width: 10),
                  CIA_PrimaryButton(
                      label: "Day View",
                      onTab: () {
                        setState(() {
                          weekView = false;
                        });
                      }),
                ],
              ),
              Expanded(
                child: weekView
                    ? WeekView(
                        controller: EventController<Event>()..addAll(_events),
                        width: 550,
                        startDay: WeekDays.saturday,
                        onDateTap: (value) {
                          setState(() {
                            selectedDate = value;
                          });
                        },
                        onEventTap:
                            (List<CalendarEventData<Event>> event, DateTime t) {
                          setState(() {
                            selectedEvent = event[0].event;
                          });
                        },
                      )
                    : DayView(
                        controller: EventController<Event>()..addAll(_events),
                        width: 550,
                      ),
              )
            ],
          ),
        ),
        Expanded(
            child: Column(
          children: [
            Row(
              children: [
                TitleWidget(title: "Plan My Week"),
                SizedBox(width: 10),
                Text(
                  "Selected Date " +
                      DateFormat("dd MMMM yyyy").add_jm().format(selectedDate),
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            FormTextKeyWidget(text: "Selected Event"),
            _EventWidget(
              key: GlobalKey(),
              event: selectedEvent,
              onChange: () {},
            )
          ],
        ))
      ],
    );
  }
}

class _EventWidget extends StatefulWidget {
  _EventWidget({Key? key, this.event, required this.onChange})
      : super(key: key);

  Event? event;
  Function onChange;
  @override
  State<_EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<_EventWidget> {
  String desc = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CIA_MultiSelectChipWidget(key: GlobalKey(), labels: [
          CIA_MultiSelectChipWidgeModel(
            label: "Extraction",
            value: "extraction",
          ),
          CIA_MultiSelectChipWidgeModel(
            label: "Simple Implant",
            value: "simpleImplant",
          ),
          CIA_MultiSelectChipWidgeModel(
            label: "Immediate Implant",
            value: "immediateImplant",
          ),
          CIA_MultiSelectChipWidgeModel(
            label: "Guided Implant",
            value: "guidedImplant",
          ),
          CIA_MultiSelectChipWidgeModel(
            label: "Expansion",
            value: "expansion",
          ),
          CIA_MultiSelectChipWidgeModel(
            label: "Splitting",
            value: "splitting",
          ),
          CIA_MultiSelectChipWidgeModel(
            label: "GBR",
            value: "gbr",
          ),
          CIA_MultiSelectChipWidgeModel(
            label: "Open Sinus",
            value: "openSinus",
          ),
          CIA_MultiSelectChipWidgeModel(
            label: "Closed Sinus",
            value: "closedSinus",
          ),
          CIA_MultiSelectChipWidgeModel(
            label: "Bontic",
            value: "bontic",
          ),
        ]),
        SizedBox(height: 10),
        CIA_DropDown(
            onSelect: (value) {
              desc = value;
            },
            selectedValue:
                widget.event != null ? widget.event?.patient.name : "",
            label: "Patient",
            values: [
              "Patient1",
              "Patient2",
              "Patient3",
              "Patient4",
              "Patient5",
              "Patient6",
              "Patient7",
            ]),
        CIA_PrimaryButton(
            label: "Add Event",
            onTab: () {
              // _events.add(CalendarEventData(title: title, date: date))
              widget.onChange();
            })
      ],
    );
  }
}

class Event {
  String title;
  PatientInfoModel patient;
  TreatmentPlanModel? plan;

  Event({required this.patient, required this.title, this.plan});
}

DateTime _now = DateTime.now();
List<CalendarEventData<Event>> _events = [
  CalendarEventData(
    date: _now,
    event: Event(
        title: "sadasdsa",
        patient: PatientInfoModel()),
    title: "Project meeting",
    description: "Today is project meeting.",
    startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
    endTime: DateTime(_now.year, _now.month, _now.day, 22),
  ),
  CalendarEventData(
    date: _now,
    event: Event(
        title: "127419824612986512",
        patient:
            PatientInfoModel()),
    title: "adadasdasdadasdasng",
    description: "Toafasfafafafsang.",
    startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
    endTime: DateTime(_now.year, _now.month, _now.day, 22),
  ),
];
