import 'dart:convert';
import 'dart:typed_data';

import 'package:cariro_implant_academy/API/AuthenticationAPI.dart';
import 'package:cariro_implant_academy/API/UserAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/CandidateDetails.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Models/VisitsModel.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Patient_MedicalInfo.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:logging/logging.dart';


import '../../Widgets/Title.dart';
import '../../core/constants/enums/enums.dart';
import '../../features/patientsMedical/treatmentFeature/presentation/pages/surgicalTreatmentPage.dart';
import '../../features/patientsMedical/treatmentFeature/presentation/pages/treatmentPlanPage.dart';
import '../../features/user/domain/entities/enum.dart';

class _getx extends GetxController {
  static RxInt totalImplants = 0.obs;
  static Rx<Duration> duration = Duration().obs;
}
/*
class ViewUserData extends StatefulWidget {
  ViewUserData({Key? key, required this.userId, this.role}) : super(key: key);
  static String routeName = "UserProfile";
  static String routePath = "User/:id/UserProfile";
  static String candidateRouteName = "CandidateProfile";
  static String candidateRoutePath = "Candidate/:id/CandidateProfile";
  int userId;
  UserRoles? role;

  @override
  State<ViewUserData> createState() => _ViewUserDataState();
}

class _ViewUserDataState extends State<ViewUserData> {
  late ApplicationUserModel user;

  bool edit = false;
  bool photoChanged = false;

  FocusNode next = FocusNode();
  CandidateDetailsDataSource dataSource = new CandidateDetailsDataSource();
  String? from;
  String? to;
  Uint8List? profileImageBytes;
  double imageWidth = 200;
  double imageHeight = 200;

  @override
  Widget build(BuildContext context) {
    return CIA_FutureBuilder(
      loadFunction: UserAPI.GetUserData(widget.userId),
      onSuccess: (data) {
        user = data as ApplicationUserModel;
        return Column(
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
                                        TitleWidget(title: "User Profile"),
                                        SizedBox(width: 10),
                                        () {
                                          if (widget.userId == siteController.getUser().idInt) {
                                            return CIA_SecondaryButton(
                                                label: "Reset Password",
                                                onTab: () {
                                                  String oldPassword = "";
                                                  String newPassword1 = "";
                                                  String newPassword2 = "";
                                                  bool capital = false;
                                                  bool small = false;
                                                  bool number = false;
                                                  bool symbol = false;
                                                  CIA_ShowPopUp(
                                                      context: context,
                                                      height: 300,
                                                      onSave: () async {
                                                        if (newPassword2 != newPassword1) {
                                                          ShowSnackBar(context, isSuccess: false, message: "Passwords dont match");
                                                          return false;
                                                        } else {
                                                          var res = await AuthenticationAPI.ResetPassword(oldPassword, newPassword1, newPassword2);
                                                          ShowSnackBar(context,
                                                              isSuccess: res.statusCode == 200,
                                                              message: res.statusCode == 200
                                                                  ? "Password reset successfully"
                                                                  : "Failed to reset password: ${res.errorMessage}");
                                                          if (res.statusCode == 200)
                                                            return true;
                                                          else
                                                            return false;
                                                        }
                                                      },
                                                      child: StatefulBuilder(builder: (context, _setState) {
                                                        return Column(
                                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                                          children: [
                                                            CIA_TextFormField(
                                                              label: "Old Password",
                                                              controller: TextEditingController(text: oldPassword),
                                                              isObscure: true,
                                                              onChange: (v) => _setState(() {
                                                                oldPassword = v;
                                                              }),
                                                            ),
                                                            SizedBox(height: 10),
                                                            CIA_TextFormField(
                                                              label: "New Password",
                                                              controller: TextEditingController(text: newPassword1),
                                                              isObscure: true,
                                                              onChange: (v) {
                                                                if (v.contains(RegExp(r'[A-Z]')))
                                                                  capital = true;
                                                                else
                                                                  capital = false;
                                                                if (v.contains(RegExp(r'[a-z]')))
                                                                  small = true;
                                                                else
                                                                  small = false;
                                                                if (v.contains(RegExp(r'[0-9]')))
                                                                  number = true;
                                                                else
                                                                  number = false;
                                                                if (v.contains(RegExp(r'(?=.*?[!@#\$&*~.])')))
                                                                  symbol = true;
                                                                else
                                                                  symbol = false;
                                                                _setState(() => newPassword1 = v);
                                                              },
                                                            ),
                                                            SizedBox(height: 10),
                                                            CIA_TextFormField(
                                                              label: "Repeat New Password",
                                                              controller: TextEditingController(text: newPassword2),
                                                              isObscure: true,
                                                              errorFunction: (value) {
                                                                return value != newPassword1;
                                                              },
                                                              onChange: (v) => _setState(() => newPassword2 = v),
                                                            ),
                                                            SizedBox(height: 10),
                                                            Text(
                                                              newPassword1.isEmpty
                                                                  ? "Password can't be empty"
                                                                  : newPassword2 == newPassword1
                                                                      ? "Passwords match"
                                                                      : "Passwords don't match",
                                                              style: TextStyle(
                                                                  color: newPassword2 == newPassword1 && newPassword1.isNotEmpty ? Colors.green : Colors.red,
                                                                  fontSize: 15),
                                                            ),
                                                            Text(
                                                              "Contains at least 1 Capital Letter",
                                                              style: TextStyle(
                                                                color: capital ? Colors.green : Colors.red,
                                                                fontSize: 15,
                                                              ),
                                                              textAlign: TextAlign.start,
                                                            ),
                                                            Text(
                                                              "Contains at least 1 Small Letter",
                                                              style: TextStyle(color: small ? Colors.green : Colors.red, fontSize: 15),
                                                            ),
                                                            Text(
                                                              "Contains at least 1 Number",
                                                              style: TextStyle(color: number ? Colors.green : Colors.red, fontSize: 15),
                                                            ),
                                                            Text(
                                                              "Contains at least 1 Symbol",
                                                              style: TextStyle(color: symbol ? Colors.green : Colors.red, fontSize: 15),
                                                            ),
                                                            SizedBox(height: 10),
                                                          ],
                                                        );
                                                      }));
                                                });
                                          } else
                                            return Container();
                                        }(),
                                        SizedBox(width: 10),
                                        CIA_SecondaryButton(
                                            label: "Sessions Duration",
                                            onTab: () async {
                                              String? from;
                                              String? to;
                                              VisitDataSource dataSource = VisitDataSource(sessions: true);
                                              CIA_ShowPopUp(
                                                width: 1000,
                                                height: 900,
                                                context: context,
                                                child: StatefulBuilder(
                                                  builder: (context,_setState) {
                                                    return Column(
                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Expanded(
                                                              child: CIA_DateTimeTextFormField(
                                                                label: "From",
                                                                controller: TextEditingController(text: from ?? ""),
                                                                onChange: (v) => _setState(()=>from=v),
                                                              ),
                                                            ),
                                                            IconButton(onPressed: ()=>_setState(()=>from=null), icon: Icon(Icons.remove)),
                                                            SizedBox(width:10),
                                                            Expanded(
                                                              child: CIA_DateTimeTextFormField(
                                                                label: "To",
                                                                controller: TextEditingController(text: to ?? ""),
                                                                onChange: (v) => _setState(()=>to=v),
                                                              ),
                                                            ),
                                                            IconButton(onPressed: ()=>_setState(()=>to=null), icon: Icon(Icons.remove)),
                                                          ],
                                                        ),
                                                        SizedBox(height:10),
                                                        Obx(() => Container(width:double.infinity, child: Center(child: FormTextKeyWidget(text:"Duration: ${ _getx.duration.value.toString()}")))),
                                                        SizedBox(height:10),
                                                        Expanded(
                                                          child: CIA_Table(
                                                            columnNames: dataSource.columns,
                                                            dataSource: dataSource,
                                                            loadFunction: () async{
                                                              var res = await dataSource.loadSessions(id: widget.userId, from: from, to: to);
                                                              _getx.duration.value = res;
                                                              return res;
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  }
                                                ),
                                              );
                                            })
                                      ],
                                    ),
                                    SizedBox(height: 10),
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
                                child: CIA_FutureBuilder(
                                  loadFunction: () async {
                                    if (user.profileImageId != null) {
                                      Logger("").log(Level.INFO, "Download Image from VIEW USER screen");
                                      await UserAPI.DownloadImage(user.profileImageId!).then(
                                        (value) {
                                          if (value.statusCode == 200) profileImageBytes = base64Decode(value.result as String);
                                        },
                                      );
                                    }
                                    return Future.value(API_Response(statusCode: 200));
                                  }(),
                                  onSuccess: (data) {
                                    return Column(
                                      children: [
                                        profileImageBytes == null
                                            ? Image(
                                                image: AssetImage("assets/ProfileImage.png"),
                                                height: imageHeight,
                                                width: imageWidth,
                                              )
                                            : Image(
                                                image: MemoryImage(profileImageBytes!),
                                                height: imageHeight,
                                                width: imageWidth,
                                              ),
                                        Visibility(
                                            visible: edit,
                                            child: CIA_SecondaryButton(
                                                label: "Upload Image",
                                                onTab: () async {
                                                  var temp = profileImageBytes;
                                                  profileImageBytes = await ImagePickerWeb.getImageAsBytes();
                                                  if (temp != profileImageBytes) photoChanged = true;
                                                  setState(() {});
                                                })),
                                      ],
                                    );
                                  },
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
                                              ShowSnackBar(context, isSuccess: true, title: "Success", message: "User Updated!");
                                              if (photoChanged && profileImageBytes != null) {
                                                res = await UserAPI.UploadImage(widget.userId, EnumImageType.UserProfile, profileImageBytes!);
                                                ShowSnackBar(context,
                                                    isSuccess: res.statusCode == 200,
                                                    message: res.statusCode != 200 ? "Failed to change photo" : "Photo Uploaded!");
                                              }
                                              setState(() {
                                                edit = false;
                                                photoChanged = false;
                                              });
                                            } else
                                              ShowSnackBar(context, isSuccess: false, title: "Failed", message: res.errorMessage ?? "");
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
        );
      },
    );
  }

  @override
  void initState() {
    //if (widget.role == UserRoles.Candidate) siteController.setAppBarWidget(tabs: ["Profile", "Data"]);
  }
}
*/
class ViewCandidateData extends StatefulWidget {
  ViewCandidateData({Key? key, required this.userId}) : super(key: key);
  int userId;
  static String routeName = "CandidateDetails";
  static String routePath = "Candidate/:id/CandidateDetails";

  @override
  State<ViewCandidateData> createState() => _ViewCandidateDataState();
}

class _ViewCandidateDataState extends State<ViewCandidateData> {
  bool edit = false;
  late ApplicationUserModel user;
  FocusNode next = FocusNode();
  CandidateDetailsDataSource dataSource = new CandidateDetailsDataSource();
  String? from;
  String? to;

  @override
  Widget build(BuildContext context) {
    return Container();/*
    return CIA_FutureBuilder(
      loadFunction: UserAPI.GetUserData(widget.userId),
      onSuccess: (data) {
        user = data as ApplicationUserModel;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                    child: CIA_DateTimeTextFormField(
                  label: "From",
                  controller: TextEditingController(),
                  onChange: (v) {
                    from = v;
                    dataSource.loadData(widget.userId, (v) {
                      _getx.totalImplants.value = v;
                    }, from: from, to: to);
                  },
                )),
                SizedBox(width: 10),
                Expanded(
                    child: CIA_DateTimeTextFormField(
                  label: "to",
                  controller: TextEditingController(),
                  onChange: (v) {
                    to = v;
                    dataSource.loadData(widget.userId, (v) {
                      _getx.totalImplants.value = v;
                    }, from: from, to: to);
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
                onCellClick: (index) {

                  if (index != 0)
                    context.goNamed(SurgicalTreatmentPage.routeName, pathParameters: {'id': dataSource.effectiveRows.elementAt(index-1).getCells().first.value.toString()});
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
        );
      },
    );*/
  }
}
