import 'package:cariro_implant_academy/API/AuthenticationAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/PagesController.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/SlidingTab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/Colors.dart';
import '../../Controllers/Auth_NavigationController.dart';
import '../../Widgets/CIA_FutureBuilder.dart';
import '../../Widgets/CIA_PrimaryButton.dart';
import '../../Widgets/CIA_TextField.dart';
import '../../Widgets/FormTextWidget.dart';
import '../../Widgets/Horizontal_RadioButtons.dart';
/*
class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.onLogin, required this.onRegister}) : super(key: key);
  Auth_NavigationController auth_navigationController = Get.put(Auth_NavigationController());
  Function onLogin;
  Function onRegister;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  Color selectedTabColor = Color_Accent;
  String selectedTab = "CIA";
  late TabController tabController;
  String _email = "";
  String _password = "";

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this,initialIndex: (){
      if(siteController.getSite()==Website.CIA) return 0;
      else if(siteController.getSite()==Website.Lab) return 1;
      else if(siteController.getSite()==Website.Clinic) return 2;
      else return 0;

    }());
  }

  @override
  Widget build(BuildContext context) {
   // tabController.index = 0;
    return FutureBuilder(
      future: AuthenticationAPI.VerifyToken(),
      builder: (context, snapshot) {
        bool isLoggedIn = false;
        if(snapshot.hasData)
        {

          isLoggedIn= (snapshot.data as API_Response).statusCode==200;

        }
        return  Column(
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
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 60,
                              child: TabBar(
                                controller: tabController,
                                labelColor: Colors.black,
                                indicatorColor: Color_Accent,
                                tabs: [
                                  Tab(text: "CIA"),
                                  Tab(text: "LAB"),
                                  Tab(text: "Clinic"),
                                ],
                                onTap: (value) {
                                  if (value == 0) {
                                    setState(() => siteController.setSite(Website.CIA));
                                  } else if (value == 1) {
                                    setState(() => siteController.setSite(Website.Lab));
                                  } else {
                                    setState(() => siteController.setSite(Website.Clinic));
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: isLoggedIn
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image(
                                    image: siteController.getSiteLogo(),
                                    width: 150,
                                    height: 80,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 60,
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: GestureDetector(
                                      onTap:()async{
                                        await siteController.clearCach();
                                        setState(() {
                                        });
                                      },
                                      child: Card(
                                        shadowColor: Colors.black,
                                        elevation: 1,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("Welcome ",style: TextStyle(fontSize: 20),),
                                                //Text(siteController.getUser().name!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                            Text("Click to log in with different account",style: TextStyle(fontSize: 15))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  CIA_PrimaryButton(label: "Login", onTab: () => widget.onLogin(_email, _password)),

                                ],
                              )
                                  : Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image(
                                    image: siteController.getSiteLogo(),
                                    width: 150,
                                    height: 80,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30),
                                    child: CIA_TextFormField(
                                      onChange: (value) => _email = value,
                                      onSubmit: (value) => widget.onLogin(_email, _password),
                                      label: "Email",
                                      controller: TextEditingController(text: _email),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 30),
                                      child: CIA_TextFormField(
                                        onChange: (value) => _password = value,
                                        onSubmit: (value) => widget.onLogin(_email, _password),
                                        label: "Password",
                                        isObscure: true,
                                        controller: TextEditingController(text: _password),
                                      )),
                                  CIA_PrimaryButton(label: "Login", onTab: () => widget.onLogin(_email, _password)),
                                ],
                              ),
                            )
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

    },);
  }
}
*/