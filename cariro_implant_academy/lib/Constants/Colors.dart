import 'dart:ui';

import 'package:flutter/material.dart';

Color Color_Background = Color(0xFFF4F6FA);
Color Color_Accent = Color(0xFFA4BF69);
Color Color_DrawerHover = Color_Accent.withAlpha(50);
Color Color_TextSecondary = Color(0xFF6D6F74);
Color Color_TextHint = Color(0xFFAEAEAE);
Color Color_TextFieldBorder = Color(0xFFA1A2A6);
Color Color_TextWhite = Color(0xFFFFFFFF);
Color Color_TextPrimary = Color(0xFF000000);
Color Color_SideMenuFocus = Color(0xFFECF5F4);

switchTheme(String site) {
  switch (site) {
    case "CIA":
      {
        Color_Background = Color(0xFFF4F6FA);
        Color_Accent = Color(0xFFA4BF69);
        Color_DrawerHover = Color_Accent.withAlpha(50);
        Color_TextSecondary = Color(0xFF6D6F74);
        Color_TextHint = Color(0xFFAEAEAE);
        Color_TextFieldBorder = Color(0xFFA1A2A6);
        Color_TextWhite = Color(0xFFFFFFFF);
        Color_TextPrimary = Color(0xFF000000);
        Color_SideMenuFocus = Color(0xFFECF5F4);
        break;
      }
    case "LAB":
      {
        Color_Background = Color(0xFFF4F6FA);
        Color_Accent = Color(0xFF816C46);
        Color_DrawerHover = Colors.white;
        Color_TextSecondary = Color(0xFF6D6F74);
        Color_TextHint = Color(0xFFAEAEAE);
        Color_TextFieldBorder = Color(0xFFA1A2A6);
        Color_TextWhite = Color(0xFFFFFFFF);
        Color_TextPrimary = Color(0xFF000000);
        Color_SideMenuFocus = Colors.white;
        break;
      }
    case "Clinic":
      {
        Color_Background = Colors.white;
        Color_Accent = Color(0xFF2278f9);
        Color_DrawerHover = Color_Accent.withAlpha(50);
        Color_TextSecondary = Color(0xFF6D6F74);
        Color_TextHint = Color(0xFFAEAEAE);
        Color_TextFieldBorder = Color(0xFFA1A2A6);
        Color_TextWhite = Color(0xFFFFFFFF);
        Color_TextPrimary = Color(0xFF000000);
        Color_SideMenuFocus = Colors.white;
        break;
      }
  }
}
