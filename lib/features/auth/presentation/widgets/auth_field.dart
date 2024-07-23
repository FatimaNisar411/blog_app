import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller; // Add this line
  final bool isObscureText;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller, // Add this line
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // Add this line
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$hintText is missing";
        }
        return null;
      },
      obscureText: isObscureText,
    );
  }
}
