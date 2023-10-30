import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/SignalR/SignalR.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc_Events.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/presentation/bloc/siteChange/siteChange_blocEvents.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/features/authentication/domain/usecases/loginUseCase.dart';
import 'package:cariro_implant_academy/core/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:cariro_implant_academy/core/features/authentication/presentation/bloc/authentication_blocEvents.dart';
import 'package:cariro_implant_academy/core/features/authentication/presentation/bloc/authentication_blocStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Constants/Colors.dart';
import '../../../../../Constants/Controllers.dart';
import '../../../../../Routes/Routes.dart';
import '../../../../../Widgets/CIA_PrimaryButton.dart';
import '../../../../../Widgets/CIA_TextFormField.dart';
import '../../../../injection_contianer.dart';
import '../../../../presentation/bloc/siteChange/siteChange_bloc.dart';
import '../../../../presentation/bloc/siteChange/siteChange_blocStates.dart';
import '../../../../../features/patient/presentation/pages/patientsSearchPage.dart';
import '../../../../../presentation/widgets/customeLoader.dart';

class AuthenticationPage extends StatefulWidget {
  AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  String _email = "";

  String _password = "";

  final String routeName = "AuthenticationPage1";

  late AuthenticationBloc authenticationBloc;

  @override
  void initState() {
      authenticationBloc = sl<AuthenticationBloc>();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    authenticationBloc = context.read<AuthenticationBloc>();
    if (siteController.getSite() == null) siteController.setSite(Website.CIA);
    return BlocListener<AuthenticationBloc, Authentication_blocState>(
      listener: (context, state) {
        if (state is LoggingInState)
          CustomLoader.show(context);
        else if (state is ErrorState)
          ShowSnackBar(context, isSuccess: false, message: state.message);
        else if (state is LoggedIn) {
          sl<SignalR>();
          //sl<AppBarBloc>().add(AppBarGetNotificationsEvent());
          if (siteController.getSite() == Website.CIA || siteController.getSite()==Website.Clinic)
            context.goNamed(PatientsSearchPage.routeName);
        }
        if (state is! LoggingInState) CustomLoader.hide();
      },
      child: BlocBuilder<SiteChangeBloc, SiteChangeBlocStates>(builder: (context, state) {
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
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 60,
                              child: DefaultTabController(
                                length: 3,
                                initialIndex: 0,
                                child: TabBar(
                                    labelColor: Colors.black,
                                    indicatorColor: Color_Accent,
                                    tabs: [
                                      Tab(text: "CIA"),
                                      Tab(text: "LAB"),
                                      Tab(text: "Clinic"),
                                    ],
                                    onTap: (value) => BlocProvider.of<SiteChangeBloc>(context).add(SetSiteEvent(Website.values[value]))),
                              ),
                            ),
                            Expanded(
                              child: /*isLoggedIn
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
                                              await siteController.removeToken();
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
                                                      Text(siteController.getUser().name!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
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
                                        : */
                                  Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image(
                                    image: siteController.getSiteLogo(),
                                    width: 150,
                                    height: 80,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  Visibility(
                                    visible: !siteController.isLoggedIn(),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 30),
                                      child: CIA_TextFormField(
                                        onChange: (value) => _email = value,
                                        onSubmit: (value) => dispatchLogin(context),
                                        label: "Email",
                                        controller: TextEditingController(text: _email),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !siteController.isLoggedIn(),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 30),
                                        child: CIA_TextFormField(
                                          onChange: (value) => _password = value,
                                          onSubmit: (value) => dispatchLogin(context),
                                          label: "Password",
                                          isObscure: true,
                                          controller: TextEditingController(text: _password),
                                        )),
                                  ),
                                  CIA_PrimaryButton(
                                    label: "Login",
                                    onTab: () => dispatchLogin(context),
                                  ),
                                  Visibility(
                                    visible: siteController.isLoggedIn(),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Welcome ${siteController.getUserName()}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Click here to logout",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        IconButton(onPressed: () {
                                          siteController.clearCach();
                                          setState(() {
                                          });
                                        }, icon: Icon(Icons.logout))
                                      ],
                                    ),
                                  ),
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
      }),
    );
  }

  dispatchLogin(BuildContext context) {
    authenticationBloc.logInEvent(LoginParams(email: _email, password: _password));
  }
}
