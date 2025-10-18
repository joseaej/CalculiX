import 'package:calculix/presentation/auth/login_page.dart';
import 'package:calculix/presentation/auth/register_page.dart';
import 'package:calculix/presentation/home/home_page.dart';
import 'package:calculix/presentation/profile/profile_page.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/login':(_)=> LoginPage(),
  '/register':(_)=> RegisterPage(),
  '/profile':(_)=> ProfilePage(),
  '/home':(_)=> HomePage(),
};

String initialRoute = "/register";