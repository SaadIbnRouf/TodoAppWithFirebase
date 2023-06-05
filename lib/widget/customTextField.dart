import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController editingController;
  final String labelText;
  final bool isObscure;
  final String? Function(String?) textFieldValidator;
  final Icon? prefixIcon;
  const CustomTextField(
      {Key? key,
      required this.editingController,
      required this.labelText,
      this.isObscure = false,
      required this.textFieldValidator,
      this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      controller: editingController,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
      ),
      validator: textFieldValidator,
    );
  }
}
