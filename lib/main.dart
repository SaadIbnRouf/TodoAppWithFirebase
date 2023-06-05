import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todoappwithfirebase/route/routes.dart';
import 'package:todoappwithfirebase/view/authView/loginPageView.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      'pk_test_51NFTDaITDwxwMoiGJbZ4lghSGl4uDs6bKh1YZYybz37jkiI542CZ9y9S1EmYovfb6TeTgWaawaLEYy0Y5cU3zGDO004hS058s2';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Todo App',
      routes: RouteManager.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LoginPageView(),
    );
  }
}
