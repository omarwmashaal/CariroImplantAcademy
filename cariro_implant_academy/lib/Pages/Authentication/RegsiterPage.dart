
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Routes/Routes.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/CardWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants/Colors.dart';
import '../../Widgets/CIA_PrimaryButton.dart';
import '../../Widgets/CIA_TextField.dart';

Widget RegisterPage(Function newRoute)
{
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
              child: CardWidget(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30),
                          child: CIA_TextField(label: "Password", isObscure: true,)
                      ),
                      CIA_PrimaryButton(label: "Register",onTab: (){},),

                      GestureDetector(
                        onTap: ()=> newRoute(LoginPageRoute),
                        child: Text("Don't have an account? Create new one.", style: TextStyle(
                            color: Color_TextSecondary,
                            decoration: TextDecoration.underline
                        ),),
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
