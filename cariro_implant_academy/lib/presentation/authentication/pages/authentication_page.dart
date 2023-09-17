
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/presentation/bloc/siteChange/siteChange_blocEvents.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/domain/authentication/useCases/loginUseCase.dart';
import 'package:cariro_implant_academy/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:cariro_implant_academy/presentation/authentication/bloc/authentication_blocEvents.dart';
import 'package:cariro_implant_academy/presentation/authentication/bloc/authentication_blocStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../Constants/Colors.dart';
import '../../../Constants/Controllers.dart';
import '../../../Routes/Routes.dart';
import '../../../Widgets/CIA_PrimaryButton.dart';
import '../../../Widgets/CIA_TextFormField.dart';
import '../../../core/injection_contianer.dart';
import '../../../core/presentation/bloc/siteChange/siteChange_bloc.dart';
import '../../../core/presentation/bloc/siteChange/siteChange_blocStates.dart';
import '../../../features/patient/presentation/presentation/patientsSearchPage.dart';
import '../../widgets/customeLoader.dart';

class AuthenticationPage extends StatelessWidget {
  AuthenticationPage({Key? key}) : super(key: key);
  String _email = "";
  String _password = "";
  final String routeName = "AuthenticationPage1";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => sl<AuthenticationBloc>(),
      child: BlocListener<AuthenticationBloc, Authentication_blocState>(
        listener: (context, state) {
          if (state is LoggingInState)
            CustomLoader.show(context);
          else if (state is ErrorState)
            ShowSnackBar(context, isSuccess: false, message: state.message);
          else if (state is LoggedIn) context.goNamed(PatientsSearchPage.routeName);
          if (state is! LoggingInState) CustomLoader.hide();
        },
        child: BlocBuilder<SiteChangeBloc, SiteChangeBlocStates>(
            builder: (context, state) {
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 30),
                                      child: CIA_TextFormField(
                                        onChange: (value) => _email = value,
                                        onSubmit: (value) => dispatchLogin(context),
                                        label: "Email",
                                        controller: TextEditingController(text: _email),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 30),
                                        child: CIA_TextFormField(
                                          onChange: (value) => _password = value,
                                          onSubmit: (value) => dispatchLogin(context),
                                          label: "Password",
                                          isObscure: true,
                                          controller: TextEditingController(text: _password),
                                        )),
                                    CIA_PrimaryButton(
                                      label: "Login",
                                      onTab: () => dispatchLogin(context),
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
      ),
    );
  }

  dispatchLogin(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(LogInEvent(LoginParams(email: _email, password: _password)));
  }
}
