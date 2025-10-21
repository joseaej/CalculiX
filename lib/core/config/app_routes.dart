import 'package:calculix/presentation/auth/auth_checker.dart';
import 'package:calculix/presentation/auth/login_page.dart';
import 'package:calculix/presentation/auth/register_page.dart';
import 'package:calculix/presentation/home/home_page.dart';
import 'package:calculix/presentation/playground.dart';
import 'package:calculix/presentation/profile/profile_page.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/login':(_)=> LoginPage(),
  '/register':(_)=> RegisterPage(),
  '/profile':(_)=> ProfilePage(),
  '/home':(_)=> HomePage(),
  '/auth_checker':(_)=> AuthChecker(),
  '/play_ground':(_)=> Playground(),
};

String initialRoute = "/auth_checker";