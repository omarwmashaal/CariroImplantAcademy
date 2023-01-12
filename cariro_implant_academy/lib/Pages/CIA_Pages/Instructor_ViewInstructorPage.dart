import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/InstructorInfo.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/Title.dart';

class ViewInstructorPage extends StatefulWidget {
  ViewInstructorPage({Key? key}) : super(key: key);

  @override
  State<ViewInstructorPage> createState() => _ViewInstructorPageState();
}

class _ViewInstructorPageState extends State<ViewInstructorPage> {
  InstructorInfoModel? instructor;

  bool edit = false;

  FocusNode next = FocusNode();

  @override
  Widget build(BuildContext context) {
    if (internalPagesController.passedObject is InstructorInfoModel)
      instructor = internalPagesController.passedObject as InstructorInfoModel;
    return Column(
      children: [
        TitleWidget(
          title: "Instructor Data",
          showBackButton: true,
        ),
        Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.only(top: 5),
              child: Column(
                children: [
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
                                    Expanded(
                                        child: FormTextKeyWidget(text: "ID")),
                                    Expanded(
                                        child: FormTextValueWidget(
                                            text: instructor?.ID.toString() ==
                                                    null
                                                ? ""
                                                : instructor?.ID.toString()))
                                  ],
                                ),
                                edit
                                    ? CIA_TextFormField(
                                        label: "Name",
                                        controller: TextEditingController(
                                            text: instructor?.Name == null
                                                ? ""
                                                : instructor?.Name),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                              child: FormTextKeyWidget(
                                                  text: "Name")),
                                          Expanded(
                                              child: FormTextValueWidget(
                                                  text: instructor?.Name == null
                                                      ? ""
                                                      : instructor?.Name))
                                        ],
                                      ),
                                edit
                                    ? CIA_TextFormField(
                                        label: "Date of birth",
                                        controller: TextEditingController(
                                            text:
                                                instructor?.DateOfBirth == null
                                                    ? ""
                                                    : instructor?.DateOfBirth),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                              child: FormTextKeyWidget(
                                                  text: "Date of birth")),
                                          Expanded(
                                              child: FormTextValueWidget(
                                                  text:
                                                      instructor?.DateOfBirth ==
                                                              null
                                                          ? ""
                                                          : instructor
                                                              ?.DateOfBirth))
                                        ],
                                      ),
                                edit
                                    ? CIA_TextFormField(
                                        label: "Phone",
                                        controller: TextEditingController(
                                            text: instructor?.Phone == null
                                                ? ""
                                                : instructor?.Phone),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                              child: FormTextKeyWidget(
                                                  text: "Phone")),
                                          Expanded(
                                              child: FormTextValueWidget(
                                                  text:
                                                      instructor?.Phone == null
                                                          ? ""
                                                          : instructor?.Phone))
                                        ],
                                      ),
                                edit
                                    ? CIA_TextFormField(
                                        label: "Gender",
                                        controller: TextEditingController(
                                            text: instructor?.Gender == null
                                                ? ""
                                                : instructor?.Gender),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                              child: FormTextKeyWidget(
                                                  text: "Gender")),
                                          Expanded(
                                              child: FormTextValueWidget(
                                                  text:
                                                      instructor?.Gender == null
                                                          ? ""
                                                          : instructor?.Gender))
                                        ],
                                      ),
                                edit
                                    ? CIA_TextFormField(
                                        label: "Graduated From",
                                        controller: TextEditingController(
                                            text: instructor?.GraduatedFrom ==
                                                    null
                                                ? ""
                                                : instructor?.GraduatedFrom),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                              child: FormTextKeyWidget(
                                                  text: "Graduated From")),
                                          Expanded(
                                              child: FormTextValueWidget(
                                                  text: instructor
                                                              ?.GraduatedFrom ==
                                                          null
                                                      ? ""
                                                      : instructor
                                                          ?.GraduatedFrom))
                                        ],
                                      ),
                                edit
                                    ? CIA_TextFormField(
                                        label: "Class Year",
                                        controller: TextEditingController(
                                            text: instructor?.ClassYear == null
                                                ? ""
                                                : instructor?.ClassYear),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                              child: FormTextKeyWidget(
                                                  text: "Class Year")),
                                          Expanded(
                                              child: FormTextValueWidget(
                                                  text: instructor?.ClassYear ==
                                                          null
                                                      ? ""
                                                      : instructor?.ClassYear))
                                        ],
                                      ),
                                edit
                                    ? CIA_TextFormField(
                                        label: "Speciality",
                                        controller: TextEditingController(
                                            text: instructor?.Speciality == null
                                                ? ""
                                                : instructor?.Speciality),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                              child: FormTextKeyWidget(
                                                  text: "Speciality")),
                                          Expanded(
                                              child: FormTextValueWidget(
                                                  text: instructor
                                                              ?.Speciality ==
                                                          null
                                                      ? ""
                                                      : instructor?.Speciality))
                                        ],
                                      ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: FormTextKeyWidget(
                                      text: "Registration: " +
                                          (instructor?.Name == null
                                              ? ""
                                              : instructor?.Name as String),
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
                                        image: AssetImage(
                                            "assets/ProfileImage.png"))),
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
                                      onTab: () =>
                                          setState(() => edit = false)),
                                ),
                                Flexible(
                                  child: CIA_PrimaryButton(
                                      label: "Save",
                                      isLong: true,
                                      onTab: () =>
                                          setState(() => edit = false)),
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
              ),
            )),
      ],
    );
  }
}
