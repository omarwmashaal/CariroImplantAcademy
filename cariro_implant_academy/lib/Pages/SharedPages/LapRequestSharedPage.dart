import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Widgets/CIA_CheckBoxWidget.dart';
import '../../Widgets/FormTextWidget.dart';

class LapRequestSharedPage extends StatelessWidget {
  const LapRequestSharedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CIA_SecondaryButton(
              label: "New Customer",
              onTab: () {
                Alert(
                  context: context,
                  title: "Add new customer",
                  content: SizedBox(
                    width: 400,
                  ),
                  buttons: [
                    DialogButton(
                      color: Color_Accent,
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
            ),
            SizedBox(
              width: 10,
            ),
            CIA_SecondaryButton(
              label: "Attach File",
              onTab: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();

                if (result != null) {
                  //File file = File(result.files.single.path);
                } else {
                  // User canceled the picker
                }
              },
            ),
          ],
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 10,
          child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: ListView(
              children: [
                FocusTraversalGroup(
                  policy: OrderedTraversalPolicy(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: CIA_TextFormField(
                                label: "Doctor",
                                controller: TextEditingController()),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CIA_TextFormField(
                                label: "Delivery Date",
                                controller: TextEditingController()),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CIA_TextFormField(
                                label: "Phone",
                                controller: TextEditingController()),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CIA_TextFormField(
                                  label: "Step Required",
                                  controller: TextEditingController()))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CIA_TextFormField(
                                label: "Patient Name",
                                controller: TextEditingController()),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CIA_TextFormField(
                                label: "Notes",
                                controller: TextEditingController()),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CIA_TextFormField(
                                label: "Date of visit",
                                controller: TextEditingController()),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: FormTextKeyWidget(
                            text: "Customer",
                            secondaryInfo: true,
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FormTextKeyWidget(text: "Details"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                CIA_CheckBoxWidget(
                                  text: "Full zireon crown",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Porcelain fused to zircomium",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Porcelain fused to metal",
                                ),
                                CIA_CheckBoxWidget(
                                  text:
                                      "Porcelain fused to metal (CAD-CAM Co-Cr alloy)",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Glass ceramic crown",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Visiolign bonded to PEEK",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Laminate veneer",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Milled PMMA temporary crown",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Long term temporary crown",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                CIA_CheckBoxWidget(
                                  text: "Screw-ratained crown",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Survey crown for RPD",
                                ),
                                CIA_CheckBoxWidget(
                                  text:
                                      "Survey crown with extra coronal attahcment",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Cast post & core",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Zirconium post and core",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Custom carbon fiber post",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Zirconium inlay or onlay",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Glass ceramic inlay or onlay",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "CAD-CAM abutment",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                CIA_CheckBoxWidget(
                                  text: "Special tray",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Occlusion block",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Diagnostic or trail setup",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Flexible RPD",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Metallic RPD",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Night guard vacuum template",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Radiographic duplicates for CBCT",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Clear surgical templates",
                                ),
                                CIA_CheckBoxWidget(
                                  text: "Diagnostic surveying",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          FormTextKeyWidget(
                            text: "Date of Entry",
                            secondaryInfo: true,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FormTextValueWidget(
                            text: "12/12/2012",
                            secondaryInfo: true,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          FormTextKeyWidget(
                            text: "Entry by",
                            secondaryInfo: true,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FormTextValueWidget(
                            text: "Omar",
                            secondaryInfo: true,
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: CIA_PrimaryButton(
                          label: "Finish",
                          onTab: () {},
                          isLong: true,
                        ),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
