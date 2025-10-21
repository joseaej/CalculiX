import 'package:calculix/presentation/auth/auth_notifier.dart';
import 'package:calculix/presentation/auth/login_page.dart';
import 'package:calculix/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculix/data/models/auth_state.dart';


class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Escucha el estado de autenticación
    final authState = ref.watch(authNotifierProvider);

    // 2. Decide qué widget mostrar basado en el estado
    switch (authState.status) {
      case AuthStatus.authenticated:
        // Si está autenticado, muestra la página de inicio
        return const HomePage();
        
      case AuthStatus.unauthenticated:
      case AuthStatus.error:
        // Si no está autenticado o hay un error, muestra la página de login
        return const LoginPage();

      case AuthStatus.loading:
      case AuthStatus.initial:
      // Mientras carga o en el estado inicial, muestra un indicador de progreso
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
    }
  }
}
