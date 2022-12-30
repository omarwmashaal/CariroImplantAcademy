import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/PagesController.dart';
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
                              print(value);
                              //selectedTab = value;
                              if (value == 0) {
                                selectedTab = "CIA";
                                setState(() => siteController.setSite("CIA"));
                              } else if (value == 1) {
                                selectedTab = "LAB";
                                setState(() => siteController.setSite("LAB"));
                              } else {
                                selectedTab = "Clinic";
                                setState(
                                    () => siteController.setSite("Clinic"));
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
                            label: "Email",
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: CIA_TextField(
                              label: "Password",
                              isObscure: true,
                            )),
                        CIA_PrimaryButton(
                            label: "Login", onTab: () => widget.onLogin()),
                        HorizontalRadioButtons(
                          names: siteController.getRoles(),
                          onChange: (index) {
                            siteController.setRole(index);
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.onRegister();
                            //navigationController_Auth.navigateTo(RegisterPageRoute);
                          },
                          child: Text(
                            "Don't have an account? Create new one.",
                            style: TextStyle(
                                color: Color_TextSecondary,
                                decoration: TextDecoration.underline),
                          ),
                        ),
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
