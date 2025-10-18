import 'package:calculix/core/shared_widgets/principal_rectangular_button.dart';
import 'package:calculix/presentation/auth/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  @override
  Widget build(BuildContext context) {

    final user = ref.read(authNotifierProvider).user!;

    return Scaffold(
      body: principalRectangularButton(onPressed: () {
        Navigator.pushReplacementNamed(context, "/profile");
      }, context: context),
    );
  }
}