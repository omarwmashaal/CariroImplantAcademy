import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Widgets/Title.dart';
import '../../features/user/domain/entities/userEntity.dart';

class ViewCandidatePage extends StatefulWidget {
  ViewCandidatePage({Key? key}) : super(key: key);

  @override
  State<ViewCandidatePage> createState() => _ViewCandidatePageState();
}

class _ViewCandidatePageState extends State<ViewCandidatePage> {
  UserEntity? candidate;

  bool edit = false;

  FocusNode next = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWidget(
          title: "Candidate Data",
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
                                        child: FormTextKeyWidget(text: "id")),
                                    Expanded(
                                        child: FormTextValueWidget(
                                            text:
                                                candidate?.id.toString() == null
                                                    ? ""
                                                    : candidate?.id.toString()))
                                  ],
                                ),
                                edit
                                    ? CIA_TextFormField(
                                        label: "Name",
                                        controller: TextEditingController(
                                            text: candidate?.name == null
                                                ? ""
                                                : candidate?.name),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                              child: FormTextKeyWidget(
                                                  text: "Name")),
                                          Expanded(
                                              child: FormTextValueWidget(
                                                  text: candidate?.name == null
                                                      ? ""
                                                      : candidate?.name))
                                        ],
                                      ),
                                edit
                                    ? CIA_TextFormField(
                                        label: "Date of birth",
                                        controller: TextEditingController(
                                            text: candidate?.dateOfBirth==null?"":DateFormat("dd-MM-yyyy").format(candidate!.dateOfBirth!)),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                              child: FormTextKeyWidget(
                                                  text: "Date of birth")),
                                          Expanded(
                                              child: FormTextValueWidget(
                                                  text:candidate?.dateOfBirth==null?"":DateFormat("dd-MM-yyyy").format(candidate!.dateOfBirth!)))
                                        ],
                                      ),
                                edit
                                    ? CIA_TextFormField(
                                        label: "Phone",
                                        controller: TextEditingController(
                                            text: candidate?.phoneNumber == null
                                                ? ""
                                                : candidate?.phoneNumber),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                              child: FormTextKeyWidget(
                                                  text: "Phone")),
                                          Expanded(
                                              child: FormTextValueWidget(
                                                  text: candidate?.phoneNumber == null
                                                      ? ""
                                                      : candidate?.phoneNumber))
                                        ],
                                      ),
                                edit
                                    ? CIA_TextFormField(
                                        label: "Gender",
                                        controller: TextEditingController(
                                            text: candidate?.gender == null
                                                ? ""
                                                : candidate?.gender),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                              child: FormTextKeyWidget(
                                                  text: "Gender")),
                                          Expanded(
                                              child: FormTextValueWidget(
                                                  text:
                                                      candidate?.gender == null
                                                          ? ""
                                                          : candidate?.gender))
                                        ],
                                      ),
                                edit
                                    ? CIA_TextFormField(
                                        label: "Graduated From",
                                        controller: TextEditingController(
                                            text:
                                                candidate?.graduatedFrom == null
                                                    ? ""
                                                    : candidate?.graduatedFrom),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                              child: FormTextKeyWidget(
                                                  text: "Graduated From")),
                                          Expanded(
                                              child: FormTextValueWidget(
                                                  text: candidate
                                                              ?.graduatedFrom ==
                                                          null
                                                      ? ""
                                                      : candidate
                                                          ?.graduatedFrom))
                                        ],
                                      ),
                                edit
                                    ? CIA_TextFormField(
                                        label: "Class Year",
                                        controller: TextEditingController(
                                            text: candidate?.classYear == null
                                                ? ""
                                                : candidate?.classYear),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                              child: FormTextKeyWidget(
                                                  text: "Class Year")),
                                          Expanded(
                                              child: FormTextValueWidget(
                                                  text: candidate?.classYear ==
                                                          null
                                                      ? ""
                                                      : candidate?.classYear))
                                        ],
                                      ),
                                edit
                                    ? CIA_TextFormField(
                                        label: "Speciality",
                                        controller: TextEditingController(
                                            text: candidate?.speciality == null
                                                ? ""
                                                : candidate?.speciality),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                              child: FormTextKeyWidget(
                                                  text: "Speciality")),
                                          Expanded(
                                              child: FormTextValueWidget(
                                                  text: candidate?.speciality ==
                                                          null
                                                      ? ""
                                                      : candidate?.speciality))
                                        ],
                                      ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: FormTextKeyWidget(
                                      text: "Registration: " +
                                          (candidate?.name == null
                                              ? ""
                                              : candidate?.name as String),
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
    return Container();
  }
}
