import 'package:flutter/material.dart';

TextFormField rectangularTextField({
  required TextEditingController controller,
  String label="Email",
  String hintText="Email",
  IconData prefixIcon = Icons.email
}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    obscureText: false,
    decoration: InputDecoration(
      labelText: label,
      hintText: hintText,
      prefixIcon: Icon(prefixIcon),
    ),
  );
}

TextFormField rectangularPasswordTextField({
  required TextEditingController controller,

  bool obscureText = true,
  required Icon icon,
  Function()? onPressed,
}) {
  return TextFormField(
    controller: controller,

    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: 'Password',
      hintText: 'Password',
      prefixIcon: const Icon(Icons.lock),
      suffixIcon: IconButton(onPressed: onPressed, icon: icon),
    ),
  );
}
