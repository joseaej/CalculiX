

import 'package:calculix/core/config/app_colors.dart';
import 'package:flutter/material.dart';

class MinimalistOutlineButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final double width;
  final double height;
  final double borderWidth;

  const MinimalistOutlineButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color = AppColors.primaryBlue,
    this.width = 200.0,
    this.height = 50.0,
    this.borderWidth = 2.0,
  });

  @override
  State<MinimalistOutlineButton> createState() => _MinimalistOutlineButtonState();
}

class _MinimalistOutlineButtonState extends State<MinimalistOutlineButton> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
    widget.onPressed();
  }
  
  void _onPointerCancel(PointerCancelEvent event) {
      setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isPressed ? 0.96 : 1.0,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      child: Listener(
        onPointerDown: _onPointerDown,
        onPointerUp: _onPointerUp,
        onPointerCancel: _onPointerCancel,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: _isPressed ? widget.color : Colors.transparent,
            border: Border.all(
              color: widget.color,
              width: widget.borderWidth,
            ),
          ),
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 150),
              style: TextStyle(
                color: _isPressed ? Colors.white : widget.color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              child: Text(widget.text),
            ),
          ),
        ),
      ),
    );
  }
}