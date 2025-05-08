import 'package:flutter/material.dart';

import 'colors.dart';

var lightTheme = ThemeData(
  brightness:Brightness.light,
  useMaterial3:true,
  appBarTheme:const AppBarTheme(
    centerTitle:true,
    backgroundColor:Color(0xffb4d8e5),
  ),
  colorScheme:ColorScheme.light(
      brightness:Brightness.light,
      primary:primaryColor,
      onPrimary:onPrimaryColor,
      secondary:secondaryColor,
      onSecondary:onSecondaryColor,
      surface:Colors.white,
      onSurface:onSurfaceColor
  ),
  textTheme:const TextTheme(
    bodyLarge:TextStyle(
      fontFamily:'Lora',
      fontSize:20,
      fontWeight:FontWeight.w600,
      color:Colors.black
    ),
    bodyMedium:TextStyle(
        fontFamily:'Lora',
        fontSize:15,
        fontWeight:FontWeight.w500,
        color:Colors.black
    ),
    bodySmall:TextStyle(
        fontFamily:'Lora',
        fontSize:12,
        fontWeight:FontWeight.w400,
        color:Colors.black
    ),
    headlineLarge:TextStyle(
        fontFamily:'Lora',
        fontSize:22,
        fontWeight:FontWeight.w500,
        color:Colors.black
    ),
    headlineMedium:TextStyle(
        fontFamily:'Lora',
        fontSize:20,
        fontWeight:FontWeight.w500,
        color:Colors.black
    ),
    headlineSmall:TextStyle(
        fontFamily:'Lora',
        fontSize:15,
        fontWeight:FontWeight.w500,
        color:Colors.black
    ),
    labelLarge:TextStyle(
        fontFamily:'Lora',
        fontSize:15,
        fontWeight:FontWeight.w500,
        // color:Colors.black
    ),
    labelMedium:TextStyle(
        fontFamily:'Lora',
        fontSize:12,
        fontWeight:FontWeight.w500,
        color:Colors.black
    ),
    labelSmall:TextStyle(
        fontFamily:'Lora',
        fontSize:10,
        fontWeight:FontWeight.w500,
        color:Colors.black
    ),
  ),
);