import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Helpers/ResponsiveWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSize topNavigationBar(
    BuildContext context, GlobalKey<ScaffoldState> key) {
  return PreferredSize(
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: ResponsiveWidget.isLargeScreen(context)
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Image(
                          image: AssetImage("CIA_Logo3.png"),
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              key.currentState?.openDrawer();
                            },
                            icon: Icon(Icons.menu)),
                      ],
                    ),
            ),
          ),
          Expanded(
              flex: 5,
              child: Container(
                color: Color_Background,
                child: Row(
                  children: [
                    Expanded(flex:4,child: Container()),
                    Expanded(flex:4,child: Container()),
                    Expanded(child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Settings", style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold
                        ),),
                        Image(image: AssetImage("user.png"),
                          width: 50,
                          height: 50,

                        )
                      ],
                    )),
                    
                  ],
                ),
              ))
        ],
      ),
      preferredSize: Size.fromHeight(70));
}
