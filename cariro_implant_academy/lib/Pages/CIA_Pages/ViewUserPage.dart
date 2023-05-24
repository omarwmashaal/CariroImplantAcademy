import 'package:cariro_implant_academy/API/UserAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/CandidateDetails.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/Title.dart';

class _getx extends GetxController {
  static RxInt totalImplants = 0.obs;
}

class ViewUserData extends StatefulWidget {
  ViewUserData({Key? key, required this.userId, this.role}) : super(key: key);

  int userId;
  UserRoles? role;

  @override
  State<ViewUserData> createState() => _ViewUserDataState();
}

class _ViewUserDataState extends State<ViewUserData> {
  late ApplicationUserModel user;

  bool edit = false;

  FocusNode next = FocusNode();
  CandidateDetailsDataSource dataSource = new CandidateDetailsDataSource();
  String? from;
  String? to;

  @override
  Widget build(BuildContext context) {
    return CIA_FutureBuilder(
      loadFunction: UserAPI.GetUserData(widget.userId),
      onSuccess: (data) {
        user = data as ApplicationUserModel;
        if (user.role == "candidate") siteController.setAppBarWidget(tabs: ["Profile", "Data"]);
        return PageView(
          controller: tabsController,
          onPageChanged: (value) {
            from = null;
            to = null;
          },
          children: [
            Column(
              children: [
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
                                            Expanded(child: FormTextKeyWidget(text: "ID")),
                                            Expanded(child: FormTextValueWidget(text: user.idInt.toString() == null ? "" : user.idInt.toString()))
                                          ],
                                        ),
                                        edit
                                            ? CIA_TextFormField(
                                                label: "Name",
                                                onChange: (v) => user.name = v,
                                                controller: TextEditingController(text: user.name == null ? "" : user.name),
                                              )
                                            : Row(
                                                children: [
                                                  Expanded(child: FormTextKeyWidget(text: "Name")),
                                                  Expanded(child: FormTextValueWidget(text: user.name == null ? "" : user.name))
                                                ],
                                              ),
                                        Row(
                                          children: [
                                            Expanded(child: FormTextKeyWidget(text: "Date of birth")),
                                            Expanded(child: FormTextValueWidget(text: user.dateOfBirth == null ? "" : user?.dateOfBirth))
                                          ],
                                        ),
                                        edit
                                            ? CIA_TextFormField(
                                                label: "Phone",
                                                isNumber: true,
                                                onChange: (v) => user.phoneNumber = v,
                                                controller: TextEditingController(text: user.phoneNumber == null ? "" : user.phoneNumber),
                                              )
                                            : Row(
                                                children: [
                                                  Expanded(child: FormTextKeyWidget(text: "Phone")),
                                                  Expanded(child: FormTextValueWidget(text: user.phoneNumber == null ? "" : user.phoneNumber))
                                                ],
                                              ),
                                        Row(
                                          children: [
                                            Expanded(child: FormTextKeyWidget(text: "Gender")),
                                            Expanded(child: FormTextValueWidget(text: user.gender == null ? "" : user.gender))
                                          ],
                                        ),
                                        edit
                                            ? CIA_TextFormField(
                                                label: "Graduated From",
                                                onChange: (v) => user.graduatedFrom = v,
                                                controller: TextEditingController(text: user.graduatedFrom == null ? "" : user.graduatedFrom),
                                              )
                                            : Row(
                                                children: [
                                                  Expanded(child: FormTextKeyWidget(text: "Graduated From")),
                                                  Expanded(child: FormTextValueWidget(text: user?.graduatedFrom == null ? "" : user?.graduatedFrom))
                                                ],
                                              ),
                                        edit
                                            ? CIA_TextFormField(
                                                label: "Class Year",
                                                onChange: (v) => user.classYear = v,
                                                controller: TextEditingController(text: user.classYear == null ? "" : user.classYear),
                                              )
                                            : Row(
                                                children: [
                                                  Expanded(child: FormTextKeyWidget(text: "Class Year")),
                                                  Expanded(child: FormTextValueWidget(text: user.classYear == null ? "" : user.classYear))
                                                ],
                                              ),
                                        edit
                                            ? CIA_TextFormField(
                                                label: "Speciality",
                                                onChange: (v) => user.speciality = v,
                                                controller: TextEditingController(text: user.speciality == null ? "" : user.speciality),
                                              )
                                            : Row(
                                                children: [
                                                  Expanded(child: FormTextKeyWidget(text: "Speciality")),
                                                  Expanded(child: FormTextValueWidget(text: user?.speciality == null ? "" : user.speciality))
                                                ],
                                              ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: FormTextKeyWidget(
                                              text: "Registration: " + (user.registeredBy == null ? "" : user.registeredBy!.name as String),
                                              secondaryInfo: true,
                                            )),
                                            Expanded(
                                                child: FormTextValueWidget(
                                              text: user!.registerationDate ?? "",
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
                                        Expanded(child: Image(image: AssetImage("assets/ProfileImage.png"))),
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
                                          child: CIA_SecondaryButton(label: "Cancel", onTab: () => setState(() => edit = false)),
                                        ),
                                        Flexible(
                                          child: CIA_PrimaryButton(
                                              label: "Save",
                                              isLong: true,
                                              onTab: () async {
                                                var res = await UserAPI.UpdateUserInfo(user);
                                                if (res.statusCode == 200) {
                                                  user = res.result as ApplicationUserModel;
                                                  ShowSnackBar(isSuccess: true, title: "Success", message: "User Updated!");
                                                  setState(() => edit = false);
                                                } else
                                                  ShowSnackBar(isSuccess: false, title: "Failed", message: res.errorMessage ?? "");
                                              }),
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
            user.role == "candidate"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: SizedBox()),
                          Expanded(
                              child: CIA_DateTimeTextFormField(
                            label: "From",
                            controller: TextEditingController(),
                            onChange: (v){
                                  from = v;
                                  dataSource.loadData(widget.userId, (v) {
                                    _getx.totalImplants.value = v;
                                  },from: from,to: to);
                            },
                          )),
                          SizedBox(width:10),
                          Expanded(
                              child: CIA_DateTimeTextFormField(
                            label: "to",
                            controller: TextEditingController(),
                                onChange: (v){
                                  to = v;
                                  dataSource.loadData(widget.userId, (v) {
                                    _getx.totalImplants.value = v;
                                  },from: from,to: to);
                                },
                          )),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                      Expanded(
                        child: CIA_Table(
                          columnNames: dataSource.columns,
                          dataSource: dataSource,
                          allowSorting: true,
                          loadFunction: () {
                            return dataSource.loadData(widget.userId, (v) {
                              _getx.totalImplants.value = v;
                            });
                          },
                        ),
                      ),
                      Obx(() => Container(
                            alignment: AlignmentDirectional.bottomEnd,
                            padding: EdgeInsets.only(bottom: 30),
                            child: Text(
                              "Total Implants: ${_getx.totalImplants.value.toString()}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          )),
                    ],
                  )
                : Container()
          ],
        );
      },
    );
  }

  @override
  void initState() {
    if (widget.role == UserRoles.Candidate) siteController.setAppBarWidget(tabs: ["Profile", "Data"]);
  }
}
