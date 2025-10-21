import 'package:calculix/core/shared_widgets/buttons/animated_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Playground extends StatefulWidget {
  const Playground({super.key});

  @override
  State<Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MinimalistOutlineButton(onPressed: () {
        
      },text: "dsad",width: 10.w,height: 5.h,)
    );
  }
}
