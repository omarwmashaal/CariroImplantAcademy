import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/PagesController.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Widgets/SlidingTab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/Colors.dart';
import '../../Controllers/Auth_NavigationController.dart';
import '../../Widgets/CIA_PrimaryButton.dart';
import '../../Widgets/CIA_TextField.dart';
import '../../Widgets/Horizontal_RadioButtons.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.onLogin, required this.onRegister})
      : super(key: key);
  Auth_NavigationController auth_navigationController =
      Get.put(Auth_NavigationController());
  Function onLogin;
  Function onRegister;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color selectedTabColor = Color_Accent;
  String selectedTab = "CIA";
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: SizedBox()),
        Expanded(
          flex: 3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 3, child: SizedBox()),
              Expanded(
                flex: 4,
                child: Card(
                    elevation: 1,
                    shadowColor: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SlidingTab(
                            titles: ["CIA", "LAB", "Clinic"],
                            onChange: (value) {
                              if (value == 0) {
                                selectedTab = "CIA";
                                setState(() => siteController.setSite(Website.CIA));
                              } else if (value == 1) {
                                selectedTab = "LAB";
                                setState(() => siteController.setSite(Website.Lab));
                              } else {
                                selectedTab = "Clinic";
                                setState(
                                    () => siteController.setSite(Website.Clinic));
                              }
                            },
                            weight: 450,
                            controller: TabsController()),
                        Image(
                          image: siteController.getSiteLogo(),
                          width: 150,
                          height: 80,
                          fit: BoxFit.fitHeight,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: CIA_TextField(
                            onChange: (value) => email = value,
                            label: "Email",
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: CIA_TextField(
                              onChange: (value) => password = value,
                              label: "Password",
                              isObscure: true,
                            )),
                        CIA_PrimaryButton(
                            label: "Login",
                            onTab: () => widget.onLogin(email, password)),


                      ],
                    )),
              ),
              Expanded(flex: 3, child: SizedBox()),
            ],
          ),
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }
}
