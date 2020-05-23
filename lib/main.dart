import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpicks/homePage.dart';
import 'package:wallpicks/model/wallpaperdata.dart';
import 'package:wallpicks/overviewPage.dart';
import './SearchClass.dart';
import 'favour.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(ctx)=>FireArray(),
      child: MaterialApp(
        routes:{
          "/Overview":(ctx)=>Overview(),
          "/":(ctx)=>HomePage(),
          "/Favour":(ctx)=>Favour(),

        },
      ),
    );
  }
}

