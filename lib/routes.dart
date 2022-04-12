import 'package:flutter/material.dart';
import 'package:notnetflix-flutter/screens/auth/register.dart';
import 'package:notnetflix-flutter/screens/home.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/register': (context) => const RegisterScreen(),
  '/': (context) => const MyHomePage(title: 'Flutter'),
  '/other': (context) => Scaffold(
        appBar: AppBar(),
      ),
};
