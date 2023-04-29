import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/ApplicationUserModel.dart';
import '../../Models/LAB_CustomerModel.dart';
import '../../Widgets/Title.dart';

class LAB_ViewCustomerPage extends StatefulWidget {
  LAB_ViewCustomerPage({Key? key, required this.customer}) : super(key: key);
  ApplicationUserModel customer;
  @override
  State<LAB_ViewCustomerPage> createState() => _LAB_ViewCustomerPageState();
}

class _LAB_ViewCustomerPageState extends State<LAB_ViewCustomerPage> {
  bool edit = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Expanded(child: SizedBox()),
          Expanded(
              child: TitleWidget(
            title: "Customer Data",
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
                                          child: FormTextKeyWidget(text: "id")),
                                      Expanded(
                                          child: FormTextValueWidget(
                                              text: widget.customer?.id
                                                          .toString() ==
                                                      null
                                                  ? ""
                                                  : widget.customer?.id
                                                      .toString()))
                                    ],
                                  ),
                                  edit
                                      ? CIA_TextFormField(
                                          label: "Name",
                                          controller: TextEditingController(
                                              text:
                                                  widget.customer?.name == null
                                                      ? ""
                                                      : widget.customer?.name),
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                                child: FormTextKeyWidget(
                                                    text: "Name")),
                                            Expanded(
                                                child: FormTextValueWidget(
                                                    text:
                                                        widget.customer?.name ==
                                                                null
                                                            ? ""
                                                            : widget.customer
                                                                ?.name))
                                          ],
                                        ),
                                  edit
                                      ? CIA_TextFormField(
                                          label: "Phone",
                                          controller: TextEditingController(
                                              text:
                                                  widget.customer?.phoneNumber == null
                                                      ? ""
                                                      : widget.customer?.phoneNumber),
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                                child: FormTextKeyWidget(
                                                    text: "Phone")),
                                            Expanded(
                                                child: FormTextValueWidget(
                                                    text: widget.customer
                                                                ?.phoneNumber ==
                                                            null
                                                        ? ""
                                                        : widget
                                                            .customer?.phoneNumber))
                                          ],
                                        ),
                                  edit
                                      ? CIA_TextFormField(
                                          label: "Phone 2",
                                          controller: TextEditingController(
                                              text: widget.customer?.phoneNumber2 ==
                                                      null
                                                  ? ""
                                                  : widget.customer?.phoneNumber2),
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                                child: FormTextKeyWidget(
                                                    text: "Phone 2")),
                                            Expanded(
                                                child: FormTextValueWidget(
                                                    text: widget.customer
                                                                ?.phoneNumber2 ==
                                                            null
                                                        ? ""
                                                        : widget
                                                            .customer?.phoneNumber2))
                                          ],
                                        ),
                                  edit
                                      ? CIA_TextFormField(
                                          label: "Clinic Name",
                                          controller: TextEditingController(
                                              text:
                                                  widget.customer?.workPlace!.name ==
                                                          null
                                                      ? ""
                                                      : widget.customer
                                                          ?.workPlace!.name),
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                                child: FormTextKeyWidget(
                                                    text: "Clinic Name")),
                                            Expanded(
                                                child: FormTextValueWidget(
                                                    text: widget.customer
                                                                ?.workPlace!.name ==
                                                            null
                                                        ? ""
                                                        : widget.customer
                                                            ?.workPlace!.name))
                                          ],
                                        ),

                                  Row(
                                    children: [
                                      Expanded(
                                          child: FormTextKeyWidget(
                                        text: "Registration: " +
                                            (widget.customer?.name == null
                                                ? ""
                                                : widget.customer?.name
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
                          Expanded(flex: 2, child: SizedBox()),
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
