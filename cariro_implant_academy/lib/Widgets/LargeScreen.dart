import 'dart:convert';
import 'dart:typed_data';

import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/SiteController.dart';
import 'package:cariro_implant_academy/Helpers/Router.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/Pages/Authentication/AuthenticationPage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/CIA_MyProfilePage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/ViewUserPage.dart';
import 'package:cariro_implant_academy/core/features/notification/presentation/pages/NotificationsPage.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc_Events.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc_States.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/Drawer.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/features/patient/presentation/widgets/calendarWidget.dart';
import 'package:cariro_implant_academy/features/user/presentation/pages/viewUserProfile.dart';
import 'package:cariro_implant_academy/presentation/bloc/imagesBloc.dart';
import 'package:cariro_implant_academy/presentation/bloc/imagesBloc_States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../API/UserAPI.dart';
import '../Constants/Colors.dart';
import '../Models/NotificationModel.dart';
import '../core/features/authentication/presentation/pages/authentication_page.dart';
import '../core/injection_contianer.dart';
import '../core/presentation/widgets/LoadingWidget.dart';
import '../core/features/notification/presentation/widgets/notificationDropDownWidget.dart';
import 'CIA_PopUp.dart';

//TODO: Return to stateless
class CIA_LargeScreen extends StatefulWidget {
  CIA_LargeScreen({Key? key, required this.child}) : super(key: key);
  Widget child;

  @override
  State<CIA_LargeScreen> createState() => _CIA_LargeScreenState();
}

class _CIA_LargeScreenState extends State<CIA_LargeScreen> {
  late AppBarBloc appBarBloc;
  late ImageBloc imageBlocProfilesss;

  @override
  void initState() {
    appBarBloc = sl<AppBarBloc>();
    imageBlocProfilesss = sl<ImageBloc>();
    imageBlocProfilesss.reDownload = false;
    if (siteController.getProfileImageId() != null) imageBlocProfilesss.downloadImageEvent(siteController.getProfileImageId()!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (pagesController.hasClients) pagesController.jumpToPage(0);

    if (GoRouterState.of(context).fullPath! == "/") return AuthenticationPage();
    Logger("").log(Level.INFO, "Rebuilding large screen");
    return Row(
      children: [
        //TODO: Remove onrole change
        DrawerItems(
          //onSiteChange: () => null,
        ),
        Expanded(
            flex: 7,
            child: Column(
              children: [
                Container(
                  color: Color_Background,
                  height: 50,
                  child: BlocListener<AppBarBloc, AppBarBlocState>(
                    bloc: appBarBloc,
                    listener: (context, state) {
                      // if (state is AppBarNewNotificationState)
                      // BlocProvider.of<AppBarBloc>(context).add(AppBarGetNotificationsEvent());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BlocBuilder(
                          bloc: appBarBloc,
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
                            BlocConsumer<AppBarBloc, AppBarBlocState>(
                              bloc: appBarBloc,
                              listener: (context, state) {
                                if (state is AppBarMarkedNotificationsAsReadState) {
                                  appBarBloc.add(AppBarGetNotificationsEvent());
                                }
                              },
                              buildWhen: (previous, current) => current is AppBarNewNotificationState || current is AppBarNotificationsLoadedState,
                              builder: (context, state) {
                                var notifications = BlocProvider.of<AppBarBloc>(context).notifications;
                                return NotificationDropDownWidget(
                                  markAsRead: () {
                                    appBarBloc.add(AppBarMarkAllNotificationsAsReadEvent());
                                  },
                                  customButton: Icon(
                                    Icons.notifications,
                                    color: state is AppBarNewNotificationState ? Colors.red : null,
                                  ),
                                  hint: "omar",
                                  notifications: notifications,
                                );
                              },
                            ),
                            SizedBox(width: 20),
                            IconButton(
                                onPressed: () {
                                  CIA_ShowPopUp(
                                    context: context,
                                    width: 900,
                                    height: 600,
                                    title: "Calendar",
                                    child: CalendarWidget(
                                      getForDoctor: siteController.getRole() != "secretary",
                                      getAllSchedules: siteController.getRole() == "secretary",
                                    ),
                                  );
                                },
                                icon: Icon(Icons.calendar_month_sharp)),
                            SizedBox(width: 20),
                            BlocBuilder<ImageBloc, ImageBloc_State>(
                              bloc: imageBlocProfilesss,
                              builder: (context, state) {
                                Uint8List? image;
                                if (state is ImageLoadedState)
                                  image = state.image;
                                else if (state is ImageDownloadingState)
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(500.0),
                                    child: LoadingWidget(),
                                  );
                                return GestureDetector(
                                    onTap: () {
                                      context.goNamed(ViewUserProfilePage.getRouteName(), pathParameters: {"id": siteController.getUserId().toString()});
                                    },
                                    child: CircleAvatar(
                                      //borderRadius: BorderRadius.circular(500.0),
                                      backgroundImage: image == null
                                          ? AssetImage("assets/user.png") as ImageProvider
                                          : MemoryImage(
                                              image!,
                                            ),
                                    ));
                              },
                            ),
                            SizedBox(
                              width: 20,
                            )
                          ],
                        ))
                      ],
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
