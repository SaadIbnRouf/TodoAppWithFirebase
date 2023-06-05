import 'package:flutter/material.dart';

class CustomButtonField extends StatelessWidget {
  final String textLabel;
  final Function() onPressedExecution;
  const CustomButtonField({
    Key? key,
    required this.textLabel,
    required this.onPressedExecution,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(15.0),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            Colors.white12,
          ),
        ),
        onPressed: onPressedExecution,
        child: Text(
          textLabel,
          style: const TextStyle(
            fontSize: 16.0,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
