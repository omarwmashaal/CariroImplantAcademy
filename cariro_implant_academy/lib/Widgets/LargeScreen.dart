import 'dart:convert';

import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/SiteController.dart';
import 'package:cariro_implant_academy/Helpers/Router.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Pages/Authentication/AuthenticationPage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/CIA_MyProfilePage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/PatientsSearchPage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/ViewUserPage.dart';
import 'package:cariro_implant_academy/Pages/NotificationsPage.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc_Events.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc_States.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/Drawer.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../API/UserAPI.dart';
import '../Constants/Colors.dart';
import '../Models/NotificationModel.dart';
import '../core/injection_contianer.dart';
import 'CIA_DropDown2.dart';

//TODO: Return to stateless
class CIA_LargeScreen extends StatefulWidget {
  CIA_LargeScreen({Key? key, required this.child}) : super(key: key);
  Widget child;

  @override
  State<CIA_LargeScreen> createState() => _CIA_LargeScreenState();
}

class _CIA_LargeScreenState extends State<CIA_LargeScreen> {
  @override
  Widget build(BuildContext context) {
    if (pagesController.hasClients) pagesController.jumpToPage(0);

    if (GoRouter.of(context).location == "/") return AuthenticationPage();

    Logger("").log(Level.INFO, "Rebuilding large screen");
    return Row(
      children: [
        //TODO: Remove onrole change
        DrawerItems(
          onSiteChange: () => setState(
            () {},
          ),
        ),
        Expanded(
            flex: 7,
            child: Column(
              children: [
                Container(
                  color: Color_Background,
                  height: 50,
                  child: BlocProvider<AppBarBloc>(
                    create: (context) => sl<AppBarBloc>(),
                    child: BlocListener<AppBarBloc, AppBarBlocState>(
                      bloc: sl<AppBarBloc>(),
                      listener: (context, state) {
                        if (state is AppBarNewNotificationState) BlocProvider.of<AppBarBloc>(context).add(AppBarGetNotificationsEvent());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BlocBuilder(
                            bloc: sl<AppBarBloc>(),
                            buildWhen: (previous, current) => current is AppBarChangedState,
                            builder: (context, state) {
                              if (state is AppBarChangedState) return state.newAppBar ?? Container();
                              return Container();
                            },
                          ),
                          //GetBuilder<SiteController>(builder: (siteController) => siteController.appBarWidget),
                          Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.goNamed(NotificationsPage.routeName);
                                    },
                                    child: Text("View All Notifications"),
                                  ),
                                  BlocBuilder<AppBarBloc,AppBarBlocState>(
                                    buildWhen: (previous, current) => current is AppBarNewNotificationState || current is AppBarNotificationsLoadedState,
                                    builder:(context, state) {
                                      var notifications = BlocProvider.of<AppBarBloc>(context).notifications;
                                      return CIA_NotificationsWidget(
                                        customButton: Icon(
                                          Icons.notifications,
                                          color: state is AppBarNewNotificationState ? Colors.red
                                              : null,
                                        ),
                                        hint: "omar",
                                        notifications:notifications ,
                                      );
                                    },),

                                  SizedBox(width: 30),
                                  /*CIA_FutureBuilder(loadFunction: () async {
                              if (siteController.getUser().profileImageId != null && siteController.getProfilePicture() == null)
                                Logger("").log(Level.INFO, "Download Image from large screen");
                              await UserAPI.DownloadImage(siteController.getUser().profileImageId!).then(
                                (value) {
                                  if (value.statusCode == 200) siteController.setProfilePicture(base64Decode(value.result as String));
                                },
                              );
                              return API_Response(statusCode: 200);
                            }(), onSuccess: (data) {
                              return GestureDetector(
                                  onTap: () {
                                    context.goNamed(ViewUserData.routeName, pathParameters: {"id": siteController.getUser().idInt.toString()});
                                  },
                                  child: siteController.getProfilePicture() == null
                                      ? Image.asset("assets/user.png")
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(500.0),
                                          child: Image(
                                            image: MemoryImage(
                                              siteController.getProfilePicture()!,
                                            ),
                                          ),
                                        ));
                            }),*/
                                  SizedBox(
                                    width: 20,
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Color_Background,
                    child: widget.child,
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
