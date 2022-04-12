import 'package:flutter/material.dart';
import 'package:NotNetflix-Flutter/components/form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: RegisterForm(),
      ),
    );
  }
}
