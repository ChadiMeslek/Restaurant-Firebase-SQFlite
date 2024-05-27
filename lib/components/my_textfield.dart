import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10), // Add vertical margin
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20), // Add horizontal padding
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), // Set border radius
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), // Set border radius
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), // Set border radius
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
