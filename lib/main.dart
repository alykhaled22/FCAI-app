import 'package:fcai_app/core/services/hive_service.dart';
import 'package:fcai_app/fcai_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xffFFFFFF),
    systemNavigationBarColor: Color(0xffFFFFFF),
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));

  await HiveService().init(); 
  runApp(const FCAIApp());
}
