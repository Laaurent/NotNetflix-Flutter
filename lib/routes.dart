import 'package:flutter/material.dart';
import 'package:not_netflix/screens/auth/login.dart';
import 'package:not_netflix/screens/auth/register.dart';
import 'package:not_netflix/screens/auth/profile.dart';
import 'package:not_netflix/screens/home.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/register': (context) => const RegisterScreen(),
  '/login': (context) => const LoginScreen(),
  '/': (context) => const Home(),
  '/profile': (context) => Profile(),
  '/other': (context) => Scaffold(
        appBar: AppBar(),
      ),
};
