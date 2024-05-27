import 'package:flutter/material.dart';

class AddFoodTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  const AddFoodTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.validator,
  }) : super(key: key);

  @override
  _AddFoodTextFieldState createState() => _AddFoodTextFieldState();
}

class _AddFoodTextFieldState extends State<AddFoodTextField> {
  late String _errorText; // Initialize _errorText here

  @override
  void initState() {
    super.initState();
    _errorText = ''; // Initialize _errorText with an empty string
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            hintText: widget.hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.tertiary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.tertiary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            errorText: _errorText,
          ),
          validator: (value) {
            setState(() {
              _errorText = widget.validator != null
                  ? widget.validator!(value) ?? ''
                  : '';
            });
            return null;
          },
        ),
      ),
    );
  }
}
