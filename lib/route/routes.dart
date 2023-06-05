import 'package:flutter/material.dart';
import 'package:todoappwithfirebase/view/authView/loginPageView.dart';
import 'package:todoappwithfirebase/view/authView/registerPageView.dart';
import 'package:todoappwithfirebase/view/blogView/blogListView.dart';
import 'package:todoappwithfirebase/view/todoView/todoAppBarView.dart';

class RouteManager {
  static const String loginPage = '/loginPage';
  static const String registerPage = '/registerPage';
  static const String todoPage = '/todoPage';
  static const String blogPage = '/blogPage';

  static final Map<String, Widget Function(BuildContext)> routes = {
    loginPage: (_) => const LoginPageView(),
    todoPage: (_) => const TodoAppBarView(),
    registerPage: (_) => const RegisterPageView(),
    blogPage: (_) => const BlogListView(),
  };
}
