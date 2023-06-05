import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todoappwithfirebase/route/routes.dart';
import 'package:todoappwithfirebase/service/authService.dart';
import 'package:todoappwithfirebase/widget/customButtonField.dart';
import 'package:todoappwithfirebase/widget/customTextField.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRegistered = false;
  bool shouldNavigate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
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
                  textFieldValidator: emailValidation,
                  prefixIcon: const Icon(Icons.email),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  isObscure: true,
                  editingController: _passwordController,
                  labelText: 'Password',
                  textFieldValidator: passwordValidation,
                  prefixIcon: const Icon(Icons.lock),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButtonField(
                    textLabel: 'Submit', onPressedExecution: onLogin),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(
                  TextSpan(
                      text: "Don't have an accout? ",
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                      children: [
                        TextSpan(
                          text: ' Sign Up',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, RouteManager.registerPage);
                            },
                        ),
                      ]),
                ),
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

  void onLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // Loader.showLoadingDialog(context, _loaderKey);
    shouldNavigate = (await AuthService.loginWithEmailAndPassword(
        _emailController.text, _passwordController.text))!;

    if (shouldNavigate) {
      // Navigator.of(_loaderKey.currentContext!, rootNavigator: true).pop();
      Navigator.pushNamed(context, RouteManager.todoPage);
    }
  }
}
