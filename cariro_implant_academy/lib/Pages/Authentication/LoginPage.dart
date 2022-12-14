import 'package:cariro_implant_academy/Pages/CIA_Pages/Dashboard.dart';
import 'package:cariro_implant_academy/Routes/Routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/Colors.dart';
import '../../Controllers/Auth_NavigationController.dart';
import '../../Widgets/CIA_PrimaryButton.dart';
import '../../Widgets/CIA_TextField.dart';
import 'RegsiterPage.dart';

Widget LoginPage(Function newRoute) {
  Auth_NavigationController auth_navigationController =
      Get.put(Auth_NavigationController());
  return Column(
    children: [
      Expanded(child: SizedBox()),
      Expanded(
        flex: 2,
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
                      Image(
                        image: AssetImage("CIA_Logo3.png"),
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
                        label: "Login",
                        onTab: ()=> Get.off(DashBoardPage(),duration: Duration(seconds: 0)),
                      ),
                      GestureDetector(
                        onTap: () {
                          newRoute(RegisterPageRoute);
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
