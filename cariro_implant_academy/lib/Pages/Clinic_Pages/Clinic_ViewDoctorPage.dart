import 'package:cariro_implant_academy/Models/Clinic_DoctorModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/Title.dart';

class Clinic_ViewDoctorPage extends StatefulWidget {
  Clinic_ViewDoctorPage({Key? key, required this.doctor}) : super(key: key);
  Clinic_DoctorModel doctor;

  @override
  State<Clinic_ViewDoctorPage> createState() => _Clinic_ViewDoctorPageState();
}

class _Clinic_ViewDoctorPageState extends State<Clinic_ViewDoctorPage> {
  bool edit = false;

  FocusNode next = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Expanded(child: SizedBox()),
          Expanded(
              child: TitleWidget(
            title: "Doctor Data",
            showBackButton: true,
          )),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: FormTextKeyWidget(text: "ID")),
                                      Expanded(
                                          child: FormTextValueWidget(
                                              text: widget.doctor?.ID
                                                          .toString() ==
                                                      null
                                                  ? ""
                                                  : widget.doctor?.ID
                                                      .toString()))
                                    ],
                                  ),
                                  edit
                                      ? CIA_TextFormField(
                                          label: "Name",
                                          controller: TextEditingController(
                                              text: widget.doctor?.Name == null
                                                  ? ""
                                                  : widget.doctor?.Name),
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                                child: FormTextKeyWidget(
                                                    text: "Name")),
                                            Expanded(
                                                child: FormTextValueWidget(
                                                    text: widget.doctor?.Name ==
                                                            null
                                                        ? ""
                                                        : widget.doctor?.Name))
                                          ],
                                        ),
                                  edit
                                      ? CIA_TextFormField(
                                          label: "Date of birth",
                                          controller: TextEditingController(
                                              text: widget.doctor
                                                          ?.DateOfBirth ==
                                                      null
                                                  ? ""
                                                  : widget.doctor?.DateOfBirth),
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                                child: FormTextKeyWidget(
                                                    text: "Date of birth")),
                                            Expanded(
                                                child: FormTextValueWidget(
                                                    text: widget.doctor
                                                                ?.DateOfBirth ==
                                                            null
                                                        ? ""
                                                        : widget.doctor
                                                            ?.DateOfBirth))
                                          ],
                                        ),
                                  edit
                                      ? CIA_TextFormField(
                                          label: "Phone",
                                          controller: TextEditingController(
                                              text: widget.doctor?.Phone == null
                                                  ? ""
                                                  : widget.doctor?.Phone),
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                                child: FormTextKeyWidget(
                                                    text: "Phone")),
                                            Expanded(
                                                child: FormTextValueWidget(
                                                    text: widget.doctor
                                                                ?.Phone ==
                                                            null
                                                        ? ""
                                                        : widget.doctor?.Phone))
                                          ],
                                        ),
                                  edit
                                      ? CIA_TextFormField(
                                          label: "Gender",
                                          controller: TextEditingController(
                                              text:
                                                  widget.doctor?.Gender == null
                                                      ? ""
                                                      : widget.doctor?.Gender),
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                                child: FormTextKeyWidget(
                                                    text: "Gender")),
                                            Expanded(
                                                child: FormTextValueWidget(
                                                    text:
                                                        widget.doctor?.Gender ==
                                                                null
                                                            ? ""
                                                            : widget.doctor
                                                                ?.Gender))
                                          ],
                                        ),
                                  edit
                                      ? CIA_TextFormField(
                                          label: "Graduated From",
                                          controller: TextEditingController(
                                              text: widget.doctor
                                                          ?.GraduatedFrom ==
                                                      null
                                                  ? ""
                                                  : widget
                                                      .doctor?.GraduatedFrom),
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                                child: FormTextKeyWidget(
                                                    text: "Graduated From")),
                                            Expanded(
                                                child: FormTextValueWidget(
                                                    text: widget.doctor
                                                                ?.GraduatedFrom ==
                                                            null
                                                        ? ""
                                                        : widget.doctor
                                                            ?.GraduatedFrom))
                                          ],
                                        ),
                                  edit
                                      ? CIA_TextFormField(
                                          label: "Class Year",
                                          controller: TextEditingController(
                                              text: widget.doctor?.ClassYear ==
                                                      null
                                                  ? ""
                                                  : widget.doctor?.ClassYear),
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                                child: FormTextKeyWidget(
                                                    text: "Class Year")),
                                            Expanded(
                                                child: FormTextValueWidget(
                                                    text: widget.doctor
                                                                ?.ClassYear ==
                                                            null
                                                        ? ""
                                                        : widget
                                                            .doctor?.ClassYear))
                                          ],
                                        ),
                                  edit
                                      ? CIA_TextFormField(
                                          label: "Speciality",
                                          controller: TextEditingController(
                                              text: widget.doctor?.Speciality ==
                                                      null
                                                  ? ""
                                                  : widget.doctor?.Speciality),
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                                child: FormTextKeyWidget(
                                                    text: "Speciality")),
                                            Expanded(
                                                child: FormTextValueWidget(
                                                    text: widget.doctor
                                                                ?.Speciality ==
                                                            null
                                                        ? ""
                                                        : widget.doctor
                                                            ?.Speciality))
                                          ],
                                        ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: FormTextKeyWidget(
                                        text: "Registration: " +
                                            (widget.doctor?.Name == null
                                                ? ""
                                                : widget.doctor?.Name
                                                    as String),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}
