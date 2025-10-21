
import 'package:calculix/presentation/auth/auth_notifier.dart';
import 'package:calculix/presentation/auth/login_page.dart';
import 'package:calculix/presentation/connection/no_connection_page.dart';
import 'package:calculix/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculix/data/models/auth_state.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class AuthChecker extends ConsumerStatefulWidget {
  const AuthChecker({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends ConsumerState<AuthChecker> {
  bool _isConnectedToIntertnet = false;
  @override
  void initState() {
    super.initState();
    InternetConnection().onStatusChange.listen((event) {
      switch (event) {
        case InternetStatus.connected:
          setState(() {
            _isConnectedToIntertnet = true;
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            _isConnectedToIntertnet = false;
          });
          break;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    if (_isConnectedToIntertnet) {
      final authState = ref.watch(authNotifierProvider);
      switch (authState.status) {
        case AuthStatus.authenticated:
          return const HomePage();

        case AuthStatus.unauthenticated:
        case AuthStatus.error:
          return const LoginPage();

        case AuthStatus.loading:
        case AuthStatus.initial:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
      }
    }else{
      return NoConnectionPage();
    }
  }
}
