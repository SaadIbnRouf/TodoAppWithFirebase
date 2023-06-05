import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todoappwithfirebase/service/authService.dart';
import 'package:todoappwithfirebase/widget/customButtonField.dart';
import 'package:todoappwithfirebase/widget/customTextField.dart';
import '../../route/routes.dart';

class RegisterPageView extends StatefulWidget {
  const RegisterPageView({Key? key}) : super(key: key);

  @override
  State<RegisterPageView> createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<RegisterPageView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRegistered = false;
  bool shouldNavigate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                    editingController: _emailController,
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_rounded),
                    textFieldValidator: emailValidation),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    editingController: _passwordController,
                    labelText: 'Password',
                    isObscure: true,
                    prefixIcon: Icon(Icons.lock),
                    textFieldValidator: passwordValidation),
                const SizedBox(
                  height: 15,
                ),
                CustomButtonField(
                    textLabel: 'Submit', onPressedExecution: onSignup),
                const SizedBox(
                  height: 15,
                ),
                Text.rich(TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                    children: [
                      TextSpan(
                        text: ' Sign In',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(
                                context, RouteManager.loginPage);
                          },
                      ),
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? emailValidation(String? value) {
    if (value!.isEmpty && (value.contains('@'))) {
      return 'Please enter email';
    }
    return null;
  }

  String? passwordValidation(String? value) {
    if (value!.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void onSignup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    isRegistered = (await AuthService.registerWithEmailAndPassword(
        _emailController.text, _passwordController.text))!;
    if (isRegistered) {
      Navigator.pushNamed(context, RouteManager.loginPage);
    }
  }
}
