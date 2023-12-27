import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Constants/Fonts.dart';
import 'package:cariro_implant_academy/Controllers/PagesController.dart';
import 'package:cariro_implant_academy/SignalR/SignalR.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc_States.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/pages/LabRequestsSearchPage.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';

import '../core/constants/enums/enums.dart';
import '../Pages/CIA_Pages/CIA_SettingsPage.dart';
import '../core/features/settings/presentation/pages/WebsiteSettingsPage.dart';
import '../core/injection_contianer.dart';
import '../core/presentation/widgets/CIA_GestureWidget.dart';
import '../features/patient/presentation/pages/patientsSearchPage.dart';
import 'FormTextWidget.dart';

List<String> roles = ["Secretary", "Admin", "Instructor"];

class DrawerItems extends StatefulWidget {
  DrawerItems({Key? key, this.onRoleChange}) : super(key: key);

  Function? onRoleChange;

  @override
  State<DrawerItems> createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  double radius = 30;

  SidebarXController ss = SidebarXController(selectedIndex: 0, extended: false);

  @override
  Widget build(BuildContext context) {

    return BlocListener<AppBarBloc, AppBarBlocState>(
      listener: (context, state) {
        if (state is DrawerSetIndex) ss.selectIndex(state.index);
      },
      child: Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey, //New
              blurRadius: 0.1,
              spreadRadius: 0.001,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: SidebarX(
          controller: ss,
          headerBuilder: (context, extended) {
            return Image(
              image: siteController.getSiteLogo(),
              width: extended ? 100 : 40,
              height: extended ? 100 : 40,
              fit: BoxFit.contain,
            );
          },
          items: PagesController.DrawerItems(context, ss),
          showToggleButton: true,
          theme: SidebarXTheme(
            selectedItemDecoration: BoxDecoration(
              color: Color_DrawerHover,
              borderRadius: BorderRadius.circular(8),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: Colors.white,
            ),
          ),
          extendedTheme: SidebarXTheme(
            width: 200,
            selectedTextStyle: TextStyle(fontSize: 20, fontFamily: Inter_Bold),
            textStyle: TextStyle(fontSize: 16, fontFamily: Inter_Medium, color: Colors.black),
            hoverColor: Color_DrawerHover,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: Colors.white,
            ),
          ),
          footerBuilder: (context, extended) {
            List<Widget> children = [
              CIA_GestureWidget(
                onTap: () {
                  siteController.setSite(Website.CIA);
                  context.goNamed(PatientsSearchPage.getRouteName());
                },
                child: Image(
                  image: siteController.getSiteLogoBySite(Website.CIA),
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: extended ? 10 : 0,
                height: extended ? 0 : 10,
              ),
              CIA_GestureWidget(
                onTap: () {
                  siteController.setSite(Website.Lab);
                  context.goNamed(LabRequestsSearchPage.routeName);
                },
                child: Image(
                  image: siteController.getSiteLogoBySite(Website.Lab),
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: extended ? 10 : 0,
                height: extended ? 0 : 10,
              ),
              CIA_GestureWidget(
                onTap: () {
                  siteController.setSite(Website.Clinic);
                  context.goNamed(PatientsSearchPage.getRouteName(site: Website.Clinic));
                },
                child: Image(
                  image: siteController.getSiteLogoBySite(Website.Clinic),
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
              ),
            ];
            return (!siteController.getRole()!.contains("admin"))
                ? Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.logout),
                          color: Colors.red,
                          onPressed: () {
                            siteController.clearCach();
                            sl<SignalR>().disconnect();
                            context.go("/");
                          },
                        ),
                        FormTextValueWidget(text: "Logout"),
                      ],
                    ),
                  )
                : Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Divider(),
                          FormTextKeyWidget(text: extended ? "Switch Sites" : ""),
                          SizedBox(height: 20),
                          extended
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: children,
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: children,
                                ),
                          SizedBox(height: 10),
                          IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () {
                              context.goNamed(SettingsPage.getRouteName());
                            },
                          ),
                          SizedBox(height: 10),
                          IconButton(
                            icon: Icon(Icons.logout),
                            color: Colors.red,
                            onPressed: () {
                              siteController.clearCach();
                              context.go("/");
                            },
                          ),
                          FormTextValueWidget(text: "Logout"),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
/*SideMenu(
        controller: SideMenuController(),
        title: Image(
          image: siteController.getSiteLogo(),
          width: 100,
          height: 100,
          fit: BoxFit.contain,
        ),
        style: SideMenuStyle(
          backgroundColor: Colors.white,
          // showTooltip: false,
          displayMode: SideMenuDisplayMode.open,
          hoverColor: Color_DrawerHover,
          selectedColor: Color_SideMenuFocus,
          unselectedTitleTextStyle:
              TextStyle(fontSize: 16, fontFamily: Inter_SemiBold),
          selectedTitleTextStyle:
              TextStyle(fontSize: 20, fontFamily: Inter_Bold),
          selectedIconColor: Colors.red,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.all(Radius.circular(10)),
          // ),
          // backgroundColor: Colors.blueGrey[700]
        ),
        items: PagesController.DrawerItems(),
      )*/
