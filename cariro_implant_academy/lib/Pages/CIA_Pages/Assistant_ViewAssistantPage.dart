import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/AssistantInfo.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/TabsLayout.dart';
import '../../Widgets/Title.dart';

class ViewAssistantPage extends StatefulWidget {
  ViewAssistantPage({Key? key}) : super(key: key);

  @override
  State<ViewAssistantPage> createState() => _ViewAssistantPageState();
}

class _ViewAssistantPageState extends State<ViewAssistantPage> {
  AssistantInfoModel? assistant;

  bool edit = false;

  FocusNode next = FocusNode();

  @override
  Widget build(BuildContext context) {
    if (internalPagesController.passedObject is AssistantInfoModel)
      assistant = internalPagesController.passedObject as AssistantInfoModel;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Expanded(child: SizedBox()),
          Expanded(child: TitleWidget(title: "Assistant Data",showBackButton: true,)),
          Expanded(flex:10,child: Padding(
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
                                  Expanded(child: FormTextKeyWidget(text: "ID")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: assistant?.ID.toString() == null
                                              ? ""
                                              : assistant?.ID.toString()))
                                ],
                              ),
                              edit
                                  ? CIA_TextFormField(
                                label: "Name",
                                controller: TextEditingController(
                                    text: assistant?.Name == null
                                        ? ""
                                        : assistant?.Name),
                              )
                                  : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(text: "Name")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: assistant?.Name == null
                                              ? ""
                                              : assistant?.Name))
                                ],
                              ),
                              edit
                                  ? CIA_TextFormField(
                                label: "Date of birth",
                                controller: TextEditingController(
                                    text: assistant?.DateOfBirth == null
                                        ? ""
                                        : assistant?.DateOfBirth),
                              )
                                  : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(
                                          text: "Date of birth")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: assistant?.DateOfBirth == null
                                              ? ""
                                              : assistant?.DateOfBirth))
                                ],
                              ),
                              edit
                                  ? CIA_TextFormField(
                                label: "Phone",
                                controller: TextEditingController(
                                    text: assistant?.Phone == null
                                        ? ""
                                        : assistant?.Phone),
                              )
                                  : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(text: "Phone")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: assistant?.Phone == null
                                              ? ""
                                              : assistant?.Phone))
                                ],
                              ),
                              edit
                                  ? CIA_TextFormField(
                                label: "Gender",
                                controller: TextEditingController(
                                    text: assistant?.Gender == null
                                        ? ""
                                        : assistant?.Gender),
                              )
                                  : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(text: "Gender")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: assistant?.Gender == null
                                              ? ""
                                              : assistant?.Gender))
                                ],
                              ),
                              edit
                                  ? CIA_TextFormField(
                                label: "Graduated From",
                                controller: TextEditingController(
                                    text: assistant?.GraduatedFrom == null
                                        ? ""
                                        : assistant?.GraduatedFrom),
                              )
                                  : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(
                                          text: "Graduated From")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: assistant?.GraduatedFrom == null
                                              ? ""
                                              : assistant?.GraduatedFrom))
                                ],
                              ),
                              edit
                                  ? CIA_TextFormField(
                                label: "Class Year",
                                controller: TextEditingController(
                                    text: assistant?.ClassYear == null
                                        ? ""
                                        : assistant?.ClassYear),
                              )
                                  : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(
                                          text: "Class Year")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: assistant?.ClassYear == null
                                              ? ""
                                              : assistant?.ClassYear))
                                ],
                              ),
                              edit
                                  ? CIA_TextFormField(
                                label: "Speciality",
                                controller: TextEditingController(
                                    text: assistant?.Speciality == null
                                        ? ""
                                        : assistant?.Speciality),
                              )
                                  : Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(
                                          text: "Speciality")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: assistant?.Speciality == null
                                              ? ""
                                              : assistant?.Speciality))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(
                                        text: "Registration: " +
                                            (assistant?.Name == null
                                                ? ""
                                                : assistant?.Name as String),
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
                                  child:
                                  Image(image: AssetImage("ProfileImage.png"))),

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
            ),
          )),
        ],
      ),
    );
  }


}
